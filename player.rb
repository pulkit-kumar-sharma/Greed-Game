class Player

  attr_accessor :name
  attr_accessor :total_score
  attr_accessor :accumulation_started

  def initialize(name)
      @name = name
      @total_score = 0
      @accumulation_started = false
  end
end
