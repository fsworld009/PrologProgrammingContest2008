% chocolate(Row,Col)
% You have to choose a monospaced font in interpreter
% in order to print result correctly
% count Row and Column from 0

chocolate(Col,Row):- Col>0, Row>0,  TotalRow is (Row*2)+2, chocolate_printrow(0,TotalRow,Col), !.

% print the left most characters based on current row
% row 0: print two spaces
% row 1: print .
% row 2: print |\
% row i for i>2: first print i-2 spaces, then print \\
chocolate_printhead(0):- print('  ').
chocolate_printhead(1):- print('.').
chocolate_printhead(2):- print('|\\').
chocolate_printhead(N):- N>2, N1 is N-2, loopprint(N1,' '), print('\\\\').

% chocolate_printfinal(
% print the last row
% 1. print (current row)-2 spaces
% 2. print \|
% 3. print 5*(Total column)-1 underscores
% 4. print |
chocolate_printfinal(N,TotalCol) :-
	N1 is N-2,
	loopprint(N1,' '),
	print('\\|'),
	TotalUnderScore is (5*TotalCol)-1,
	loopprint(TotalUnderScore,'_'),
	print('|').

%loopprint(N,Symbol):- print Symbol N times
loopprint(N,Symbol):- N>0, print(Symbol), N1 is N-1, loopprint(N1,Symbol).
loopprint(0,_).

% chocolate_print(CurRow,TotalRow)
% CurRow: current row
% TotalRow: total rows
% print chocolate symbols based on current row
% if current row is i
% i=0, then print --- followed by two spaces
% i%2=1, then print '\__\
% i%2=0, then print / __\, but if i+1 is the last row,
% print /   \ instead
chocolate_print(0,_) :- print('---  ').
chocolate_print(N,_) :- N>0, mod(N,2) =:= 1, print('\'\\__\\').
chocolate_print(N,TotalRow) :- N>0, mod(N,2) =:= 0, (N =:= TotalRow-2 ->print('/   \\');print('/ __\\')).

% chocolate_printcol(CurRow,TotalRow,CurCol,TotalCol)
% CurRow: current row
% TotalRow: total rows
% CurCol: current column
% TotalCol: total columns
% print chocolate symbol based on current row TotalColumn times
% simply call chocolate_print TotalColumn times
chocolate_printcol(_,_,TotalCol,TotalCol).
chocolate_printcol(CurRow,TotalRow,CurCol,TotalCol):-
	chocolate_print(CurRow,TotalRow),
	CurCol1 is CurCol+1,
	chocolate_printcol(CurRow,TotalRow,CurCol1,TotalCol).

% chocolate_printrow(CurRow,TotalRow,TotalCol)
% CurRow: current row
% TotalRow: total rows
% TotalCol: total columns
%
% print each row:
% if it is the last row, call chocolate_printfinal/2
% otherwise:
% 1. call chocolate_printhead/1 to print leftmost characters
% 2. call chocolate_printcol/4 to print chocolates
chocolate_printrow(TotalRow,TotalRow,_).
chocolate_printrow(CurRow,TotalRow,TotalCol):-
	(CurRow is TotalRow-1 -> chocolate_printfinal(CurRow,TotalCol);chocolate_printhead(CurRow),chocolate_printcol(CurRow,TotalRow,0,TotalCol)),
	print('\n'),
	CurRow1 is CurRow+1,
	chocolate_printrow(CurRow1,TotalRow,TotalCol).


