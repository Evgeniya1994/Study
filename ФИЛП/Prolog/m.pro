:-initialization(goal).

move1([ML, KL], [MR, KR], [MLResult, KLResult], [MRResult, KRResult]) :-!,
	MLResult is ML - 1, KLResult is KL - 1, MRResult is MR + 1, KRResult is KR + 1.
move2([ML, KL], [MR, KR], [MLResult, KL], [MRResult, KR]) :-!,
	MLResult is ML - 2, MRResult is MR + 2.
move3([ML, KL], [MR, KR], [ML, KLResult], [MR, KRResult]) :-!,
	KLResult is KL - 2, KRResult is KR + 2.
move4([ML, KL], [MR, KR], [MLResult, KL], [MRResult, KR]) :-!,
	MLResult is ML - 1, MRResult is MR + 1.
move5([ML, KL], [MR, KR], [ML, KLResult], [MR, KRResult]) :-!,
	KLResult is KL - 1, KRResult is KR + 1.

move(LShore, RShore, LSResult, RSResult) :-
	move1(LShore, RShore, LSResult, RSResult);
	move2(LShore, RShore, LSResult, RSResult);
	move3(LShore, RShore, LSResult, RSResult);
	move4(LShore, RShore, LSResult, RSResult);
	move5(LShore, RShore, LSResult, RSResult).
	
valid([M, K]) :-!, M > -1, K > -1, ((M = 0,!); M >= K).

valid_move(LShore, RShore, LSResult, RSResult) :-
	move(LShore, RShore, LSResult, RSResult),
	valid(LSResult), valid(RSResult).

direct_move(LShore, RShore, Direction, LSResult, RSResult, DResult):-
	( Direction == right, valid_move(LShore, RShore, LSResult, RSResult), DResult = left );
	( Direction == left, valid_move(RShore, LShore, RSResult, LSResult), DResult = right ).

search([0, 1], [M, K], right, _, [[0,0], [M, KR]]):-!, KR is K + 1.
search([1, 0], [M, K], right, _, [[0,0], [MR, K]]):-!, MR is M + 1.
search([0, 2], [M, K], right, _, [[0,0], [M, KR]]):-!, KR is K + 2.
search([2, 0], [M, K], right, _, [[0,0], [MR, K]]):-!, MR is M + 2.
search([1, 1], [M, K], right, _, [[0,0], [MR, KR]]):-!, MR is M + 1, KR is K + 1.
search(LShore, RShore, Direction, Marked, [[LSResult, RSResult] | Result]):-
	direct_move(LShore, RShore, Direction, LSResult, RSResult, DResult),
	\+ member([DResult|LSResult], Marked),
	search(LSResult, RSResult, DResult, [[Direction|LShore]|Marked], Result).

print_result([[ML, KL],[MR, KR]]) :-
	write('M = '), write(ML), write(' K = '), write(KL),
	write('        M = '), write(MR), write(' K = '), write(KR), nl.
print_result([[[ML, KL],[MR, KR]]|T]) :-
	write('M = '), write(ML), write(' K = '), write(KL),
	write('        M = '), write(MR), write(' K = '), write(KR), nl,
	print_result(T).
	
print_answer(M, K) :- 
	( search([M, K], [0, 0], right, [], Result),
	print_result(Result) );
	write('It is impossible'), nl.
	
goal :- write('Number of Missionaries: '),
		read_integer(M),
		write('Number of Cannibals on the left Shore: '),
		read_integer(K), nl,
		print_answer(M, K), nl, goal.