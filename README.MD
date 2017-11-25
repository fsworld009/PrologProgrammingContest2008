## Prolog Program Contest 2008
Implementation of questions from [Prolog Proram Contest 2008](https://people.cs.kuleuven.be/~bart.demoen/PrologProgrammingContests/2008/probs.pdf).

### About
This was an assignment from my Prolog course in graduate school.

I implemented `chocolate`, `pixels`, `chain`, and `dice`. All programs are developed with SWI-Prolog.

### Notes
- In `pixels.pl`, I changed predicate `square` to accept a list, otherwise the number of arguments is not fixed.

- In `dice.pl`, a lot of inputs make the program not terminate, but since it requires to find the minimum solution, which means I must find all solutions, I cannot think a way to
improve the program.

### Outputs
- chocolate  
![chocolate](images/chocolate.png?raw=true)

- pixels
```
1 ?- square([pixels(3,_,2),pixels(_,_,2),pixels(3,_,_)]).
* *
* *
*  
true ;
false.

2 ?- square([pixels(5,_,_,5,_,_,4,_,_,4,_,_,4,_,_,_,_,_,5,_,_,_,_,_,4,3,_,3),pixels(_,_,_,_,_,_,3,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,3),pixels(_,2,2,_,_,_,_,3,_,3,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),pixels(_,_,_,_,_,_,3,_,_,_,_,_,4,_,_,_,_,_,_,_,_,_,_,_,4,_,_,3),pixels(5,_,_,5,_,_,4,_,_,4,_,_,4,_,_,4,_,_,5,3,_,3,_,_,4,_,_,4)]).
*  *  ****  *     *     ****
*  *  *     *     *     *  *
****  ****  *     *     *  *
*  *  *     *     *     *  *
*  *  ****  ****  ****  ****
true ;
false.

3 ?- square([pixels(3,_,3),pixels(_,_,_),pixels(3,_,3)]).
* *
* *
* *
true ;
***
   
***
true ;
false.
```

- chains
```
1 ?- large(2,P,T).
P = [2, 1],
T = 2 ;
false.

2 ?- large(5,P,T).
P = [5, 4, 2, 3, 1],
T = 6 ;
P = [5, 4, 1, 2, 3],
T = 6 ;
P = [5, 3, 4, 2, 1],
T = 6 ;
P = [5, 3, 2, 1, 4],
T = 6 ;
P = [5, 1, 4, 3, 2],
T = 6 ;
P = [4, 5, 2, 1, 3],
T = 6 ;
P = [4, 5, 1, 3, 2],
T = 6 ;
P = [4, 3, 5, 1, 2],
T = 6 ;
P = [4, 3, 2, 5, 1],
T = 6 ;
P = [4, 1, 5, 2, 3],
T = 6 ;
P = [3, 5, 4, 1, 2],
T = 6 ;
P = [3, 5, 1, 2, 4],
T = 6 ;
P = [3, 4, 5, 2, 1],
T = 6 ;
P = [3, 4, 1, 5, 2],
T = 6 ;
P = [3, 1, 2, 5, 4],
T = 6 ;
P = [2, 5, 4, 3, 1],
T = 6 ;
P = [2, 4, 5, 1, 3],
T = 6 ;
P = [2, 3, 1, 5, 4],
T = 6 ;
P = [2, 1, 5, 3, 4],
T = 6 ;
P = [2, 1, 4, 5, 3],
T = 6 ;
false.

3 ?- large(4,P,T).
P = [4, 3, 1, 2],
T = 4 ;
P = [4, 1, 2, 3],
T = 4 ;
P = [3, 4, 2, 1],
T = 4 ;
P = [3, 1, 4, 2],
T = 4 ;
P = [2, 4, 1, 3],
T = 4 ;
P = [2, 3, 4, 1],
T = 4 ;
false.
```

- dice
```
1 ?- dice([arc(a,b), arc(b,a), arc(b,z), arc(z,b)],[3,5],N).
N = 2.

2 ?- dice([arc(a,b), arc(b,z)],[4,2,6],N).
false.

3 ?- dice([arc(a,b), arc(b,c), arc(c,z)], [1],N).
N = 3.

4 ?- dice([arc(a,b), arc(b,a), arc(b,z), arc(z,b)],[3,4,5,6,7],N).
N = 3.

5 ?- dice([arc(a,b), arc(b,a), arc(b,c), arc(c,d), arc(d,c)],[3,4,5,6,7],N).
false.

6 ?- dice([arc(a,b), arc(b,a), arc(b,c), arc(c,d), arc(d,c), arc(d,z), arc(z,a)],[3,2],N).
N = 3.
```


### Licence
MIT