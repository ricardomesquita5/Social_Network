
no(1,ana,[natureza,pintura,musica,sw,porto]).
no(11,antonio,[natureza,pintura,carros,futebol,lisboa]).
no(12,beatriz,[natureza,musica,carros,porto,moda]).
no(13,carlos,[natureza,musica,sw,futebol,coimbra]).
no(14,daniel,[natureza,cinema,jogos,sw,moda]).
no(21,eduardo,[natureza,cinema,teatro,carros,coimbra]).
no(22,isabel,[natureza,musica,porto,lisboa,cinema]).
no(23,jose,[natureza,pintura,sw,musica,carros,lisboa]).
no(24,luisa,[natureza,cinema,jogos,moda,porto]).
no(31,maria,[natureza,pintura,musica,moda,porto]).
no(32,anabela,[natureza,cinema,musica,tecnologia,porto]).
no(33,andre,[natureza,carros,futebol,coimbra]).
no(34,catia,[natureza,musica,cinema,lisboa,moda]).
no(41,cesar,[natureza,teatro,tecnologia,futebol,porto]).
no(42,diogo,[natureza,futebol,sw,jogos,porto]).
no(43,ernesto,[natureza,teatro,carros,porto]).
no(44,isaura,[natureza,moda,tecnologia,cinema]).
no(200,sara,[natureza,moda,musica,sw,coimbra]).
no(51,rodolfo,[natureza,musica,sw]).
no(61,rita,[moda,tecnologia,cinema]).


ligacao(1,11,10,8).
ligacao(1,12,2,6).
ligacao(1,13,-3,-2).
ligacao(1,14,1,-5).
ligacao(11,21,5,7).
ligacao(11,22,2,-4).
ligacao(11,23,-2,8).
ligacao(11,24,6,0).
ligacao(12,21,4,9).
ligacao(12,22,-3,-8).
ligacao(12,23,2,4).
ligacao(12,24,-2,4).
ligacao(13,21,3,2).
ligacao(13,22,0,-3).
ligacao(13,23,5,9).
ligacao(13,24,-2, 4).
ligacao(14,21,2,6).
ligacao(14,22,6,-3).
ligacao(14,23,7,0).
ligacao(14,24,2,2).
ligacao(21,31,2,1).
ligacao(21,32,-2,3).
ligacao(21,33,3,5).
ligacao(21,34,4,2).
ligacao(22,31,5,-4).
ligacao(22,32,-1,6).
ligacao(22,33,2,1).
ligacao(22,34,2,3).
ligacao(23,31,4,-3).
ligacao(23,32,3,5).
ligacao(23,33,4,1).
ligacao(23,34,-2,-3).
ligacao(24,31,1,-5).
ligacao(24,32,1,0).
ligacao(24,33,3,-1).
ligacao(24,34,-1,5).
ligacao(31,41,2,4).
ligacao(31,42,6,3).
ligacao(31,43,2,1).
ligacao(31,44,2,1).
ligacao(32,41,2,3).
ligacao(32,42,-1,0).
ligacao(32,43,0,1).
ligacao(32,44,1,2).
ligacao(33,41,4,-1).
ligacao(33,42,-1,3).
ligacao(33,43,7,2).
ligacao(33,44,5,-3).
ligacao(34,41,3,2).
ligacao(34,42,1,-1).
ligacao(34,43,2,4).
ligacao(34,44,1,-2).
ligacao(41,200,2,0).
ligacao(42,200,7,-2).
ligacao(43,200,-2,4).
ligacao(44,200,-1,-3).
ligacao(1,51,6,2).
ligacao(51,61,7,3).
ligacao(61,200,2,4).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sugerirConexoes(USER, N) :-
    tamanho(USER, N, Le, Lista),
    getAmigosDoUser(USER, List),
    remove_list(Lista,List, Final),
    ver(Final,USER).
%

getTodosUser(USER, ListFinal):-
    findall(L, no(L,_,_), ListaUsers),
    remover(USER, ListaUsers, ListFinal).
%

ver([], _):-!.
ver([H|T], USER):-
    ver(T,USER),
    intersetar(H ,USER, Lenght),
    imprimirResultado(Lenght,USER,H).
%

