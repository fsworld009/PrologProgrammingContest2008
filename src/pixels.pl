% removecars(Input,Output):
% Output is obtained by replacing free variables in Input by 0
removevars([],[]).
removevars([Pixel|Pixels],[Result|Results]) :- Pixel=..[pixels|Input], removevars_do(Input,Output), Result=..[pixels|Output], removevars(Pixels,Results).

removevars_do([],[]).
removevars_do([A|As],[B|Bs]) :- (var(A)->B=0;B=A), removevars_do(As,Bs).

% create_starlist(TotalRow,TotalCol,StarList)
% StarList is a term in format of
% pixels(pixels(Var1,...,VarN),pixels(_,...,_),...) so that later
% we can use arg to set star at any position
% there are TotalRol*TotalCol Vars in StarList
create_starlist(TotalRow,TotalCol,StarList) :- functor(StarList,p,TotalRow), StarList=..[p|StarListCols], create_starlist(TotalCol,StarListCols).

create_starlist(_,[]).
create_starlist(TotalCol,[StarListCol|StarListCols]) :- functor(StarListCol,pixels,TotalCol), create_starlist(TotalCol,StarListCols).


% getnum(N,Row,Col,PixelList)
% N is the number at row Row, column Col
% in PixelList
% count Row, Col from 1
% getnum/5 can also be used as setnum/5
getnum(N,Row,Col,PixelList) :- arg(Row,PixelList,PixelRow), arg(Col,PixelRow,N).

% findpair(N,Row,Col,PixelList,PairRow,PairCol):-
% find a number at (PairRow,PairCol) in PixelList to pair with
% the number at (Row,Col) in PixelList
% N is the number at position (Row,Col) in PixelList
%
findpair(N,Row,Col,PixelList,StarList,PairPos,Col) :- PairPos is Row+(N-1), (PairPos>0, getnum(X,PairPos,Col,StarList), var(X)-> getnum(N,PairPos,Col,PixelList);fail).
findpair(N,Row,Col,PixelList,StarList,PairPos,Col) :- PairPos is Row-(N-1), (PairPos>0, getnum(X,PairPos,Col,StarList), var(X) -> getnum(N,PairPos,Col,PixelList);fail).
findpair(N,Row,Col,PixelList,StarList,Row,PairPos) :- PairPos is Col+(N-1), (PairPos>0, getnum(X,Row,PairPos,StarList), var(X) -> getnum(N,Row,PairPos,PixelList);fail).
findpair(N,Row,Col,PixelList,StarList,Row,PairPos) :- PairPos is Col-(N-1), (PairPos>0, getnum(X,Row,PairPos,StarList), var(X) -> getnum(N,Row,PairPos,PixelList);fail).

% fillstar1: fill star from Col1 to Col2 in StarList
% fillsatr2: fill star from Row1 to Row2 in StarList

fillstar1(Col,Col,_,_).
fillstar1(CurCol,TargetCol,Row,StarList) :- CurCol<TargetCol, getnum(*,Row,CurCol,StarList), CurCol1 is CurCol+1, fillstar1(CurCol1,TargetCol,Row,StarList).

fillstar2(Row,Row,_,_).
fillstar2(CurRow,TargetRow,Col,StarList) :- CurRow<TargetRow, getnum(*,CurRow,Col,StarList), CurRow1 is CurRow+1, fillstar2(CurRow1,TargetRow,Col,StarList).

% fillstar(Row1,Col1,Row2,Col2) :-
% set variables in StarList from Row1,Col1 to Row2,Col2 to '*'
fillstar(Row,Col1,Row,Col2,StarList) :- (Col1<Col2-> CurCol=Col1,TargetCol is Col2+1 ; CurCol=Col2,TargetCol is Col1+1), fillstar1(CurCol,TargetCol,Row,StarList), !.
fillstar(Row1,Col,Row2,Col,StarList) :- (Row1<Row2-> CurRow=Row1,TargetRow is Row2+1 ; CurRow=Row2,TargetRow is Row1+1), fillstar2(CurRow,TargetRow,Col,StarList), !.

% pixels_row(CurRow,TotalRow,TotalCol,PixelList,StarList).
% pixels_col(CurRow,CurCol,TotalCol,_,_).
% find a pair for each non-zero number in PixelList
pixels_col(_,TotalCol,TotalCol,_,_).
pixels_col(CurRow,CurCol,TotalCol,PixelList,StarList) :-
	CurCol < TotalCol,
	getnum(N,CurRow,CurCol,PixelList),
	getnum(P,CurRow,CurCol,StarList),
	( N=\=0, var(P) ->
	findpair(N,CurRow,CurCol,PixelList,StarList,PRow,PCol),
	fillstar(CurRow,CurCol,PRow,PCol,StarList);
	true
	),
	CurCol1 is CurCol+1,
	pixels_col(CurRow,CurCol1,TotalCol,PixelList,StarList).


pixels_row(TotalRow,TotalRow,_,_,_).
pixels_row(CurRow,TotalRow,TotalCol,PixelList,StarList) :-
	CurRow < TotalRow,
	pixels_col(CurRow,1,TotalCol,PixelList,StarList),
	CurRow1 is CurRow+1,
	pixels_row(CurRow1,TotalRow,TotalCol,PixelList,StarList).


% pixels_print_row(CurRow,TotalRow,TotalCol,StarList)
% pixels_print_col(CurRow,CurCol,TotalCol,StarList)
% print the result
% for each argument in StarList
% if it is a free variable print a space
% otherwise print a '*'
pixels_print_col(_,TotalCol,TotalCol,_):- !.
pixels_print_col(CurRow,CurCol,TotalCol,StarList):-
	getnum(S,CurRow,CurCol,StarList),
	(nonvar(S)->print(*);print(' ')),
	CurCol1 is CurCol+1,
	pixels_print_col(CurRow,CurCol1,TotalCol,StarList).



pixels_print_row(TotalRow,TotalRow,_,_):- !.
pixels_print_row(CurRow,TotalRow,TotalCol,StarList):-
	pixels_print_col(CurRow,1,TotalCol,StarList),
	print('\n'),
	CurRow1 is CurRow+1,
	pixels_print_row(CurRow1,TotalRow,TotalCol,StarList), !.




square(PixelList) :-
	removevars(PixelList,PixelList1),
	PixelList2 =.. [p|PixelList1],
	functor(PixelList2,_,TotalRow),
	arg(1,PixelList2,P1),
	functor(P1,_,TotalCol),
	create_starlist(TotalRow,TotalCol,StarList),
	TotalRow1 is TotalRow+1,
	TotalCol1 is TotalCol+1, !,
	pixels_row(1,TotalRow1,TotalCol1,PixelList2,StarList),

	%pixels_allmatched_row(1,TotalRow1,TotalCol1,PixelList2,StarList),
	pixels_print_row(1,TotalRow1,TotalCol1,StarList).












