/* CPSC312 Project 2 CLUEDO */
/* Bryan Tai o7m8 & 
   Linh Phan a5i8 */

/*

REMEMBER TO MAKE PREDICATES DYNAMIC
*/



/*
Initially,
Get user to Enter all VALID info in game. Assert into database. 

Ask for:
- 6 weapons
- 6 suspects
- 9 rooms

Keep track of other PLAYERS and the cards they have.
- X players


Each group has POSSIBLE predicates.
Starts as all 21 possible cards. Gets retracted on each player guess.
Once one of each possible card remains, ACCUSATION

Whenever we learn information, Assert that info
*ex the cards in our hand, Retract from POSSIBLE
Each players guess narrows down the possible cards.

-- playerHas card, remove that card from possiblities.


USER INTERFACE

Use write(string) to print words.

playerHas(Player,Card) :- 

playerHas(Linh, "KNIFE").

validplayer("Linh").

validWeapon("KNIFE").
...

possibleweapon("KNIFE").





% List of functions player can use when program is "sleeping"
% TODO
ourTurn:-
FIRST check if we can make an accusation, canMakeAccusation
Ask user for guess info. Room, Weapon, Suspect.
Ask user if someone gave info. Ask to write player name or just Nothing. (Check input against valid players)
    If name, Ask user for what card they gave. Assert playerHas(name, card) 
    Else Nothing, should be able to make accusation IF user does not have cards in guess.

theirTurn:-
First ask whos turn it is, (Prolog will know what they have, playerHas)
Ask user for guess info. Room, Weapon, Suspect.

manuallyAdd:- low priority...

% all the print info, both valid and possible
printAll:- 
printWeapons:-
printRooms:-
printSuspects:-
printPlayers:-

% Helper functions
canMakeAccusation:-  if true, write accusation.

hello :-
write('What is your name ?'),
read(X),
write('Hello'), tab(1), write(X).

*/

/* ========  CODE STARTS HERE =========  */

:- dynamic validWeapon/1.
:- dynamic validSuspect/1.
:- dynamic validRoom/1.
:- dynamic validPlayer/1.
:- dynamic validUser/1.
:- dynamic playerHas/2.


/* SETUP FUNCTIONS */
start :-
write_ln('Welcome! I am the Clue Helper Assistant Thing.'),
write_ln('I\'m here to assist you in playing Clue.'),
write_ln('First of all, I\'ll need the names of all the Weapons, Suspects, Rooms, and Players in this game.'),nl,
write_ln('*** If an ERROR occurs during setup, please type the following commands starting from the step where the error occured.'), 
write_ln('setWeapons,'),
write_ln('setSuspects,'),
write_ln('setRooms,'),
write_ln('setPlayers,'),
write_ln('setUserHand,'),
write_ln('startGame.'),
write_ln('Call each command to manually set up. Or just call start again.'),
setWeapons,
setSuspects,
setRooms,
setPlayers,
setUserHand,
startGame.


reminder :- write_ln('Enter each name one at a time surrounded by APOSTROPHES \' and ending with a PERIOD.').

breakline :- write_ln('===========================').

setWeapons :-
write_ln('Please enter the names of the 6 WEAPONS used in this game.'),
reminder,
write_ln('EXAMPLE: ?- Enter Weapon : \'Knife\'. '),nl,
write_ln('Enter Weapon #1: '), read(X1), assert(validWeapon(X1)),
write_ln('Enter Weapon #2: '), read(X2), assert(validWeapon(X2)),
write_ln('Enter Weapon #3: '), read(X3), assert(validWeapon(X3)),
write_ln('Enter Weapon #4: '), read(X4), assert(validWeapon(X4)),
write_ln('Enter Weapon #5: '), read(X5), assert(validWeapon(X5)),
write_ln('Enter Weapon #6: '), read(X6), assert(validWeapon(X6)),
write_ln('All weapons added!'),
breakline.


setSuspects :-
write_ln('Please enter the names of the 6 SUSPECTS used in this game.'),
reminder,
write_ln('EXAMPLE: ?- Enter Suspect # : \'Scarlet\'. '),nl,
write_ln('Enter Suspect #1: '), read(X1), assert(validSuspect(X1)),
write_ln('Enter Suspect #2: '), read(X2), assert(validSuspect(X2)),
write_ln('Enter Suspect #3: '), read(X3), assert(validSuspect(X3)),
write_ln('Enter Suspect #4: '), read(X4), assert(validSuspect(X4)),
write_ln('Enter Suspect #5: '), read(X5), assert(validSuspect(X5)),
write_ln('Enter Suspect #6: '), read(X6), assert(validSuspect(X6)),
write_ln('All suspects added!'),
breakline.


