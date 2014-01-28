% list all of the rooms!
room(kitchen).
room(office).
room('dining room').
room(hall).
room(cellar).

/*
 * all the objects are declared by the object/4 structure:
 * - object name
 * - color
 * - size
 * - weight
 */
object(desk, brown, big, 30).
object(apple, yellow, small, 1).
object(flashlight, black, small, 2).
object('washing machine', grey, big, 40).
object(nani, grey, small, 2).
object(broccoli, green, small, 3).
object(crackers, yellow, small, 1).
object(computer, grey, small, 10).
object(envelope, white, small, 0.2).
object(stamp, blue, small, 0.1).
object(key, grey, small, 0.2).

% list of all the objects and related locations (dinamically so we can remove some)
:- dynamic location/2.
location(object(desk, brown, big, 30), office).
location(object(apple, yellow, small, 1), kitchen).
location(object(flashlight, black, small, 2), desk).
location(object('washing machine', grey, big, 40), cellar).
location(object(nani, grey, small, 2), 'washing machine').
location(object(broccoli, green, small, 3), kitchen).
location(object(crackers, yellow, small, 1), kitchen).
location(object(computer, grey, small, 10), office).
% list of nested locations
location(object(envelope, white, small, 0.2), desk).
location(object(stamp, blue, small, 0.1), envelope).
location(object(key, grey, small, 0.2), envelope).

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
edible(object(apple, _, _, _)).
edible(object(crackers, _, _, _)).

% me likey them broccoli
tastes_yucky(object(broccoli, _, _, _)).

% at the beginning, the flashlight is off
:- dynamic turned_off/1.
turned_off(object(flashlight, _, _, _)).

% the player is in the kitchen (dinamically so we can remove some)
:- dynamic here/1.
here(kitchen).