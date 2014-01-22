% list all of the rooms!
room(kitchen).
room(office).
room('dining room').
room(hall).
room(cellar).

% list of all the objects and related locations
location(desk, office).
location(apple, kitchen).
location(flashlight, desk).
location('washing machine', cellar).
location(nani, 'washing machine').
location(broccoli, kitchen).
location(crackers, kitchen).
location(computer, office).

% list of doors between rooms (one-way, for the moment)
door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

% facts about properties of things the game player might try to eat
edible(apple).
edible(crackers).
tastes_yucky(broccoli).

% at the beginning, the flashlight is off
turned_off(flashlight).
% the player is in the kitchen
here(kitchen).