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