/* CPSC312 Project 2 CLUEDO */
/* Bryan Tai o7m8 & 
   Linh Phan a5i8 */

/*

REMEMBER TO MAKE PREDICATES DYNAMIC
*/



/*
Initially,
Get user to Enter all VALID info in game. AssertThis into database. 

Ask for:
- 6 weapons
- 6 suspects
- 9 rooms

Keep track of other PLAYERS and the cards they have.
- X players


Each group has POSSIBLE predicates.
Starts as all 21 possible cards. Gets retracted on each player guess.
Once one of each possible card remains, ACCUSATION

Whenever we learn information, AssertThis that info
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


CAN USE AGGREGATE/3 TO COUNT NUMBER OF POSSIBILITIES
aggregate(count, X^permutation([1,2,3,4], X), N).
N = 24.
X^ means "there exists X", so the whole formula means something like "count the number of ways that permutation([1,2,3,4],X) succeeds for some X and call that number N."
OR FINDALL, GET LENGTH OF L
ex
countnumbers(X) :-
    findall(N, number(N), Ns),
    length(Ns, X).



% List of functions player can use when program is "sleeping"
% TODO
ourTurn:-
canMakeAccusation,
write_ln('Please write weapon:'),read(W),
write_ln('Please write room:'),read(R),
write_ln('Please write suspect:'),read(S),
write_ln('Did anyone give you information for your guess?'),read(Name),
write_ln('Oh good. What did they show you?'),read(Card),assertThis(playerHas(Name,Card)),
canMakeAccusation.

FIRST check if we can make an accusation, canMakeAccusation
Ask user for guess info. Room, Weapon, Suspect.
Ask user if someone gave info. Ask to write player name or just Nothing. (Check input against valid players)
    If name, Ask user for what card they gave. AssertThis playerHas(name, card) 
    Else Nothing, should be able to make accusation IF user does not have cards in guess.
Give a suggestion for our next guess, based on what we know.



theirTurn:-
First ask whos turn it is, (Prolog will know what they have, playerHas)
Ask user for that players guess info. Room, Weapon, Suspect.
Ask user if someone gave info. Ask to write player name or just Nothing.
Compare the players guess info with what they have and what everyone else has.

Give a suggestion for our next guess, based on what we know.

manuallyAdd:- low priority...

% all the print info, both valid and possible
printAll:- 
printWeapons:-
printRooms:-
printSuspects:-
printPlayers:-

% Helper functions
canMakeAccusation :-
findall(X,possibleRoom(X),LR),
findall(X,possibleSuspect(X),LS),
findall(X,possibleWeapon(X),LW),
all3Single(LR,LS,LW),
write_ln('Time to start accusing!'),
write_ln('Weapon'),write_ln(LW),write_ln('Suspect'),write_ln(LS),write_ln('Room'),write_ln(LR).


canMakeAccusation :-
findall(X,possibleRoom(X),LR),
findall(X,possibleSuspect(X),LS),
findall(X,possibleWeapon(X),LW),
(not(all3Single(LR,LS,LW))).


all3Single(L1,L2,L3) :- length(L1,1),length(L2,1),length(L3,1).

hello :-
write('What is your name ?'),
read(X),
write('Hello'), tab(1), write(X).


all3AreSingle

*/

/* ========  CODE STARTS HERE =========  */

:- dynamic validWeapon/1.
:- dynamic validSuspect/1.
:- dynamic validRoom/1.
:- dynamic validPlayer/1.
:- dynamic validUser/1.
:- dynamic playerOrderIs/2.
:- dynamic playerHas/2.
:- dynamic playerCannotHas/2.

% borrowed from stackOverflow
% Only asserts things once.
assertThis(Fact):-
\+( Fact ),!,         % \+ is a NOT operator.
assert(Fact).
assertThis(_).




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
write_ln('beginGame.'),
write_ln('Call each command to manually set up. Or just call start again.'),
setWeapons,
setSuspects,
setRooms,
setPlayers,
setUserHand,
printAll,
beginGame.


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
setPlayerHelper(User, Name).

