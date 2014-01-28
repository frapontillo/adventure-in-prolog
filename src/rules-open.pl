% the door is open if its status is opened
is_open(DoorIn, DoorOut) :- door(DoorIn, DoorOut), door_status(DoorIn, DoorOut, opened).
is_open(DoorIn, DoorOut) :- door(DoorOut, DoorIn), door_status(DoorOut, DoorIn, opened).

% open/1 opens one of the door connected to the current room
open_door(Door) :- here(CurPlace), can_open(CurPlace, Door), !, door(CurPlace, Door), !, do_open(CurPlace, Door).

% check if there is a connection between the current room and the desired place
can_open(CurPlace, Door) :- check_connection(CurPlace, Door), !, check_already_open(CurPlace, Door), !.

% check if the door is already open: if so, print a warning and still return true
check_already_open(CurPlace, Door) :- door_status(CurPlace, Door, closed).
check_already_open(_, _) :- write('The door is already open :)'), nl.

% actually opens a door
do_open(CurPlace, NewPlace) :- retract(door_status(CurPlace, NewPlace, closed)), !, asserta(door_status(CurPlace, NewPlace, opened)).
