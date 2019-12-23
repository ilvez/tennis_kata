# frozen_string_literal: true
class TennisGame
  def initialize(player1_name, player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @p1_points = 0
    @p2_points = 0
  end

  def won_point(player_name)
    if player_name == 'player1'
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
    deuce: -> { 'Deuce' },
    draw: -> { "#{points_to_score(@p1_points)}-All" },
    advantage: -> { "Advantage #{advantage_player}" },
    win: -> { "Win for #{advantage_player}" }
  }.freeze

  def game_state
    if (@p1_points == @p2_points) && @p1_points > 2
      :deuce
    elsif @p1_points == @p2_points && @p1_points <= 2
      :draw
    elsif (@p1_points >= 4 || @p2_points >= 4) && point_difference.abs == 1
      :advantage
    elsif (@p1_points >= 4 || @p2_points >= 4) && point_difference.abs > 1
      :win
    else
      :start
    end
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
