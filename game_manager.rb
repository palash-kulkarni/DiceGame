require_relative './src/dice_game'
# Singleton Class to manage all the games initiated or going to start
class GameManager
  attr_accessor :games

  @instance = new

  private_class_method :new

  def self.instance
    @instance
  end

  def setup!
    @games ||= {}
  end

  def create_new_game
    game = DiceGame.new
    @games[game.object_id] = game
    game.start
    destroy(game.object_id)
  end

  def destroy(game_id)
    puts "Game is finished!"
    @games.delete(game_id)
  end
end

puts 'Initializing Game Manager ...'
manager = GameManager.instance
manager.setup!
puts 'Starting a new game'
manager.create_new_game
