% list all of the rooms!
room(kitchen).
room(office).
room('dining room').
room(hall).
room(cellar).

% list of all the objects and related locations (dinamically so we can remove some)
:- assert(location(desk, office)).
:- assert(location(apple, kitchen)).
:- assert(location(flashlight, desk)).
:- assert(location('washing machine', cellar)).
:- assert(location(nani, 'washing machine')).
:- assert(location(broccoli, kitchen)).
:- assert(location(crackers, kitchen)).
:- assert(location(computer, office)).


% list of doors between rooms (one-way, for the moment)
door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

% facts about properties of things the game player might try to eat
edible(apple).
edible(crackers).

% me likey them broccoli
tastes_yucky(broccoli).

% at the beginning, the flashlight is off
turned_off(flashlight).

% the player is in the kitchen (dinamically so we can remove some)
:- asserta(here(kitchen)).