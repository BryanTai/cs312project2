CPSC312 Project 2 CLUEDO

Bryan Tai o7m8 & 
Linh Phan a5i8 


*** User Documentation for the Clue Helper Assistant Thing (CHAT) ***

This program is designed to assist you in playing the board game CLUE. 
Whenever you or another player makes a guess, enter that information into
SWI-Prolog console using the appropriate commands. Think of this as a super
advanced version of the note paper. You just have to worry about rolling the
dice and hiding your cards.

To start CHAT, enter "start." into SWI-Prolog.

Alternatively, enter "quickStart." to use default CLUE board values.

Enter "commands." to see the list of usable commands.


*** Description of the Commands for TAs ***
Our project meets the baseline requirements.
Additionally, we attempt to add more information during other player's turns
by comparing their guesses to the information we already know.


ourTurn: Adds information on our turn.
 
First checks if we can already make an accusation.
Then makes a SUGGESTION for a guess based on information we already have.
Then asks user for their guess information (room, weapon, and suspect).
Asks user if other players have given any information, 
If they have, asks user for what card they gave and then asserts that info as playerHas(name, card).

theirTurn: Hopefully adds information on their turn.

First ask whose turn it is.
Then ask user for that player's guessed information (room, weapon, and suspect). Ask user if someone gave any information and to write that player’s
name. If no one gave that player info, return nothing.
If someone did, compare the original guess to what is already known.
If 2 out of the 3 cards in the guess are already held by players, then we can
assert that the 3rd card is the mystery card that was presented to the original player.

validCards: Cards that are used in game.

possibleCards: Valid cards that can possibly be the answer.


canMakeAccusation: Function periodically checks the database for all the possible weapons, suspects, and rooms. If at any moment there’s only one of each possible card, it alerts the user to make a full-blown game-ending accusation. Otherwise, it returns nothing.

all3Single: Helper function used in canMakeAccusation that returns true if list of weapons, list of suspects, and list of rooms has 1 element from each of the group. This then in turn will help accusation.

start: Initializes the game and asks for manual CLUE board values, players, and cards.

quickStart: Initializes CLUE board values. Asks for players and cards.

printAll: Prints out all the information user has so far.

playerHas: Keeps track of which player is holding which cards.