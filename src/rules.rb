require_relative 'constants'

# Module conatains all the rules of game defined
module Rules
  include Constants

  def bingo_points
    BINGO_POINTS
  end

  def penalty_points
    PENALTY_POINTS
  end

  def consecutive_penality_point
    PENALTY_CONSECUTIVE_TIME
  end

  def another_chance?(curr_round_points)
    two_consecutive_ones(curr_round_points) || bingo_chance?(curr_round_points.last)
  end

  def bingo_chance?(curr_point)
    bingo_points.include?(curr_point)
  end

  def two_consecutive_ones(curr_round_points)
    is_penality = false
    last_scores = curr_round_points.last(consecutive_penality_point)
    penalty_points.each do |penalty_point|
      is_penality = last_scores.size.eql?(consecutive_penality_point) && last_scores.all? { |point| point == penalty_point }
      break if is_penality
    end
    is_penality
  end

  def penalty?(current_point)
    penalty_points.include?(current_point)
  end

  def crossing_score?(player_score, current_point, winning_points)
    (player_score + current_point) > winning_points
  end
end
