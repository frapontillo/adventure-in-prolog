% close/1 closes one of the door connected to the current room
close_door(Door) :- here(CurPlace), can_close(CurPlace, Door), door(CurPlace, Door), !, do_close(CurPlace, Door).

% check if there is a connection between the current room and the desired place
can_close(CurPlace, Door) :- check_connection(CurPlace, Door), !, check_already_close(CurPlace, Door), !.

% check if the door is already closed: if so, print a warning and still return true
check_already_close(CurPlace, Door) :- door_status(CurPlace, Door, opened).
check_already_close(_, _) :- write('The door is already closed :)'), nl.

% actually closes a door
do_close(CurPlace, NewPlace) :- retract(door_status(CurPlace, NewPlace, opened)), !, asserta(door_status(CurPlace, NewPlace, closed)).