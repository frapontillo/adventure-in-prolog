% put/1 retracts a have/1 clause and asserts a location/2 clause in the current room
put(Item) :- can_put(Item), put_object(Item).

can_put(Item) :- have(Item), !.
can_put(Item) :- write('You don''t have any '), write(Item), nl, fail.

put_object(Item) :-
	retract(have(Item)),				% delete Item from inventory
	here(Place),						% get the current Place
	loc_list(List, Place),				% get the old Place item List
	append(List, Item, NewList),		% append the Item to the List, resulting in NewList
	retract(loc_list(List, Place)),		% clear the Place item List
	assertz(loc_list(NewList, Place)).	% add the Place item NewList