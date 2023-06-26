require_relative 'player'

RSpec.describe Player do
  let(:name) { 'John' }
  let(:player) { Player.new(name) }

  describe '#initialize' do
    it 'sets the name' do
      expect(player.name).to eq(name)
    end

    it 'sets the total_score to 0' do
      expect(player.total_score).to eq(0)
    end

    it 'sets the accumulation_started flag to false' do
      expect(player.accumulation_started).to be_falsey
    end
  end

  describe 'attributes' do
    it 'allows reading and writing the name' do
      player.name = 'Jane'
      expect(player.name).to eq('Jane')
    end

    it 'allows reading and writing the total_score' do
      player.total_score = 100
      expect(player.total_score).to eq(100)
    end

    it 'allows reading and writing the accumulation_started flag' do
      player.accumulation_started = true
      expect(player.accumulation_started).to be_truthy
    end
  end
end
