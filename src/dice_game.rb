require_relative 'constants'
require_relative 'player'
require_relative 'dice'
require_relative 'rules'

# Main DiceGame class which have composition of -
# 1. Dice object
# 2. Players objects
# And injecting Rules for the game
# Having winners queue, whoever wins get queue up in winners list
class DiceGame

  include Constants
  include Rules

  attr_accessor :players, :dice, :no_of_players, :winning_points, :winners_queue

  def initialize(players = [])
    @players = []
    @winners_queue = []
    @dice = Dice.new
    @no_of_players = nil
    @winning_points = nil
  end

  def start
    enter_players
    enter_points
    prepare_game
    play
  end

  def enter_players
    puts 'Enter the total number of players to play this game'
    @no_of_players = gets.chomp.to_i
    validate_players
  end

  def enter_points
    puts 'Enter winning points to play this game'
    @winning_points = gets.chomp.to_i
    validate_points
  end

  def prepare_game
    player_order
  end

  def player_order
    player_order = (1..@no_of_players).to_a.shuffle
    player_order.each_with_index do |player_id, play_order|
      @players.push(Player.new(player_id, play_order))
    end
  end

  def game_on?
    !@players.empty?
  end

  def play
    while(game_on?)
      @players.each_with_index do |player, index|
        play_again = true
        curr_round_points = []
        puts "#{player.name} its your turn (press 'r' to roll dice)"
        roll_input = gets.chomp.strip
        while(roll_input == 'r' && play_again && player.valid_chance)
          curr_points = @dice.rolls
          puts "#{player.name} have got #{curr_points} points"
          unless crossing_score?(player.score, curr_points, @winning_points)
            player.add_points(curr_points)
            curr_round_points.push(curr_points)
            set_valid_next_chance(player, curr_round_points)
            play_again = another_chance?(curr_round_points)
          else
            play_again = bingo_chance?(curr_points) ? true : false
          end
          display_point_table
          if play_again && !winner?(player, index)
            puts "#{player.name} its your turn (press 'r' to roll dice)"
            roll_input = gets.chomp.strip
          end
        end
        prompt_penalty?(player)
        winner?(player, index)
      end
    end
  end

  def prompt_penalty?(player)
    puts "You are penalised because you have rolled '1' twice consecutively" unless player.valid_chance?
  end

  def set_valid_next_chance(player, curr_round_points)
    next_chance = !two_consecutive_ones(curr_round_points)
    player.set_next_chance next_chance
  end

  def winner?(player, index)
    if player.score.eql?(@winning_points)
      @players.delete_at(index)
      @winners_queue.push(player)
      return true
    end
    false
  end

  def display_point_table
    players = @players.sort { |p1, p2| p2.score <=> p1.score }
    players = @winners_queue + players
    puts "Player Name \t\t\t Score \t\t\t Rank"
    players.each_with_index do |player, index|
      puts "#{player.name} \t\t\t #{player.score} \t\t\t #{index + 1}"
    end
  end

  private

    def validate_players
      begin
        if INVALID_NO_OF_PLAYERS.include?(@no_of_players)
          raise 'Invalid number of players! Please insert natural number greater than 1'
        end
      rescue => e
        puts e
        enter_players
      end
    end

    def validate_points
      begin
        if @winning_points.eql?(INVALID_WINNING_POINTS)
          raise 'Invalid winning points! Please insert natural number'
        end
      rescue => e
        puts e
        enter_points
      end
    end
end