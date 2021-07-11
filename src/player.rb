# Player class which is having attributes like -
# name to display on points table
# id to maintain the uniqueness of player
# score of individual player
# valid chance to check his next chance like for 2 consecutive ones his next chance will not be valid
class Player
  attr_accessor :id, :name, :play_order, :score, :valid_chance

  def initialize(id, play_order, name = nil)
    @id = id
    @name = name || "Player-#{id}"
    @play_order = play_order
    @score = 0
    @valid_chance = true
  end

  def valid_chance?
    should_play = @valid_chance
    if @valid_chance.eql?(false)
      @valid_chance = true
    end
    should_play
  end

  def add_points(points)
    @score += points
  end

  def set_next_chance(value)
    @valid_chance = value
  end
end