imprimirResultado(0, _, _):-!.
imprimirResultado(Lenght, User, H):-
    shortestPath(User, H, C, D),
    imprimir(User, H, C).
%

imprimir(User, H, C):-
     write('Sugestao de Amizade: User '), write(H), tab(1), write(C), write('\n').
%

intersetar(H, User, Le):-
  no(H, _, Tags),
  no(User, _, TagsUser),
  intersection(Tags, TagsUser, CommonTags),
  length(CommonTags, Le).
%

% Predicado fornecido nas Tps
uniao([ ],L,L).
uniao([X|L1],L2,LU):-member(X,L2),uniao(L1,L2,LU).
uniao([X|L1],L2,[X|LU]):-uniao(L1,L2,LU).

getAmigosDoUser(User, List):-
    findall(L, ligacao(User,L,_,_), Lista1),
    findall(L, ligacao(L,User,_,_), Lista2),
    uniao(Lista1,Lista2, List).
%

remove_list([], _, []).
remove_list([X|Tail], L2, Result):- member(X, L2), !, remove_list(Tail, L2, Result). 
remove_list([X|Tail], L2, [X|Result]):- remove_list(Tail, L2, Result).


tamanho(_,0,Le,ListElem):- Le is 1,!.
tamanho(X,1,Le,ListElem):- 
    findall(L,ligacao(X,L,_,_), ListElem),
    length(ListElem,Le).
tamanho(X,2,Le,ListElem):- 
    findall(L,ligacao(X,L,_,_), Set1),
    tamanhoRede(Set1, Set2),
    append_list(Set1, Set2, ListElem).
tamanho(X,3,Le,ListElem):- 
get_time(Ti),
    findall(L,ligacao(X,L,_,_), Set1),
    tamanhoRede(Set1, Set2),
    append_list(Set1, Set2, S12),
    tamanhoRede(Set2, Set3),
    append_list(S12, Set3, ListElem),
    length(ListElem,Le),get_time(Tf).
tamanho(X,4,Le,ListElem):- 
    findall(L,ligacao(X,L,_,_), Set1),
    tamanhoRede(Set1, Set2),
    append_list(Set1, Set2, S12),
    tamanhoRede(Set2, Set3),
    append_list(S12, Set3, S123),
    tamanhoRede(Set3, Set4),
    append_list(S123, Set4, ListElem),
    length(ListElem,Le),get_time(Tf).
tamanho(X,N,Le,ListElem) :-
    findall(L,ligacao(X,L,_,_), Set1),
    tamanhoRede(Set1, Set2),
    append_list(Set1, Set2, S12),
    tamanhoRede(Set2, Set3),
    append_list(S12, Set3, S123),
    tamanhoRede(Set3, Set4),
    append_list(S123, Set4, S1234),
    tamanhoRede(Set4, Set5),
    append_list(S1234, Set5, ListEl),
    sort(ListEl,ListElem),
    length(ListElem,Le).
 %


tamanhoRede([H|T], Set):-
    findall(L,ligacao(H,L,_,_), Set1),
    calculaTamanhoRede(T, Set1, Set).
%
calculaTamanhoRede([],SetAtual,Set) :-sort(SetAtual, Set).
calculaTamanhoRede([H|T], SetAtual, Set):-
    findall(L,ligacao(H,L,_,_), Set3), 
    append_list(Set3, SetAtual, S),
    calculaTamanhoRede(T, S, Set).
%
append_list([],L, L).
append_list([Head|Tail], List2, [Head|List]):-
     append_list(Tail, List2, List).
%


%%% CAMINHO MAIS CURTO
path(X,Y,[X,Y],L):- 
    ligacao(X,Y,_,_),
    L is 1.
path(X,Y,[X|W],L):- 
    ligacao(X,Z,_,_), 
    path(Z,Y,W,L2), 
    L is L2 + 1.
shortestPath(X,X,[X,X],0):- !.
shortestPath(X,Y,MinP,MinD):-
    findall([L,P],path(X,Y,P,L),Set),
    sort(Set,Sorted),
    Sorted = [[MinD,MinP]|_].
%


remover( _, [], []).
remover( R, [R|T], T).
remover( R, [H|T], [H|T2]) :- H \= R, remover( R, T, T2).
%