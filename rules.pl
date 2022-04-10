pay(F, L, P) :- commission(F, L, Min, Sales, Crate),
    Sales * Crate > Min,
    P is Sales * Crate.

pay(F, L, P) :- commission(F, L, Min, Sales, Crate),
    Sales * Crate =< Min,
    P is Min.

pay(F, L, P) :- salaried(F, L, Salary),
    P is Salary.

%may need to rewrite these?
pay(F, L, P) :- hourly(F, L, Hours, Rate),
    Hours =< 40,
    P is Hours * Rate.

pay(F, L, P) :- hourly(F, L, Hours, Rate),
    Hours =< 50,
    Hours > 40,
    P is ((40 * Rate) + ((Hours - 40) * (Rate * 1.5))).

pay(F, L, P) :- hourly(F, L, Hours, Rate),
    Hours > 50,
    P is ((40 * Rate) + (10 * (Rate * 1.5)) + ((Hours - 50) * (Rate * 2))).

average_list(List, Avg) :-
length(List, Long), sum_list(List, Sum),
(Long > 0 -> Avg is Sum / Long; Avg is 0).
