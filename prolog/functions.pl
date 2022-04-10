count(Op, Ref, Count) :- (
    Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List),  length(List, Count);
    Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List),  length(List, Count);
    Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  length(List, Count);
    Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  length(List, Count);
    Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  length(List, Count);
    Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  length(List, Count)
    ).

max(Op, Ref, Max) :- (
    Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List), max_list(List, Max);
    Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List), max_list(List, Max);
    Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  max_list(List, Max);
    Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  max_list(List, Max);
    Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  max_list(List, Max);
    Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  max_list(List, Max)
    ).

min(Op, Ref, Min) :- (
    Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List), min_list(List, Min);
    Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List), min_list(List, Min);
    Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  min_list(List, Min);
    Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  min_list(List, Min);
    Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  min_list(List, Min);
    Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  min_list(List, Min)
    ).

total(Op, Ref, Total) :- (
    Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List), sum_list(List, Total);
    Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List), sum_list(List, Total);
    Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  sum_list(List, Total);
    Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  sum_list(List, Total);
    Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  sum_list(List, Total);
    Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  sum_list(List, Total)
    ).

avg(Op, Ref, Avg) :- (
    Op='eq', findall(Z, (pay(X, Y, Z), Z=:=Ref), List), average_list(List, Avg);
    Op='ne', findall(Z, (pay(X, Y, Z), Z=\=Ref), List), average_list(List, Avg);
    Op='gt', findall(Z, (pay(X, Y, Z), Z>Ref), List),  average_list(List, Avg);
    Op='ge', findall(Z, (pay(X, Y, Z), Z>=Ref), List),  average_list(List, Avg);
    Op='lt', findall(Z, (pay(X, Y, Z), Z<Ref), List),  average_list(List, Avg);
    Op='le', findall(Z, (pay(X, Y, Z), Z=<Ref), List),  average_list(List, Avg)
    ).

list(Op, Ref, List) :- (
    Op='eq', findall([X, Y, Z], (pay(X, Y, Z), Z=:=Ref), List);
    Op='ne', findall([X, Y, Z], (pay(X, Y, Z), Z=\=Ref), List);
    Op='gt', findall([X, Y, Z], (pay(X, Y, Z), Z>Ref), List);
    Op='ge', findall([X, Y, Z], (pay(X, Y, Z), Z>=Ref), List);
    Op='lt', findall([X, Y, Z], (pay(X, Y, Z), Z<Ref), List);
    Op='le', findall([X, Y, Z], (pay(X, Y, Z), Z=<Ref), List)
    ).
