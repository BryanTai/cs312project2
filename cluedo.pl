/* CPSC312 Project 2 CLUEDO */
/* Bryan Tai o7m8 & 
   Linh Phan a5i8 */

/*

REMEMBER TO MAKE PREDICATES DYNAMIC
*/



/*
Initially,
Get user to Enter all VALID info in game. Assert into database. 

print this
"Please write ' setWeapons("FIRSTWEAPON", "SECONDWEAPON"... ). ' to enter the 6 valid weapons usedin this game.
ex: setWeapons ("Knife","Revolver","Lead Pipe","Candlestick","Rope","Wrench").
"

"Please enter the 6 weapons used in this game.
Enter them one at a time surrounded by apos ' and ended with period.

ex: 
?- enter weapon: 'Knife'.
"
USE read(X) predicate 6 times.



- 6 weapons
- 6 suspects
- 9 rooms

Keep track of other PLAYERS and the cards they have.
- X players

playerMadeAGuess


Each group has POSSIBLE predicates.
Starts as all 21 possible cards. Gets retracted on each player guess.
Once one of each possible card remains, ACCUSATION

Whenever we learn information, Assert that info
*ex the cards in our hand, Retract from POSSIBLE
Each players guess narrows down the possible cards.

playerHas card, remove that card from possiblities.


USER INTERFACE

Use write(string) to print words.

playerHas(Player,Card) :- 

playerHas(Linh, "KNIFE").

validplayer("Linh").

validWeapon("KNIFE").
...

possibleweapon("KNIFE").




start :-
write_ln('Welcome! I am the Clue Helper Assistant Thing.'),
write_ln('I\'m here to assist you in playing Clue.'),
setWeapons,
setSuspects,
setRooms,
setPlayers,
startGame.


startGame :-
write_ln('One last thing, please enter the cards you have.'),


write_ln('Okay, we\'re ready to go'),
.

% List of functions player can use when program is "sleeping"
% TODO
ourTurn:-
FIRST check if we can make an accusation, canMakeAccusation
Ask user for guess info. Room, Weapon, Suspect.
Ask user if someone gave info. Ask to write player name or just Nothing. (Check input against valid players)
    If name, Ask user for what card they gave. Assert playerHas(name, card) 
    Else Nothing, should be able to make accusation IF user does not have cards in guess.

theirTurn:-


manuallyAdd:- low priority...

% all the print info, both valid and possible
printAll:- 
printWeapons:-
printRooms:-
printSuspects:-
printPlayers:-

% Helper functions
canMakeAccusation:-  if true, write accusation.




*/

/*  CODE STARTS HERE  */

:- dynamic validWeapon/1.
:- dynamic notPossibleWeapon/1.
:- dynamic playerHas/2.

hello :-
write('What is your name ?'),
read(X),
write('Hello'), tab(1), write(X).


reminder :- write_ln('Enter each name one at a time surrounded by APOSTROPHES \' and ending with a PERIOD.').

setWeapons :-
write_ln('Please enter the 6 weapons used in this game.'),
reminder,
write_ln('EXAMPLE: ?- Enter Weapon : \'Knife\'. '),
write_ln(' '),
write_ln('Enter Weapon #1: '), read(X1), assert(validWeapon(X1)),
write_ln('Enter Weapon #2: '), read(X2), assert(validWeapon(X2)),
write_ln('Enter Weapon #3: '), read(X3), assert(validWeapon(X3)),
write_ln('Enter Weapon #4: '), read(X4), assert(validWeapon(X4)),
write_ln('Enter Weapon #5: '), read(X5), assert(validWeapon(X5)),
write_ln('Enter Weapon #6: '), read(X6), assert(validWeapon(X6)),
write_ln('All weapons added!').

/*
setSuspects :-
setRooms :-


setPlayers :-
*/

possibleWeapon(W) :- not( playerHas(_,W)).

printWeapons :-
write_ln('Valid weapons are : '),
findall(X,validWeapon(X),L1),
write_ln(L1),
write_ln('Possible weapons are : '),
findall(Y,possibleWeapon(Y),L2),
write_ln(l2).



