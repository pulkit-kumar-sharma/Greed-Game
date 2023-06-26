require_relative 'dice_set'
require 'rspec'

RSpec.describe DiceSet do
  describe '#initialize' do
    it 'should initialize the DiceSet with the given number of dices' do
      dice = DiceSet.new(5)
      expect(dice.number_of_dices).to eq(5)
      expect(dice.roll_result).to eq([])
      expect(dice.non_scoring_dices).to eq(0)
    end
  end

  describe '#roll' do
    it 'should roll the dice and return an array with values between 1 and 6' do
      dice = DiceSet.new(5)
      roll_result = dice.roll()
      expect(roll_result.length).to eq(dice.number_of_dices)
      roll_result.each do |value|
        expect(value).to be_between(1, 6).inclusive
      end
    end
  end

  describe '#score' do
    it 'should calculate the score correctly for three 1 ' do
      dice = DiceSet.new(5)
      dice.roll_result = [1, 1, 1, 4, 5]
      score = dice.score()
      expect(score).to eq(1050)
      expect(dice.non_scoring_dices).to eq(1)
    end
    it 'should calculate the score correctly for three 2 ' do
      dice = DiceSet.new(5)
      dice.roll_result = [1, 2, 2, 2, 5]
      score = dice.score()
      expect(score).to eq(350)
      expect(dice.non_scoring_dices).to eq(0)
    end
    it 'should calculate the score correctly for three 3 ' do
      dice = DiceSet.new(5)
      dice.roll_result = [3, 2, 3, 2, 3]
      score = dice.score()
      expect(score).to eq(300)
      expect(dice.non_scoring_dices).to eq(2)
    end
    it 'should calculate the score correctly for three 4 ' do
      dice = DiceSet.new(5)
      dice.roll_result = [5, 4, 3, 4, 4]
      score = dice.score()
      expect(score).to eq(450)
      expect(dice.non_scoring_dices).to eq(1)
    end
    it 'should calculate the score correctly for three 5 ' do
      dice = DiceSet.new(5)
      dice.roll_result = [5, 4, 5, 4, 5]
      score = dice.score()
      expect(score).to eq(500)
      expect(dice.non_scoring_dices).to eq(2)
    end
    it 'should calculate the score correctly for three 6 ' do
      dice = DiceSet.new(5)
      dice.roll_result = [5, 6, 5, 6, 6]
      score = dice.score()
      expect(score).to eq(700)
      expect(dice.non_scoring_dices).to eq(0)
    end
    it 'should calculate the score correctly for two 2 or two 3' do
      dice = DiceSet.new(5)
      dice.roll_result = [2, 2, 3, 3, 4]
      score = dice.score()
      expect(score).to eq(0)
      expect(dice.non_scoring_dices).to eq(5)
    end
    it 'should calculate the score correctly for two 4 or two 6' do
      dice = DiceSet.new(5)
      dice.roll_result = [6, 4, 5, 6, 4]
      score = dice.score()
      expect(score).to eq(50)
      expect(dice.non_scoring_dices).to eq(4)
    end
    it 'should calculate the score correctly for number greater than 6' do
      dice = DiceSet.new(5)
      dice.roll_result = [7, 4, 7, 6, 4]
      score = dice.score()
      expect(score).to eq(0)
      expect(dice.non_scoring_dices).to eq(5)
    end
    it 'should calculate the score correctly for number less than 0' do
      dice = DiceSet.new(5)
      dice.roll_result = [-1, -2, 5, 6, 4]
      score = dice.score()
      expect(score).to eq(50)
      expect(dice.non_scoring_dices).to eq(4)
    end
    it 'should calculate the score correctly for all negative numbers' do
      dice = DiceSet.new(4)
      dice.roll_result = [-1, -2, -5, -6]
      score = dice.score()
      expect(score).to eq(0)
      expect(dice.non_scoring_dices).to eq(4)
    end
    it 'should calculate the score correctly for all numbers greater than 6' do
      dice = DiceSet.new(5)
      dice.roll_result = [8, 9, 10, 11, 12]
      score = dice.score()
      expect(score).to eq(0)
      expect(dice.non_scoring_dices).to eq(5)
    end
    it 'should calculate the score correctly for two 1' do
      dice = DiceSet.new(5)
      dice.roll_result = [1, 2, 1, 4, 5]
      score = dice.score()
      expect(score).to eq(250)
      expect(dice.non_scoring_dices).to eq(2)
    end
    it 'should calculate the score correctly for two dices' do
      dice = DiceSet.new(2)
      dice.roll_result = [5, 1]
      score = dice.score()
      expect(score).to eq(150)
      expect(dice.non_scoring_dices).to eq(0)
    end
    it 'should calculate the score correctly for three dices' do
      dice = DiceSet.new(2)
      dice.roll_result = [5, 1, 5]
      score = dice.score()
      expect(score).to eq(200)
      expect(dice.non_scoring_dices).to eq(0)
    end
    it 'should calculate the score correctly for three similar dices' do
      dice = DiceSet.new(2)
      dice.roll_result = [3, 3, 3]
      score = dice.score()
      expect(score).to eq(300)
      expect(dice.non_scoring_dices).to eq(0)
    end
    it 'should calculate the score correctly for three non scoring dices' do
      dice = DiceSet.new(2)
      dice.roll_result = [3, 2, 3]
      score = dice.score()
      expect(score).to eq(0)
      expect(dice.non_scoring_dices).to eq(3)
    end
  end

  describe '#non_scoring_dices' do
    it 'should return the number of non-scoring dices' do
      dice = DiceSet.new(5)
      dice.non_scoring_dices = 2
      non_scoring = dice.non_scoring_dices()
      expect(non_scoring).to eq(2)
    end
  end
end
