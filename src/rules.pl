% a connection exists if there is a door from one door to another one or viceversa
connect(DoorIn, DoorOut) :- door(DoorIn, DoorOut).
connect(DoorIn, DoorOut) :- door(DoorOut, DoorIn).

% the door is open if its status is opened
is_open(DoorIn, DoorOut) :- door(DoorIn, DoorOut), door_status(DoorIn, DoorOut, opened).
is_open(DoorIn, DoorOut) :- door(DoorOut, DoorIn), door_status(DoorOut, DoorIn, opened).

where_food(Food, Location) :- location(Food, Location), edible(Food).
exists_food(Food) :- where_food(Food, ?).

% list the elements in a given room (fail is needed to loop through the whole KB)
list_things(Room) :- is_contained_in(Item, Room), tab(2), write(Item), nl, fail.
% after the listing ends, the loop fails, so we need to tell that the "loop" is always true
list_things(_).

% list the adjacent rooms to a given one (fail to loop)
list_connections(Room) :- connect(Room, Next), tab(2), write(Next), nl, fail.
% after the listing ends, the loop fails, so we need to tell that the "loop" is always true
list_connections(_).

% tell the game player where he or she is, what things are in the room, and which rooms are adjacent
look :- here(Here), write('You are in the '), write(Here), write('.'), nl,
	write('Here''s what you can find: '), nl, list_things(Here),
	write('You can now go to: '), nl, list_connections(Here).
	
look_in(Place) :- write(Place), write(' contains the following items:'), nl,
	list_things(Place), nl.

% go to a new place
goto(Place) :- can_go(Place), move(Place), look.

% checks if the player can move to another room
% as soon as a connection is found, cut the rule (stop and be satisfied with the found value)
can_go(Place) :- here(CurPlace), check_connection(Place, CurPlace), !, check_open(Place, CurPlace), !.

% check if there is a connection between the two rooms
check_connection(CurPlace, Place) :- connect(CurPlace, Place), !.
% if the previous can_go rule fails, we print a message and still fail
check_connection(CurPlace, Place) :-
	write('Sorry, you can''t go from the '), write(CurPlace), write(' to the '), write(Place), nl,
	write('You can go to:'), nl, list_connections(CurPlace), nl,
	fail.

% check if the door is opened
check_open(PlaceIn, PlaceOut) :- is_open(PlaceIn, PlaceOut).
% if the previous rule fails, print an error message
check_open(PlaceIn, PlaceOut) :-
	write('The door between the '), write(PlaceOut), write(' and the '),
	write(PlaceIn), write(' is closed. Sorry.'), nl, fail.

% move to another room, by removing the old here(...) rule and by adding the new one
move(Place) :- retract(here(_)), asserta(here(Place)).

% have/1, has one clause for each thing the game player has.
% Initially, have/1 is not defined because the player is not carrying anything.

% take/1, used by the player to grab something from the surrounding world
take(Item) :- can_take(Item), take_object(Item).

can_take(Item) :- here(CurPlace), is_contained_in(Item, CurPlace), !.
can_take(Item) :-
	write('Sorry, you can''t take the '), write(Item), nl,
	write('You can take:'), nl,
	here(CurPlace), location(AvailableItem, CurPlace),
	tab(2), write('- '), write(AvailableItem), nl,
	fail.

take_object(Item) :- asserta(have(Item)), retract(location(Item, _)).

% put/1 retracts a have/1 clause and asserts a location/2 clause in the current room
put(Item) :- can_put(Item), put_object(Item).

can_put(Item) :- have(Item), !.
can_put(Item) :- write('You don''t have any '), write(Item), nl, fail.

put_object(Item) :- here(Place), retract(have(Item)), asserta(location(Item, Place)).

% inventory/0 lists the have/1 things
inventory :-
	write('You have the following items:'), nl, have(X),
	tab(2), write('- '), write(X), nl,
	fail.
	
inventory.

% turn_on/1 and turn_off/1 will be used to turn the flashlight on or off
turn_on(Light) :- retract(turned_off(Light)), check_light(Light).
turn_off(Light) :- asserta(turned_off(Light)), check_light(Light).

% check the light situation
check_light(Light) :- turned_off(Light), write('The light '), write(Light), write(' is off.'), nl, !.
check_light(Light) :- write('The light '), write(Light), write(' is on.'), nl.

% open/1 opens one of the door connected to the current room
open_door(Door) :- here(CurPlace), can_open(CurPlace, Door), !, door(CurPlace, Door), !, do_open(CurPlace, Door).

% check if there is a connection between the current room and the desired place
can_open(CurPlace, Door) :- check_connection(CurPlace, Door), !, check_already_open(CurPlace, Door), !.

% check if the door is already open: if so, print a warning and still return true
check_already_open(CurPlace, Door) :- door_status(CurPlace, Door, closed).
check_already_open(_, _) :- write('The door is already open :)'), nl.

% actually opens a door
do_open(CurPlace, NewPlace) :- retract(door_status(CurPlace, NewPlace, closed)), !, asserta(door_status(CurPlace, NewPlace, opened)).

% close/1 closes one of the door connected to the current room
close_door(Door) :- here(CurPlace), can_close(CurPlace, Door), door(CurPlace, Door), !, do_close(CurPlace, Door).

% check if there is a connection between the current room and the desired place
can_close(CurPlace, Door) :- check_connection(CurPlace, Door), !, check_already_close(CurPlace, Door), !.

% check if the door is already closed: if so, print a warning and still return true
check_already_close(CurPlace, Door) :- door_status(CurPlace, Door, opened).
check_already_close(_, _) :- write('The door is already closed :)'), nl.

% actually closes a door
do_close(CurPlace, NewPlace) :- retract(door_status(CurPlace, NewPlace, opened)), !, asserta(door_status(CurPlace, NewPlace, closed)).

% recursive definition of containment
is_contained_in(Object, Container) :- location(Object, Container).
is_contained_in(Object, Container) :- location(X, Container), is_contained_in(Object, X).