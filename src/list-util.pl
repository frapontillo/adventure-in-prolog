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
remove([], _, []).
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
find_after([Element], Element, _) :- false.
% if the Element is the Head of the List, get the first element of the Tail
find_after([Element|[After|_]], Element, After) :- true.
% if the Element is not the Head of the List, recursively call find_after on the Tail
find_after([_|Tail], Element, After) :- find_after(Tail, Element, After).

/*
 * split/4
 * @param The List to split in two
 * @param The Element to search for
 * @param The First resulting list
 * @param The Second resulting list; its first element will be Element
 */
split(List, Element, First, Second) :- findall(X, split_get_first(List, Element, X), First), split_get_second(List, Element, Second).

% If the Element is the Head, do nothing.
split_get_first([Element|_], Element, Element) :- fail.
% Return the Head of the list if it is different that the Element to search for
split_get_first([Head|_], Element, Head) :- Element \= Head.
% Then, analyze the remaining part of the list (the Tail)
split_get_first([Head|Tail], Element, X) :- Element \= Head, split_get_first(Tail, Element, X).

% if the Head matches the Element, return the whole list
split_get_second([Element|Tail], Element, [Element|Tail]) :- !.
% if the Element does no match the Head, appy the split to the Tail
split_get_second([Head|Tail], Element, List) :- Head \= Tail, split_get_second(Tail, Element, List).

/*
 * get_last/2 Get the last element of a list
 * @param List The List to search for
 * @param Element The last element of the List
 */
get_last([Element], Element) :- !.
get_last([_|Tail], Element) :- get_last(Tail, Element).

/*
 * size/2 Count the elements in a list
 * @param List The List to count
 * @param Count The List Count
 */
size([], 0) :- !.
size([_], 1) :- !.
size([Head|Tail], Count) :- size([Head], A), size(Tail, B), Count is (A+B), !.

/*
 * respond/1 Prints a List of terms
 * @param List The List to write
 */
respond([]) :- !.
respond([Head|Tail]) :- write(Head), respond(Tail).
