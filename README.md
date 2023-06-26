# Greed Game
This is a Ruby implementation of the Greed Game. The Greed Game is a dice game where players roll dice to accumulate points. The goal of the game is to score the highest number of points. The rules of greed game can be found [here](greed_rules.md)

## Requirements and Setup
1. Install [Ruby](https://www.ruby-lang.org/en/) and [Ruby Gems](https://rubygems.org/pages/download) on your system. Ruby version > 2.6.6 , Gem version 3.2.3
2. Clone or download the Greed Game code from the repository.
3. Open a terminal or command prompt and navigate to the directory containing the Greed Game code.
4. Make sure you have the required dependencies installed by running the following command:
    ```
    gem install bundler
    bundle install
    ```

## How to Run Specs
The Greed Game code comes with automated tests (specs) to ensure its correctness. To run the specs, follow these steps:
1. Open a terminal or command prompt.
2. Navigate to the directory containing the Greed Game code.
3. Run the following command to execute the specs:
    ```
    rspec spec_*
    ```
    The test results will be displayed in the terminal, indicating whether the code passes all the tests or if there are any failures.

## How to Run the Game
To play the Greed Game, follow these steps:
1. Open a terminal or command prompt.
2. Navigate to the directory containing the Greed Game code.
3. Run the following command to start the game:
    ```
    ruby main.rb
    ```
4. The game will prompt you to enter the number of players. Enter the desired number and press Enter.
5. The game will start, and each player will take turns rolling the dice and accumulating points.
6. Follow the on-screen instructions to play the game. Enter 'y' or 'n' to indicate whether to roll the remaining non-scoring dice.
7. After the game ends, the final scores of all players will be displayed, and the winner will be announced.

## Notes
1. The game follows the rules of the Greed Game as implemented in the code.
2. The code uses random numbers to simulate dice rolls. Therefore, the outcome of the game may vary each time it is played.
3. The code includes comments to explain its functionality and logic.

