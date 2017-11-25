append([],Ys,Ys).
append([X|Xs],Ys,[X|Zs]) :- append(Xs,Ys,Zs).

% trans(X,Y,Arcs):-
% check if arc(X,Y) is in Arcs
% (check if there is a path from X to Y)
trans(X,Y,Arcs):- member(arc(X,Y),Arcs).

% move(N,CurPos,FinalPos,Arcs)
% find a possible final position FinalPos
% that is reached by walking N steps from
% start position CurPos
% Arcs is the input graph, a list of arcs(X,Y)
move(0,FinalPos,FinalPos,_).
move(N,CurPos,FinalPos,Arcs) :-
	N>0,
	trans(CurPos,NextPos,Arcs),
	N1 is N-1,
	move(N1,NextPos,FinalPos,Arcs).


minimum([],Min,Min).
minimum([X|Ls],CurMin,Min) :- (X<CurMin->CurMin1 is X;CurMin1 is CurMin), minimum(Ls,CurMin1,Min).

minimum([X|Ls],Min) :- minimum([X|Ls],X,Min).

% dice(Arcs,Rolls,Visited,CurCount,TotalCount)
% apply dice moves recursively until it finds a path to goal
% Arcs: input graph
% Rolls: cyclic list that contain the sequence of dice number
% Visited: record the state ([CurPos,FinalPos, Move]) to prevent from
%          revisiting the same state
% CurCount: current number of moves(N)
% TotalCount: when reach position z, TotalCount=total number of moves(N)

dice(Arcs,CurPos,[Move|Rolls],Visited,CurCount,TotalCount):-
	move(Move,CurPos,FinalPos,Arcs),
	State=[CurPos,FinalPos,Move],
	\+member(State,Visited),
	append([State],Visited,Visited1),
	CurCount1 is CurCount+1,
	(FinalPos == z-> (TotalCount=CurCount1,true); dice(Arcs,FinalPos,Rolls,Visited1,CurCount1,TotalCount)).

dice(Arcs,Moves,N):-
	append(Moves,Rolls,Rolls),
	findall(Sol,dice(Arcs,a,Rolls,[],0,Sol),Sols),
	(Sols=[]->fail;minimum(Sols,N)), !.

