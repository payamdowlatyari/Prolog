% Partners:
% Iman Elsayed
% Payam Dowlatyari

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% question #1
%% sample run: routeTrip(seattle, oceanside, Trip).
%% sample result: Trip = [seattle, portland, sanfrancisco, bakersfield, sandiego, oceanside]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nonStopTrain(sandiego,oceanside).
nonStopTrain(lasvegas,sandiego).
nonStopTrain(sanfrancisco,bakersfield).
nonStopTrain(bakersfield,sandiego).
nonStopTrain(oceanside,losangeles).
nonStopTrain(portland,sanfrancisco).
nonStopTrain(seattle,portland).

% we can travel from A to B when there is a train from A to B
%  travel can happen in both directions: A to B, and B to A
moving(A,B):-
    nonStopTrain(A,B).
moving(A,B):-
    nonStopTrain(B,A).


% required function 1
canTravel(A,B):-
    travel(A,B,[A],Q). % set path from A


% required function 2
routeTrip(A,B,Trip):-
    travel(A,B,[A],Q), % set path from A
    reverse(Q, Trip). % compare Q and Trip
    					% return true if Q is  reversed of Trip


% basic call
travel(A,B,Trip,[B|Trip]):-
    moving(A,B). % found the destination, add B to PATH
                    % note that this is the final recursive call
                    % so we take action on [B|Trip]
                    % copy all path to result then add B to head of it

% recursive call
travel(A,B,V,Trip):-
    moving(A,X), % loop over all route which start from A
    X \== B, % if X is not B
    \+member(X, V), % be sure that V hasn't contained X
                    %  \+ : cannot be proven
                    %   member(X, V) : X is member of V
                    % this line is true when we cannot prove that X is in V
                    % in Dicrete math we coudl express it like this
                    % not (X in V)
    travel(X,B,[X|V],Trip). % add X to the beginning of V then call recursion

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% question #2
%% sample run: seatingChart(Chart).
%% sample result: Chart = [beth, tom, suse, bob, fay, joe, cami, jim] .
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% female
f(suse).
f(beth).
f(fay).
f(cami).

% male
m(jim).
m(tom).
m(joe).
m(bob).

% hobbies
hobby(suse, yoga).
hobby(jim, chess).

hobby(tom, run).
hobby(tom, yoga).

hobby(joe, run).
hobby(joe, chess).

hobby(cami, yoga).
hobby(cami, run).
hobby(cami, chess).

hobby(bob, yoga).
hobby(bob, run).

hobby(fay, yoga).
hobby(fay, run).
hobby(fay, chess).

hobby(beth, run).
hobby(beth, chess).


% return true if Xand Y has the same hobby
sameHobby(X, Y):-
    hobby(X, H),
    hobby(Y, H).

% we have to check that X and Y aren't both male or both female
notSameGender(X, Y):-
    m(X), f(Y).

% we could use ; "OR" to make write both of them in a function
% but it isn't very clear
notSameGender(X, Y):-
    m(Y), f(X).

% return true if A can sit next to B
connectable(A, B):-
  notSameGender(A, B)
  ,sameHobby(A, B)
  .

% the main function
seatingChart(X):-
  % A and B should be connected first
    connectable(A, B)
    % start from A, try to add peolple to the table
    % the table is assumed empty []
    % P is the path
    , choose(A, B, [], P)
    % copy P to X in  reversed way
    , reverse(P, X)
    .

% check the final condition
choose(A, B, T, [A | T]):-
    % we must end the round with the first one in the round
    % which we put it out to mark the head
    A == B
    % it should not be add to the row
    , \+member(A, T)
    % the round should has 7 people at the moment
    % we note that There will be 8-guests
    % seated at a circular table.
    , length(T, 7)
    .

% recursived function
choose(A, B, T, P):-
    % B could connect to C
    connectable(B, C)
    % B hasn't been in the round
    ,\+member(B, T)
    % add B to round [B | T]
    % check condition of C
    ,choose(A, C, [B | T], P)
    .
