/*
 * contains/2
 * @param A list to be searched
 * @param Element the element to look for in the list
 * @return true if the element is found in the list, false otherwise
 */
% an element is contained in a list if it's the head of the list
contains([Element | _], Element).
% an element is contained in a list if it's contained in its tail
contains([_|Tail], Element) :- contains(Tail, Element).

/*
 * append/3
 * @param A list to append the element to
 * @param The element to be appended
 * @param The resulting list
 */
% appending an element to an empty list results in a list with that only element
append([], Element, [Element]).
% appending an Element to a list made by Head|Tail results in a list with:
%  - the same Head
%  - its NewTail made by appending Tail and Element
append([Head|Tail], Element, [Head|NewTail]) :- append(Tail, Element, NewTail).

/*
 * remove/3
 * @param A list to remove the element from
 * @param The element to be removed
 * @param The resulting list
 */
% removing an Element from an empty List returns an empty list
remove([], Element, []).
% if the Element is the Head of the list, return NewTail, which is the Tail after calling remove on it again
remove([Element|Tail], Element, NewTail) :- remove(Tail, Element, NewTail), !.
% if the Element is not the Head of the list, return the original Head and a NewTail, which is the Tail after calling remove on it again
remove([Head|Tail], Element, [Head|NewTail]) :- remove(Tail, Element, NewTail).

/*
 * find_after/3
 * @param The List to search the element in
 * @param The element to search for
 * @param The element after the found one
 */
% the ElementAfter after a list made by only Element does not exist
find_after([Element], Element, After) :- false.
% if the Element is the Head of the List, get the first element of the Tail
find_after([Element|[After|_]], Element, After) :- true.
% if the Element is not the Head of the List, recursively call find_after on the Tail
find_after([Head|Tail], Element, After) :- find_after(Tail, Element, After).

/*
 * split/4
 * @param The List to split in two
 * @param The Element to search for
 * @param The First resulting list
 * @param The Second resulting list; its first element will be Element
 */
% if the Element is th Head of the List, the first list is empty, the second is the whole List
% split(List, Element, First, Second) :- split_r(List, Element, First, Second, Temp).
split([Element|Tail], Element, First, [Element|Tail]).
split([Head|Tail], Element, [FHead|FTail],
	
split_r([Element|Tail], Element, First, NewFirst, [Element|Tail]).
split_r([Head|Tail], Element, First, NewFirst, Second) :- append(First, Head, NewFirst), split_r(Tail, Element, [], NewFirst, Second).