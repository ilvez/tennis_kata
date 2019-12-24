# frozen_string_literal: true
class TennisGame
  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @p1_points = 0
    @p2_points = 0
  end

  def won_point(player_name)
    if player_name == @player1_name
      @p1_points += 1
    else
      @p2_points += 1
    end
  end

  def score
    instance_exec(&SCORE_CALCULATIONS[game_state])
  end

  private

  SCORE_CALCULATIONS = {
    start: -> { "#{points_to_score(@p1_points)}-#{points_to_score(@p2_points)}" },
    draw: -> { "#{points_to_score(@p1_points)}-All" },
    deuce: -> { 'Deuce' },
    advantage: -> { "Advantage #{advantage_player}" },
    win: -> { "Win for #{advantage_player}" }
  }.freeze

  def game_state
    if points_equal? && few_points?
      :draw
    elsif points_equal? && !few_points?
      :deuce
    elsif match_close_end? && point_difference.abs == 1
      :advantage
    elsif match_close_end? && point_difference.abs > 1
      :win
    else
      :start
    end
  end

  def points_equal?
    @p1_points == @p2_points
  end

  def few_points?
    @p1_points <= 2
  end

  def match_close_end?
    @p1_points >= 4 || @p2_points >= 4
  end

  def advantage_player
    if point_difference.positive?
      @player1_name
    else
      @player2_name
    end
  end

  def points_to_score(points)
    {
      0 => 'Love',
      1 => 'Fifteen',
      2 => 'Thirty',
      3 => 'Forty'
    }[points]
  end

  def point_difference
    @p1_points - @p2_points
  end
end
