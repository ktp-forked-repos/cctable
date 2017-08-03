:- use_module('../../cctable1').
:- use_module('../../ccmacros').
:- consult(swipl_common).
:- current_prolog_flag(argv, [File|_]),
   load_files(File,[]).

main(Show) :-
   case(Name, Case),
   run_case_limited(Case,_,Time1), !, garbage_collect,
   run_case_limited(Case,Result,Time2),
   report(Show, Name, [Time1,Time2], Result).

