% a connection exists if there is a door from one door to another one or viceversa
connect(DoorIn, DoorOut) :- door(DoorIn, DoorOut).
connect(DoorIn, DoorOut) :- door(DoorOut, DoorIn).

% list the adjacent rooms to a given one (fail to loop)
list_connections(Room) :- connect(Room, Next), tab(2), write(Next), nl, fail.
% after the listing ends, the loop fails, so we need to tell that the "loop" is always true
list_connections(_).