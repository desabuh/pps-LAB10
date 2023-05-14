
succ(N, s(N)). 

  


%ESERCIZI 

%EX 1.1

search(X, cons(X, _)).
search(X, cons(_ , Xs)) :- search(X, Xs).

%EX 1.2

search2 (X , cons(X , cons(X , _))). 
search2 (X , cons(_ , Xs )) :- search2(X , Xs ). 

  
%EX 1.3
  
%l'implementazione di search_two risulta fully relational
search_two(X, cons(X, cons(Y, cons(X, nil)))). 
search_two(X, cons(_, Xs)) :- search_two(X, Xs). 

%EX 1.4
  
% prima casistica: l'elemento è in testa e si trova anche nella coda
search_anytwo(X, cons(X, L)) :- search(X, L). 
%seconda casistica: l'elemento non è in testa, allora si scarta la testa e si continua a cercare
search_anytwo(X, cons(_, L)) :- search_anytwo(X , L).

%EX 2.1

%caso base: se la lista è vuota è lunga zero
size(nil, zero).
%caso ricorsivo: altrimenti una lista è lunga almeno 1
size(cons(H, T), s(N)) :- size(T, N).


%EX 2.2

%caso base: la somma di una lista vuota è zero
sum_list(nil, zero).
%caso ricorsivo: se la somma finale della lista è S allora S è formata dalla somma di tutte gli N elementi della lista (ricorsivamente visualizzabili come teste) pertanto:  S - H1 - ... - Hn - 0 = 0
sum_list(cons(H, T), S) :- sum(H, X, S), sum_list(T, X).  

%EX 2.3

count(List, E, N) :- count(List, E, zero, N).
count(nil, E, N, N).
count(cons(E, L), E, N, M) :- count(L, E, s(N), M).
count(cons(E, L), E2, N, M) :- E \= E2, count(L, E2, N, M).

%EX 2.4

%predicato di utility greater\2
greater(s(X), zero).
greater(s(X), s(Y)) :- greater(X, Y). 

%utilizzo un predicato helper max\3 che prende la lista, setta come massimo temporaneo il primo elemento e mantiene in M il massimo effettivo
max(cons(H, T), M) :- max(T, H, M).
%caso base: il massimo temporaneo è uguale a quello effettivo
max(nil, M, M).
%case oricorsivo: se la testa è maggiore del massimo temporaneo allora la testa diventa il nuovo massimo
max(cons(H, T), TM, M) :- greater(H, TM), max(T, H, M).
%altrimenti si richiama ricorsiva la max sulla coda
max(cons(H, T), TM, M) :- max(T, TM, M).

%EX 2.5

%stessa logica del max ma con clausole invertite
min(cons(H, T), M) :- min(T, H, M).
min(nil, M, M).
min(cons(H, T), TM, M) :- greater(H, TM), min(T, TM, M).
min(cons(H, T), TM, M) :- min(T, H, M).

%implementazione non ottimale: la lista va esaminata ricorsivamente piu' volte
min-max(L, Min, Max) :- min(L, Min), max(L, Max).


%EX 3.1

%2 liste vuote sono uguali
same(nil, nil).
same(cons(H, T), cons(H2, T2)) :- H = H2, same(T, T2).


%EX 3.2

all_bigger(nil, nil).
%si riutilizza greater\2: se la testa della prima lista è maggiore della seconda allora si continua ricorsivamente
all_bigger(cons(H, T), cons(H2, T2)) :- greater(H, H2), all_bigger(T, T2).


%EX 3.3

sublist(nil, T2).
%se le teste sono uguale l'elemento è presente nella lista 2
sublist(cons(H, T), cons(H, T2)) :- sublist(T, cons(H, T2)).
%se l'elemento non è presente allora è necessario prima cercare se questo sia presente in coda
sublist(cons(H, T), cons(H2, T2)) :- search(H, T2), sublist(T, cons(H2, T2)).

%EX 4.1

%fully relational: è possibile enumerare tutte le sequenze di lunghezza N con tutte le liste di un qualsiasi elemento X di lunghezza N.
seq(zero, _, nil).
seq(s(N), E, cons(E, T)) :- seq(N, E, T).


%EX 4.2

%se la lunghezza di sequenza è zero allora la lista è nulla
seqR(zero, nil).
%altrimenti si decrementa il valore della lunghezza
seqR(s(N), cons(H, T)) :- N = H, seqR(N, T).


%EX 4.3

%predicato di utility per la somma
sum(zero, N, N). 
sum(s(N), M, s(O)) :- sum(N, M, O). 

%predicato di helper: mantiene un contatore sul numero rimanente di elementi da visitare
seqR2(N, L) :- seqR2(N, L, N).
%se la lista è nulla allora il contatore è zero 
seqR2(_, nil, zero).
%se la sequenza è corretta è vero per forza che la somma tra il valore del contatore e la testa deve essere uguale alla lunghezza della lista, es. con lista di lunghezza 3: 0 + 3 => 1 + 2 => 2 + 1 
seqR2(N, cons(H, T), s(C)) :- sum(H, s(C), N), seqR2(N, T, C). 



%EX 5

%caso base: una lista con un solo elemento rappresenta anche l'ultimo
last(cons(H, nil), H).
%caso ricorsivo: si ricerca l'ultimo elemento sulla coda fintanto che non è nulla
last(cons(H, T), L) :- last(T, L).


%caso base: il mapping su un valore nullo rimane un valore nullo
map(nil, nil).
%caso ricorsivo: in questo caso la funzione di mapping (_ + 1) è applicata su ogni testa e poi richiamata ricorsivamente sulle code
map(cons(_, L), cons(s(_), L2)) :- map(L, L2).


%caso base: la lista filtrata di una lista vuota è la lista vuota
filter(nil, nil).
%caso ricorsivo: se la testa della lista è maggiore di 0 allora questa 
%presente nella lista filtrata
filter(cons(H, T), cons(H, T2)) :- H \= zero, filter(T, T2).
%altrimenti ovviamente non sarà contenuta nella lista filtrata
filter(cons(_, T), T2) :- filter(T, T2).

%caso base: se l'elemento è stato trovato in testa ed è maggiore di 0
%allora è vero
find(cons(H, T), H) :- H \= zero.
%caso ricorsivo: si richiama ricorsivamente sulla coda
find(cons(H, T), E) :- find(T, E).


%caso base: in fondo all'iterazione la lista con gli elementi rimosso è uguale
%a quella ottenuta
drop(L, zero, L).
%caso ricorsivo: continuo a rimuovere elementi dalla testa decrementando
%il contatore
drop(cons(H, T), s(N), R) :- s(N) \= zero, drop(T, N, R).  


%caso base 1: se si richiede di rimuovere zero elementi allora la lista è nulla
take(_, zero, nil).
%caso base 2: a prescindere dal numero di valori da prendere da una lista
%vuota, la risultante è sempre una lista vuota
take(nil, _, nil).
%caso ricorsivo: si prendono gli elementi in testa e si decrementa il contatore
take(cons(H, T), s(N), cons(H, T2)) :- take(T, N, T2).

%caso base 1: una lista vuota a prescindere da quale altra verrà zippata sarà sempre vuota
zip(nil, _, nil).
%caso base 2: se la seconda lista è vuota allora il valore risulta è sempre vuoto
%a prescindere
zip(_, nil, nil).
%caso ricorsivo: una lista zippata è una lista che ha come testa una tupla della 2
%teste (H, H2) e come coda una lista di tuple dei rimanenti elementi
zip(cons(H, T), cons(H2, T2), cons((H, H2), Z)) :- zip(T, T2, Z).
