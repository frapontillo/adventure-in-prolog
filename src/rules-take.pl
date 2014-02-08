% have/1, has one clause for each thing the game player has.
% Initially, have/1 is not defined because the player is not carrying anything.

% take/1, used by the player to grab something from the surrounding world
take(Item) :- can_take(Item), !, take_object(Item), !.

% return true if the object is contained in the CURRENT room AND it is small
can_take(Item) :-
	here(CurPlace), is_contained_in(object(Item, _, small, _), CurPlace), !.

% if the object is contained in the CURRENT room but it is not small
can_take(Item) :- here(CurPlace), is_contained_in(object(Item, _, Size, _), CurPlace), !, \=(Size, 'small'),
	write('Sorry, the object '), write(Item), write(' is too heavy.'), nl,
	list_grabbable_objects, fail.

can_take(Item) :- here(CurPlace), not(is_contained_in(object(Item, _, _, _), CurPlace)), !,
	write('Sorry, there''s no '), write(Item), write('.'), nl,
	list_grabbable_objects, fail.

list_grabbable_objects :- write('You can take:'), nl,
	here(CurPlace), is_contained_in(object(AvailableItem, _, small, _), CurPlace),
	tab(2), write('- '), write(AvailableItem), nl, fail.
list_grabbable_objects.
	
take_object(Item) :-
	asserta(have(Item)),								% take the Item
	location(object(Item, _,_,_), Container),			% get the Item Container
	loc_list(ItemList, Container),						% get the Container ItemList
	remove(ItemList, Item, NewList),					% remove the Item from the ItemList, getting NewList
	retract(loc_list(ItemList, Container)),				% remove the old loc_list from memory
	assertz(loc_list(NewList, Container)), !.			% add the NewList into memory