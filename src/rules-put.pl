% put/1 retracts a have/1 clause and asserts a location/2 clause in the current room
put(Item) :- can_put(Item), put_object(Item).

can_put(Item) :- have(Item), !.
can_put(Item) :- write('You don''t have any '), write(Item), nl, fail.

put_object(Item) :- here(Place), retract(have(Item)), asserta(location(object(Item, _, _, _), Place)).