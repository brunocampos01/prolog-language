:- initialization(testes).

testes :-
        consult('programa.pl'),
        load,
        cmd("pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95"),
        cmd("un pf 100 ul"),
        %cmd("repita 36 [ gd 150 repita 8 [ pf 50 ge 45]]"),
        cmd("pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95 pf 54 ge 37 pt 28 gd 95"),
        commit.
