Requirement :
- Install ruby 2.1.3 or upper version

How to play Dice Game :
- Take clone : git clone git@github.com:palash-kulkarni/DiceGame.git
- cd DiceGame
- run `ruby game_manager.rb`

LLD as follows :

Classes :
- GameManager : This is singleton class which have capability to manage N number games and sets up the game for users.
- DiceGame : Main class, which is having the composition of Players, and Dice.
- Dice : Dice is required to play this game and it may have N number of faces. And it will roll to generate points to player.
- Player : Actor who will play this game.
- Rules : This is the module which is injected in DiceGame to set rules for the game.
- Constants : Specifying module to keep centralized contants.


GameManager ---composition---> DiceGame ---composition---> (Dice, Player)
                                   |
                                   |
                               Injecting
                                   |
                                   |
                                   |
                                 Rules