require_relative 'dice_set'
require_relative 'player'

class GreedGame
    attr_accessor :players
    attr_accessor :num_of_dices
    attr_accessor :dices
    attr_accessor :number_of_turns
    attr_accessor :game_ended


    LAST_TURN_SCORE = 3000
    MIN_ACCUMULATION_SCORE = 300

    def initialize(number_of_players="2", number_of_dices="5")
      @num_of_dices = number_of_dices
      @players = []

      number_of_players.times do |index|
        player_name = (index + 1).to_s
        player = Player.new(player_name)
        players << player
      end

      @number_of_turns = 0
      @game_ended = false
    end

    def print_game_stats
      no_of_players = players.size
      (1..no_of_players).each do |player_num|
        player = players[player_num-1]
        puts "Player #{player_num} Score : " + player.total_score.to_s
      end
    end

    def start_game
      no_of_players = players.size
      no_of_dices = @num_of_dices
      puts "Starting the Game with #{no_of_players} Players and #{no_of_dices} Dices ... "
      last_turn = false
      last_turn_executed = false
      player_excluded_from_last_turn = -1

      while (true)
        puts last_turn ? "Last Turn : " : "Turn #{number_of_turns + 1} : "
        puts "-----------------------------------------"
        (1..no_of_players).each do |player_num|
          no_of_dices = @num_of_dices
          roll_again = true
          total_score_in_this_turn = 0
          player = players[player_num-1]

          if(player.name.to_i == player_excluded_from_last_turn.to_i)
            puts "Player #{player.name} Has Been Excluded From The Last Turn"
            next
          end

          while (roll_again)
            dice_set = DiceSet.new(no_of_dices)
            puts "Player #{player_num} rolls: " + dice_set.roll.to_s
            score = dice_set.score
            puts "Score in this round: " + score.to_s
            total_score_in_this_turn += score
            if(score == 0)
              total_score_in_this_turn = 0
              puts "Total Score In This Turn For Player #{player_num}: " + total_score_in_this_turn.to_s
              puts last_turn ? "===== Last Turn Ends For Player #{player_num} =====" : "===== Turn #{number_of_turns + 1} Ends For Player #{player_num} ====="
              roll_again = false
            else
              puts "Total Score In This Turn For Player #{player_num}: " + total_score_in_this_turn.to_s
              puts "Non scoring dices : " + dice_set.non_scoring_dices.to_s
              if(dice_set.non_scoring_dices == 0)
                puts "All Dices Scored in this Roll"
                print "Player #{player_num}, Do you want to roll all the 5 dices? (y/n): "
                roll_again = gets.chomp().downcase() == 'y' ? true : false
                if(roll_again)
                  no_of_dices = 5
                else
                  puts last_turn ? "===== Last Turn Ends For Player #{player_num} =====" : "===== Turn #{number_of_turns + 1} Ends For Player #{player_num} ====="
                end
              end
              if(dice_set.non_scoring_dices > 0)
                print "Player #{player_num}, Do you want to roll the remaining #{dice_set.non_scoring_dices} non-scoring dices? (y/n): "
                roll_again = gets.chomp().downcase() == 'y' ? true : false
                if(roll_again)
                  no_of_dices = dice_set.non_scoring_dices
                else
                  puts last_turn ? "===== Last Turn Ends For Player #{player_num} =====" : "===== Turn #{number_of_turns + 1} Ends For Player #{player_num} ====="
                end
              end
            end
          end
          if(!player.accumulation_started)
            if(total_score_in_this_turn.to_i >= MIN_ACCUMULATION_SCORE)
              player.accumulation_started = true
              player.total_score += total_score_in_this_turn.to_i
              puts "Total score of Player #{player_num} after #{last_turn ? 'Last Turn' : "Turn #{number_of_turns + 1}"}: #{player.total_score}"
            else
              puts "Player #{player_num} scored less than #{MIN_ACCUMULATION_SCORE} in this Turn. These points will NOT be Accumulated"
            end
          else
            player.total_score += total_score_in_this_turn.to_i
            puts "Total score of Player #{player_num} after #{last_turn ? 'Last Turn' : "Turn #{number_of_turns + 1}"}: #{player.total_score}"
          end
          if(player.total_score >= LAST_TURN_SCORE && last_turn == false)
            puts "Player #{player_num} has exccedded the score of #{LAST_TURN_SCORE}. Hence LAST TURN has been Started. All other players have got 1 turn left"
            player_excluded_from_last_turn = player_num
            last_turn = true
            puts "Player #{player_excluded_from_last_turn} has been excluded from last turn"
            break
          end

        end

        puts "Game Stats After #{last_turn_executed ? 'Last Turn' : "Turn #{number_of_turns + 1}"}: "
        print_game_stats
        @number_of_turns += 1

        if last_turn_executed
          break
        end
        if last_turn
          last_turn_executed = true
        end
      end
    end

    def game_result
        max_score_player = -1
        max_score = -1
        players.each do |player|
          if(player.total_score > max_score)
            max_score_player = player.name
            max_score = player.total_score
          end
        end
        puts "******************** Winner Is : Player #{max_score_player} ********************"
    end
end