/* setPlayerHelper/2 
Continues to prompt addition of Players until User writes their own name again
Also sets first name to go before second name.
*/
setPlayerHelper(PastName, Name) :- not(validUser(Name)), 
assert(validPlayer(Name)),
assert(playerOrderIs(PastName,Name)),
write_ln('Enter next Player: '), read(NextName), 
setPlayerHelper(Name,NextName).

setPlayerHelper(PastName,User) :- validUser(User),
assert(playerOrderIs(PastName,User)),
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
assertThis(playerHas(User,Card)),
write_ln('Enter Card Name : '),
read(Card2),
setUserHandHelper(Card2).

setUserHandHelper(Done):- not(validCard(Done)),
write_ln('All cards added!'),
breakline.


beginGame :-
write_ln('Alright, now we\'re ready to begin!'),nl,
commands,
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
breakline.

/* INFORMATION FUNCTIONS */

ourTurn:-
canMakeAccusation,
write_ln('Please write weapon:'),read(W),
write_ln('Please write room:'),read(R),
write_ln('Please write suspect:'),read(S),
write_ln('Did anyone give you information for your guess?'),read(Name),
ourTurnHandler(W,R,S,Name,Card),
canMakeAccusation.

% If somebody gave name that is valid
ourTurnHandler(W,R,S,Name,Card) :-
validPlayer(Name),
write_ln('Oh good. What did they show you?'),read(Card),
assertThis(playerHas(Name,Card)).


% If somebody gave name that does not exists
ourTurnHandler(W,R,S,Name,Card) :-
not(validPlayer(Name)),
write_ln('Nobody told you anything').

canMakeAccusation :-
findall(X,possibleRoom(X),LR),
findall(X,possibleSuspect(X),LS),
findall(X,possibleWeapon(X),LW),
all3Single(LR,LS,LW),
write_ln('Time to start accusing!'),
write_ln('Weapon'),write_ln(LW),write_ln('Suspect'),write_ln(LS),write_ln('Room'),write_ln(LR).

canMakeAccusation :-
findall(X,possibleRoom(X),LR),
findall(X,possibleSuspect(X),LS),
findall(X,possibleWeapon(X),LW),
(not(all3Single(LR,LS,LW))).

all3Single(L1,L2,L3) :- length(L1,1),length(L2,1),length(L3,1).


theirTurn:-
write_ln('Who\'s turn is it? Type the Player\'s name.'),
write_ln('Enter Player Name : '),read(PlayerTurn),nl,
write_ln('Which WEAPONS did they guess?'),
write_ln('Enter Weapon guess : '),read(W),nl,
write_ln('Which SUSPECT did they guess?'),
write_ln('Enter Suspect guess : '),read(S),nl,
write_ln('Which ROOM did they guess?'),
write_ln('Enter Room guess : '),read(R),nl,
write_ln('Did anyone give them information? If so, enter that Player\'s name. If not, enter \'NONE\'.'),
write_ln('Enter Player name : '),read(PlayerInfo),nl,
theirTurnHandler(PlayerTurn,W,S,R,PlayerInfo),
breakline.

% If somebody gave info...
% And they are right next to the player...
% Check if 2 out of 3 cards are known. 
% The last card is what PInfo playerHas.
theirTurnHandler(PTurn,W,S,R,PInfo) :-
validPlayer(PInfo),
% playerOrderIs(PTurn,PInfo),
handle2OutOf3(W,S,R,PInfo).
/*
% If somebody gave info...
% But they go a few turns after the player...
% The players that passed cannot have those cards.
% Check if 2 out of 3 cards are known. 
% The last card is what PInfo playerHas.
theirTurnHandler(PTurn,W,S,R,PInfo) :-
validPlayer(PInfo),
not(playerOrderIs(PTurn,PInfo)),
*/

