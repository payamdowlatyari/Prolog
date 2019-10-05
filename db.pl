nonStopTrain(sandiego,oceanside). 
nonStopTrain(lasvegas,sandiego). 
nonStopTrain(sanfrancisco,bakersfield). 
nonStopTrain(bakersfield,sandiego). 
nonStopTrain(oceanside,losangeles). 
nonStopTrain(portland,sanfrancisco). 
nonStopTrain(seattle,portland). 


canTravel(A, B) :- nonStopTrain(A, C) , nonStopTrain(C, B).
canTravel(B, A) :-  nonStopTrain(A, B).

member(X, [X|T]).
member(X, [H|T]) :- member(X,T). 


