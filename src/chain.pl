select(X,[X|Xs],Xs).
select(X,[Y|Ys],[Y|Zs]) :- X\==Y, select(X,Ys,Zs).

reverse(Xs,Ys) :- reverse(Xs,[],Ys).
reverse([X|Xs],Acc,Ys) :- reverse(Xs,[X|Acc],Ys).
reverse([],Ys,Ys).

% permutation(List,Perm):-
% generate all possible permutations of the input list
% List: the input list
% Perm: a permutation
permutation([],[]).
permutation(L,[X|R]):- select(X,L,L1), permutation(L1,R).

% generate(N,Ls):-
% Ls a list containing N down to 1
% Ls is used to apply permutation
generate(0,[]):- !.
generate(N,[N|T]):- N>0, N1 is N-1, generate(N1,T).

% permute_do(Inputs,Perms,Output):
% Output is a term p(Var1,Var2,...),
% num of arguments of Output = length of Input
% use arg/3 to apply permutation to Output
permute_do([],[],_):- !.
permute_do([X|Inputs],[P|Perms],Output):- arg(P,Output,X), permute_do(Inputs,Perms,Output).

% permute(Inputs,Perms,Outputs) :-
% Outputs is obatined by applying permutation Perms on Inputs
% first generate a term p(Var1,Var2,...) and call permute_do/3
% then convert the output back to a list
permute(Inputs,Perms,Outputs) :- length(Inputs,Ni), functor(Output, p, Ni), permute_do(Inputs,Perms,Output), Output=..[p|Outputs].



% permute_count(Inputs,OrigInputs,Perms,CurNum,TotalNum)
% count the number of permutations does the Inputs apply
% in order to get the OrigInputs back
permute_count(Inputs,Inputs,_,TotalNum,TotalNum):- !.
permute_count(Inputs,OrigInputs,Perms,CurNum,TotalNum):-
	permute(Inputs,Perms,Inputs1),
	CurNum1 is CurNum+1,
	permute_count(Inputs1,OrigInputs,Perms,CurNum1,TotalNum).

% permute_count
% count the number of  permutations does the Inputs applies
% in order to get itself again
% first permute Inputs one time, obtain Inputs1
% then call permute_count/5
permute_count(Inputs,Perms,Ans):-
	permute(Inputs,Perms,Inputs1),
	permute_count(Inputs1,Inputs,Perms,1,Ans).

% large_do(Inputs,PerpList,CurLargest,Largest,Results)
% count flip times in Inputs for all permutations in PermList
% and record [(Permutation),(Num of flips)] to list Results
large_do(_,[],Largest,Largest,[]).
large_do(Inputs,[Perm|PermList],CurLargest,Largest,[[Perm,N]|Results]) :-
	permute_count(Inputs,Perm,N),
	(   N>CurLargest-> CurLargest1 is N; CurLargest1 is CurLargest),
	large_do(Inputs,PermList,CurLargest1,Largest,Results).


% find_largest_Perm(Results,Perm,Largest) :-
% list all permutations that need flip Largest times
% Perm, Largest: the permutation with the max flips
find_largest_perm([[Perm,Largest]|_],Perm,Largest).
find_largest_perm([_|Results],Perm,Largest) :- find_largest_perm(Results,Perm,Largest).


large(Length,Perm,Largest):-
	generate(Length,Inputs),
	findall(P,permutation(Inputs,P),PermList),
	large_do(Inputs,PermList,0,Largest,Results),
	find_largest_perm(Results,Perm,Largest).