% Else If nobody gave info...
% They might have just won.
% Need to compare their guess to what playerCannotHas.
theirTurnHandler(PTurn,W,S,R,None) :- 
not(validPlayer(None)),
write_ln('Uhoh...They might have just won.').

/*
First ask whos turn it is, (Prolog will know what they have, playerHas)
Ask user for that players guess info. Room, Weapon, Suspect.
Ask user if someone gave info. Ask to write player name or just Nothing.
Compare the players guess info with what they have and what everyone else has.

Give a suggestion for our next guess, based on what we know.
*/

% 3 cards are guessed and Player PInfo answered.
% if exactly 2 are known to be held by players,
% then the third card must be held by PInfo.
% If less than 2 of those 3 cards are known,
% Or we already know who has all 3 cards,
% Or the person who gave info was User,
% we cannot assertThis anything new.

handle2OutOf3(W,S,R,PInfo) :-
not(validUser(PInfo)),
[W,S,R] = X,
findall(C,selectNoOneHas(X,C),L),
handleNoOneHas(L,PInfo).

handle2OutOf3(_,_,_,User) :-
validUser(User),
write_ln('Shoot. I can\'t get anything new from that.').

handleNoOneHas(L,_) :- not(length(L,1)), 
write_ln('Darn. I can\'t get anything new from that.').

handleNoOneHas(L,PInfo) :- length(L,1), 
L = [Card],
assertThis(playerHas(PInfo,Card)),
write('Hmm, I already know who holds two out of those three cards. Therefore the third card '), write(Card), write(' must be held by '), write(PInfo),nl.


/* INFO HELPERS */
validCard(Card) :- validWeapon(Card).
validCard(Card) :- validSuspect(Card).
validCard(Card) :- validRoom(Card).

% User is also a validPlayer...
validPlayer(User) :- validUser(User).

possibleCard(C) :- possibleWeapon(C).
possibleCard(C) :- possibleSuspect(C).
possibleCard(C) :- possibleRoom(C).

possibleWeapon(W) :- validWeapon(W),  not( playerHas(_,W)).
possibleSuspect(S):- validSuspect(S), not( playerHas(_,S)).
possibleRoom(R)   :- validRoom(R),    not( playerHas(_,R)).

someoneHas(Card) :- validCard(Card), playerHas(_,Card).

/* selectNoOneHas/2
Card is a validCard from list of SomeCards that nobody has yet.
*/
selectNoOneHas([Card|T],Card):- validCard(Card),not(someoneHas(Card)).
selectNoOneHas([H|T], Card) :- selectNoOneHas(T,Card).

userHas(Card):- validCard(Card), validUser(User), playerHas(User,Card).

/* playerCannotHas/2
Player cannot possibly be holding Card (made guess, did not supply info)
*/

/* playerOrderIs/2
playerOrderIs(FirstP,SecondP)
first player goes before the second player.

*/

% If number of playerCannotHas for certain card is one less than number of players, then the last player must have that card playerHas(Last, Card)

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
write_ln('The order of players is : '),
findall(X,validPlayer(X),L),
write_ln(L).


% Quickly sets up game with shortened default Clue names. Just add Players.
quickStart :-
assert(validWeapon('Knife')),
assert(validWeapon('Candle')),
assert(validWeapon('Wrench')),
assert(validWeapon('Gun')),
assert(validWeapon('Rope')),
assert(validWeapon('Pipe')),

assert(validSuspect('Scarlet')),
assert(validSuspect('Mustard')),
assert(validSuspect('Green')),
assert(validSuspect('Peacock')),
assert(validSuspect('Plum')),
assert(validSuspect('White')),

assert(validRoom('Hall')),
assert(validRoom('Kitchen')),
assert(validRoom('Dining')),
assert(validRoom('Library')),
assert(validRoom('Billiard')),
assert(validRoom('Ballroom')),
assert(validRoom('Conservatory')),
assert(validRoom('Study')),
assert(validRoom('Lounge')),

setPlayers,
setUserHand,
printAll,
beginGame.

