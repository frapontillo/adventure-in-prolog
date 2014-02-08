where_food(Food, Location) :- location(object(Food, _, _, _), Location), edible(object(Food, _, _, _)).
exists_food(Food) :- where_food(Food, ?).

% recursive definition of containment
% or the Object is contained in AnotherContainer, which is contained in the original Container
is_contained_in(object(Object, Color, Size, Weight), Container) :-
	location(object(Object, Color, Size, Weight), AnotherContainer),
	is_contained_in(object(AnotherContainer, _, _, _), Container).
% either the Object is directly contained in its Container
is_contained_in(object(Object, Color, Size, Weight), Container) :- location(object(Object, Color, Size, Weight), Container).
% syntactic alias for is_contained_in
is_in(Object, Container) :- is_contained_in(object(Object, _, _, _), Container).

% list the elements in a given room (fail is needed to loop through the whole KB)
list_things(Room) :- is_contained_in(object(Item, _, _, Weight), Room), object(Item, _, _, Weight), tab(2), write(Item), write_weight(Weight), nl, fail.
% after the listing ends, the loop fails, so we need to tell that the "loop" is always true
list_things(_).

write_weight(Weight) :- Weight =< 1, write(' ('), write(Weight), write(' kg)').
write_weight(Weight) :- Weight > 1, write(' ('), write(Weight), write(' kgs)').

% tell the game player where he or she is, what things are in the room, and which rooms are adjacent
look :- here(Here), write('You are in the '), write(Here), write('.'), nl,
	write('Here''s what you can find: '), nl, list_things(Here),
	write('You can now go to: '), nl, list_connections(Here).
look_in(Place) :- write(Place), write(' contains the following items:'), nl,
	list_things(Place), nl.

% inventory/0 lists the have/1 things
inventory :-
	write('You have the following items:'), nl, have(X),
	tab(2), write('- '), write(X), nl,
	fail.
inventory.