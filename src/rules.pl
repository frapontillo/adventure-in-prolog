% a connection exists if there is a door from one door to another one or viceversa
connect(DoorIn, DoorOut) :- door(DoorIn, DoorOut).
connect(DoorIn, DoorOut) :- door(DoorOut, DoorIn).

where_food(Food, Location) :- location(Food, Location), edible(Food).
exists_food(Food) :- where_food(Food, ?).

% list the elements in a given room (fail is needed to loop through the whole KB)
list_things(Room) :- location(Item, Room), tab(2), write(Item), nl, fail.
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
can_go(Place) :- here(CurPlace), connect(Place, CurPlace), !.

% if the previous can_go rule fails, we print a message and still fail
can_go(Place) :-
	write('Sorry, you can''t go to the '), write(Place), nl,
	write('You can go to:'), nl, here(CurPlace), list_connections(CurPlace), nl,
	fail.

% move to another room, by removing the old here(...) rule and by adding the new one
move(Place) :- retract(here(CurPlace)), asserta(here(Place)).

% have/1, has one clause for each thing the game player has.
% Initially, have/1 is not defined because the player is not carrying anything.

% take/1, used by the player to grab something from the surrounding world
take(Item) :- can_take(Item), take_object(Item).

can_take(Item) :- here(CurPlace), location(Item, CurPlace), !.
can_take(Item) :-
	write('Sorry, you can''t take the '), write(Item), nl,
	write('You can take:'), nl,
	here(CurPlace), location(AvailableItem, CurPlace),
	tab(2), write('- '), write(AvailableItem), nl,
	fail.

take_object(Item) :- asserta(have(Item)), retract(location(Item, _)).