%% ------------------- %%
%%  MY ADVENTURE GAME  %%
%% ------------------- %%

:- [
	'list-util.pl',
	'kb.pl',
	'rules-items.pl', 'rules-connection.pl',
	'rules-light.pl',
	'rules-open.pl', 'rules-close.pl', 'rules-move.pl',
	'rules-take.pl', 'rules-put.pl',
	'operators.pl',
	'rules-puzzle.pl'
	].
	
command_loop:- 
  write('Welcome to Nani Search'), nl,
  repeat,
  write('nani> '),
  read(X),
  puzzle(X),
  do_once(X), nl,
  end_condition(X).

do(goto(X)) :- goto(X), !.
do(go(X)) :- goto(X), !.
do(inventory) :- inventory, !.
do(look) :- look, !.
do(open_door(X)) :- open_door(X), !.
do(take(X)) :- take(X), !.
do(end) :- !.
do(X) :- write('Invalid command '), write(X).

do_once(X) :- do(X), !.
  
end_condition(end).
end_condition(_) :-
  have(nani),
  write('Congratulations!').