:- consult(user).
:- consult('harness/common.pl').

main(Show) :-
   case(Name, Case),
   run_case(Case,Result,Time),
   write('@ '), report(Show, bprolog, Name, Time, Result),
   halt.

run_case(ignore(Goal), ignored, Time) :-
   T1 is cputime, call(Goal), T2 is cputime, Time is (T2 - T1).

run_case(call(Goal,Res), answer(Res), Time) :-
   T1 is cputime, call(Goal), T2 is cputime, Time is (T2 - T1).

run_case(verify(Goal,Check), correct(R), Time) :-
   T1 is cputime, call(Goal), T2 is cputime, Time is (T2 - T1),
   (call(Check) -> R = true; R=false).

run_case(count(Goal), solutions(N), Time) :-
   run_case(call(findall(t,Goal,R), R), answer(Solns), Time),
   length(Solns,N).
