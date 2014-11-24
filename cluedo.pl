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

% List of functions player can use
makeAGuess:-
manuallyAdd:-
all the print info


*/

:- dynamic validWeapon/1.

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

isValidWeapon(X) :- validWeapon(X).

printValidWeapons :-
write_ln('Valid weapons are : '),
findall(X,validWeapon(X),L),
write_ln(L).