setRooms :-
write_ln('Please enter the names of the 9 ROOMS used in this game.'),
reminder,
write_ln('EXAMPLE: ?- Enter Room # : \'Ballroom\'. '),nl,
write_ln('Enter Room #1: '), read(X1), assert(validRoom(X1)),
write_ln('Enter Room #2: '), read(X2), assert(validRoom(X2)),
write_ln('Enter Room #3: '), read(X3), assert(validRoom(X3)),
write_ln('Enter Room #4: '), read(X4), assert(validRoom(X4)),
write_ln('Enter Room #5: '), read(X5), assert(validRoom(X5)),
write_ln('Enter Room #6: '), read(X6), assert(validRoom(X6)),
write_ln('Enter Room #7: '), read(X7), assert(validRoom(X7)),
write_ln('Enter Room #8: '), read(X8), assert(validRoom(X8)),
write_ln('Enter Room #9: '), read(X9), assert(validRoom(X9)),
write_ln('All rooms added!'),
breakline.


setPlayers :-
write_ln('Please enter the names of ALL THE PLAYERS in the game. '),
write_ln('Start with YOUR NAME then add names in the order of gameplay (moving left).'),
write_ln('Once you have gone around the whole board, TYPE IN YOUR NAME AGAIN to finish'), 
reminder,
write_ln('EXAMPLE: ?- Enter next Player : \'KURT EISELT\'. '),nl,
write_ln('First, enter YOUR NAME: '), read(User), assert(validUser(User)),
write_ln('Now, enter the PLAYER TO YOUR LEFT: '), read(Name), 
setPlayerHelper(Name).

/* setPlayerHelper/1 
Continues to prompt addition of Players until User writes their own name again
*/
setPlayerHelper(Name) :- not(validUser(Name)), 
assert(validPlayer(Name)),
write_ln('Enter next Player: '), read(NextName), 
setPlayerHelper(NextName).

setPlayerHelper(User) :- validUser(User),
write_ln('All Players added!'),
breakline.


setUserHand :-
write_ln('One last thing, please enter the cards you have.'),
write_ln('Once you\'re finished, type \'DONE\'. '),
write_ln('Enter Card Name : '),
read(Card),
setUserHandHelper(Card).

/* setUserHandHelper/1
Continues to prompt addition of cards in Users hand until they type an invalid card.
*/
setUserHandHelper(Card):- validCard(Card),
validUser(User),
assert(playerHas(User,Card)),
write_ln('Enter Card Name : '),
read(Card2),
setUserHandHelper(Card2).

setUserHandHelper(Done):- not(validCard(Done)),
write_ln('All cards added!'),
breakline.


startGame :-
write_ln('Alright, now we\'re ready to start!'),
breakline.


commands :-
write_ln('Here are the commands you can give me: '),
write_ln('commands :'),
write_ln('Show the list of commands.'),nl,
write_ln('ourTurn :'), 
write_ln('Type this when it\'s our turn and you\'re making a guess.'),nl,
write_ln('theirTurn:'), 
write_ln('Type this when it\'s another player\'s turn and they\'re making a guess.'),nl,
write_ln('printAll:'),
write_ln('Print out all information that we know as of now.'),nl,
write_ln
breakline.

/* INFORMATION FUNCTIONS */

validCard(Card) :- validWeapon(Card).
validCard(Card) :- validSuspect(Card).
validCard(Card) :- validRoom(Card).

possibleWeapon(W) :- validWeapon(W), not( playerHas(_,W)).
possibleSuspect(S):- validSuspect(S), not( playerHas(_,S)).
possibleRoom(R)   :- validRoom(R), not( playerHas(_,R)).

userHas(Card):- validUser(User), playerHas(User,Card).

/* PRINT FUNCTIONS */

printAll :-
printPlayers,nl,
printWeapons,nl,
printSuspects,nl,
printRooms,nl,
breakline.
% Also need to print what each player has

printWeapons :-
write_ln('Weapons in game are : '),
findall(X,validWeapon(X),L1),
write_ln(L1),
write_ln('Possible Weapon answers as of now are : '),
findall(Y,possibleWeapon(Y),L2),
write_ln(L2).

printSuspects :-
write_ln('Suspects in game are : '),
findall(X,validSuspect(X),L1),
write_ln(L1),
write_ln('Possible Suspect answers as of now are : '),
findall(Y,possibleSuspect(Y),L2),
write_ln(L2).

printRooms :-
write_ln('Rooms in game are : '),
findall(X,validRoom(X),L1),
write_ln(L1),
write_ln('Possible Room answers as of now are : '),
findall(Y,possibleRoom(Y),L2),
write_ln(L2).

printPlayers :-
write('Your name is '), validUser(U), write(U),nl,
write_ln('The other Players are : '),
findall(X,validPlayer(X),L),
write_ln(L).
