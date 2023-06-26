require_relative 'greed_game'

system "clear"
puts "=========== Welcome to GREED Game ==========="

number_of_players = nil
loop do
  print "Enter Number of Players: "
  input = gets.chomp

  begin
    number_of_players = Integer(input)
    break if number_of_players.positive?
    puts "Number of players must be a positive integer."
  rescue ArgumentError
    puts "Invalid input. Please enter a positive integer."
  end
end

game = GreedGame.new(number_of_players)
game.start_game
game.game_result
