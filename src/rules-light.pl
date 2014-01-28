% turn_on/1 and turn_off/1 will be used to turn the flashlight on or off
turn_on(Light) :- retract(turned_off(Light)), check_light(Light).
turn_off(Light) :- asserta(turned_off(Light)), check_light(Light).

% check the light situation
check_light(Light) :- turned_off(Light), write('The light '), write(Light), write(' is off.'), nl, !.
check_light(Light) :- write('The light '), write(Light), write(' is on.'), nl.