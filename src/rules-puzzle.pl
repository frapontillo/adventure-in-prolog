puzzle(goto(cellar)):-
  have(flashlight),
  not(turned_off(flashlight)),
  !.
puzzle(goto(cellar)):-
  write('It''s dark and you are afraid of the dark.'),
  !, fail.
  
puzzle(_).