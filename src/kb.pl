% list all of the rooms!
room(kitchen).
room(office).
room('dining room').
room(hall).
room(cellar).

% list of all the objects and related locations (dinamically so we can remove some)
:- dynamic location/2.
location(desk, office).
location(apple, kitchen).
location(flashlight, desk).
location('washing machine', cellar).
location(nani, 'washing machine').
location(broccoli, kitchen).
location(crackers, kitchen).
location(computer, office).
% list of nested locations
location(envelope, desk).
location(stamp, envelope).
location(key, envelope).

% list of doors between rooms (one-way, for the moment)
door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

% door statuses, in the beginning they are all closed
:- dynamic door_status/3.
:- door(In, Out), asserta(door_status(In, Out, closed)), fail.

% facts about properties of things the game player might try to eat
edible(apple).
edible(crackers).

% me likey them broccoli
tastes_yucky(broccoli).

% at the beginning, the flashlight is off
:- dynamic turned_off/1.
turned_off(flashlight).

% the player is in the kitchen (dinamically so we can remove some)
:- dynamic here/1.
here(kitchen).