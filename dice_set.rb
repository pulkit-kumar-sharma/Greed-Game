class DiceSet

  attr_accessor :number_of_dices
  attr_accessor :roll_result
  attr_accessor :non_scoring_dices

  # Initalize the Dice with the given number, and sets the roll result to 0 for all dices
  def initialize(num_of_dices)
      @number_of_dices = num_of_dices.to_i
      @roll_result = []
      @non_scoring_dices = 0
  end

  # Rolls the Dice and returns the result in an Array
  def roll()
      @roll_result = []
      @number_of_dices.times { @roll_result << rand(1..6) }
      return @roll_result
  end

#   Calculates the Score of the roll
  def score()
      dice_value_hash = Hash[
          1 => 0,
          2 => 0,
          3 => 0,
          4 => 0,
          5 => 0,
          6 => 0
      ]

      roll_result.each do |value|
        if(value >= 1 and value <= 6)
          dice_value_hash[value] += 1
        else
            @non_scoring_dices += 1
        end
      end

      score = 0
      dice_value_hash.each do |key, value|
        # If count of dice is >= 3 for dices with values (1,2,3,4,5,6) then the value (1000,200,300,400,500,600) is added to the score respectively.
        # For the remaining dices or if the count is less than 3 for dices with values (1,2,3,4,5,6) then the value (100,0,0,0,50,0)*number_of_dices is added to the score respectively.
          case key
          when 1
              score += dice_value_hash[1] >= 3 ? 1000 + (dice_value_hash[1] - 3)*100 : dice_value_hash[1]*100
          when 2
              score += dice_value_hash[2] >= 3 ? 200 + (dice_value_hash[2] - 3)*0 : dice_value_hash[2]*0
              @non_scoring_dices += dice_value_hash[2] >= 3 ? dice_value_hash[2]-3 : dice_value_hash[2]
          when 3
              score += dice_value_hash[3] >= 3 ? 300 + (dice_value_hash[3] - 3)*0 : dice_value_hash[3]*0
              @non_scoring_dices += dice_value_hash[3] >= 3 ? dice_value_hash[3]-3 : dice_value_hash[3]
          when 4
              score += dice_value_hash[4] >= 3 ? 400 + (dice_value_hash[4] - 3)*0 : dice_value_hash[4]*0
              @non_scoring_dices += dice_value_hash[4] >= 3 ? dice_value_hash[4]-3 : dice_value_hash[4]
          when 5
              score += dice_value_hash[5] >= 3 ? 500 + (dice_value_hash[5] - 3)*50 : dice_value_hash[5]*50
          when 6
              score += dice_value_hash[6] >= 3 ? 600 + (dice_value_hash[6] - 3)*0 : dice_value_hash[6]*0
              @non_scoring_dices += dice_value_hash[6] >= 3 ? dice_value_hash[6]-3 : dice_value_hash[6]
          end
      end
      return score
  end

  # Returns the number of non scoring dices
  def non_scoring_dices()
      return @non_scoring_dices
  end
end
