require_relative 'dice_set'
require_relative 'player'
require_relative 'greed_game'

RSpec.describe GreedGame do
  let(:number_of_players) { 2 }
  let(:number_of_dices) { 5 }
  let(:game) { GreedGame.new(number_of_players, number_of_dices) }

  describe '#initialize' do
    it 'creates the specified number of players' do
      expect(game.players.size).to eq(number_of_players)
    end

    it 'creates a dice set with the specified number of dices' do
      expect(game.num_of_dices).to eq(number_of_dices)
    end

    it 'sets the number of turns to 0' do
      expect(game.number_of_turns).to eq(0)
    end

    it 'sets the game_ended flag to false' do
      expect(game.game_ended).to be_falsey
    end
  end

  describe '#print_game_stats' do
    it 'prints the scores of all players' do
      player1 = instance_double(Player, total_score: 100)
      player2 = instance_double(Player, total_score: 200)
      allow(game).to receive(:players).and_return([player1, player2])

      expect { game.print_game_stats }.to output("Player 1 Score : 100\nPlayer 2 Score : 200\n").to_stdout
    end
  end

  describe '#start_game' do
    context 'when a player rolls non-scoring dice and decides to stop rolling' do
      it 'accumulates points for the turn and adds them to the total score' do
        player1 = Player.new('1')
        player1.accumulation_started = true
        allow(Player).to receive(:new).and_return(player1)

        dice_set = DiceSet.new(5)
        dice_set.roll_result = [5, 6, 3, 6, 6]
        allow(DiceSet).to receive(:new).and_return(dice_set)

        allow(STDIN).to receive(:gets).and_return('n')

        game.start_game

        expect(player1.total_score).to be >= GreedGame::MIN_ACCUMULATION_SCORE
      end
    end


    context 'when a player rolls a zero-point roll' do
      it 'loses the turn and the accumulated score for that turn' do
        game1 = GreedGame.new(2, 5)
        player5 = Player.new('5')
        allow(Player).to receive(:new).and_return(player5)
        allow(STDIN).to receive(:gets).and_return('y')

        dice_set = DiceSet.new(5)
        dice_set.roll_result = [2, 2, 3, 3, 6]
        allow(DiceSet).to receive(:new).and_return(dice_set)

        game1.start_game

        allow(STDIN).to receive(:gets).and_return('n') # Simulate a zero-point roll
        previous_accumulated_score = player5.total_score
        game1.start_game

        expect(player5.total_score).to eq(previous_accumulated_score)
      end
    end

  context 'when a player reaches 3000 points' do
    it "enters the final round when a player reaches 3000 points" do
      player1 = Player.new(1)
      player2 = Player.new(2)
      player3 = Player.new(3)
      game = GreedGame.new(3, 5)
      game.players = [player1, player2, player3]
      dice_set = DiceSet.new(5)
      dice_set.roll_result = [2, 2, 3, 3, 6]
      allow(DiceSet).to receive(:new).and_return(dice_set)

      allow(player1).to receive(:total_score).and_return(2700)
      allow(player2).to receive(:total_score).and_return(3100)
      allow(player3).to receive(:total_score).and_return(2900)

      expect { game.start_game }.to output(/Player 2 has exccedded the score of 3000. Hence LAST TURN has been Started. All other players have got 1 turn left/).to_stdout
    end
  end

  end

  describe '#game_result' do
    context 'when there is a winner after the final round' do
      it 'prints the winner of the game' do
        player1 = Player.new('1')
        player2 = Player.new('2')
        player1.total_score = 3500
        player2.total_score = 3200
        allow(game).to receive(:players).and_return([player1, player2])

        expect { game.game_result }.to output("******************** Winner Is : Player 1 ********************\n").to_stdout
      end
    end
  end

  describe '#game_result' do
    it 'prints the winner of the game' do
      player1 = instance_double(Player, name: '1', total_score: 100)
      player2 = instance_double(Player, name: '2', total_score: 200)
      allow(game).to receive(:players).and_return([player1, player2])

      expect { game.game_result }.to output("******************** Winner Is : Player 2 ********************\n").to_stdout
    end
  end
end
