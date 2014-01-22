% a connection exists if there is a door from one door to another one or viceversa
connect(DoorOut,DoorIn) :- door(DoorOut,DoorIn).
connect(DoorIn,DoorOut) :- door(DoorOut,DoorIn).

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
