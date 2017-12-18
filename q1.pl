/* ---------------------- */
/* ---- GLOBAL TOOLS ---- */
/* ---------------------- */

/* if condition */
if(X):- X.

/* assigns the value Predicate to Y */
set(Predicate, Y):- Y = Predicate.

/* separate variables and numbers in lists */
separate([X], [X], []):- if(atom(X)).
separate([X], [], [X]):- if(integer(X)).
separate([X | Y], [X|Vars], Nums):- 
( 
    if(atom(X)),
    (
        separate(Y, Vars, Nums)
    )
).

separate([X | Y], Vars, [X|Nums]):- 
(
    if(integer(X)),
    (
        separate(Y, Vars, Nums)
    )
).

/* Multiply the elements in a number list */
multiply_list([], 1).
multiply_list([N|Ns], M):-
(
    (
        multiply_list(Ns, T), 
        M is N * T
    )
).

/* sum_list is an inbuilt predicate */

/* adds coefficients of multiple product predicates with same variables, and makes a single predicate */

add_coeff([p(X)], [p(X)]). /* Base case */

add_coeff( [ p([H1|T1]), p([H2|T2]) | Tail ], Result ):- /* Recursive case */
(
    ( 
        if(H1==H2),
        (
            (Y is T1+T2), 
            (Temp = p([H1 , Y])),
            add_coeff([Temp | Tail], Result)
        )
    );

    (
        if(not(H1==H2)), 
        (
            add_coeff([p([H2|T2])|Tail], Y), 
            Result = [p([H1 | T1]) | Y]
        )
    )
).

/* ----------------------------------------------- */
/* --- MAKE: TOOL TO BUILD A REDUCED PREDICATE --- */
/* ----------------------------------------------- */

/* To build the reduced sum predicate from a simple sum predicate */

make(s(X), Sum):-
(
    separate(X, Vars, Nums),
    sum_list(Nums, Num_sum),
    append(Vars, [Num_sum], Temp),
    Sum = s(Temp)
).

/* To build the reduced product predicate from a simple product predicate */

make(p(X), Product):-
(
    separate(X, Vars, Nums),
    multiply_list(Nums, Num_prod),
    append(Vars , [Num_prod] , Temp),
    Product = p(Temp)
).

/* To build the reduced sum of product expression with only product predicates in a sum predicate */

make(s([Head1]), Sum):- /* Base Case */
(
    if(compound(Head1)), 
    (
        make(Head1, Small_head),
        (Sum = [Small_head])
    )
).

make(s( Y ), Sum):- /* Recursive case */
(
    sort(Y, [Head1, Head2 | Tail]),
    if(compound(Head1)), 
    (
        make(Head1, Small_head),
        make(s( [ Head2 | Tail ] ), Small_sum),
        Temp = ([ Small_head | Small_sum ]),
        add_coeff(Temp, Sum)
    )
).

/* To build the reduced product of sum expression with only sum predicates in a product predicate */

make(p([Head1]), Product):- /* Base Case */
(
    if(compound(Head1)), 
    (
        make(Head1, Small_head), 
        (Product = [Small_head])
    )
).

make(p( [Head1, Head2 | Tail] ), Temp):- /* Recursive case */
(
    if(compound(Head1)),
    (
        make(Head1, Small_head),
        make(p( [ Head2 | Tail ] ), Small_prod),
        Temp = [ Small_head | Small_prod ]
    )
).

/* ------------------------------------------------------ */
/* --- REDUCE: THE PREDICATE TO BE CALLED BY THE USER --- */
/* ------------------------------------------------------ */

/* Adding coefficients of like terms */

reduce(X, Result):-
(
    make(X, Y), 
    (
        (
            is_list(Y),
            (
                subset([p(_)], Y), Result = s(Y);
                subset([s(_)], Y) , Result = p(Y)
            )
        );
        (
            not(is_list(Y)),
            (
                Result = Y
            )
        )
    )
).

/* -------------------------------------------------------------------- */
/* --- EQUAL: THE PREDICATE THAT CHECKS EQUALITY OF TWO EXPRESSIONS --- */
/* -------------------------------------------------------------------- */

equal(A, B):-
(
    reduce(A, Ar), 
    reduce(B, Br),
    (Ar == Br)
).