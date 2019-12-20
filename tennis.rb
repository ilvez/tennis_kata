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
    if @p1_points == @p2_points
      resolve_draw
    elsif @p1_points >= 4 || @p2_points >= 4
      resolve_advantage_or_win
    else
      "#{points_to_score(@p1_points)}-#{points_to_score(@p2_points)}"
    end
  end

  private

  def resolve_draw
    {
      0 => 'Love-All',
      1 => 'Fifteen-All',
      2 => 'Thirty-All'
    }.fetch(@p1_points, 'Deuce')
  end

  def points_to_score(points)
    {
      0 => 'Love',
      1 => 'Fifteen',
      2 => 'Thirty',
      3 => 'Forty'
    }[points]
  end

  def resolve_advantage_or_win
    if point_difference.abs == 1
      "Advantage #{advantage_player}"
    else
      "Win for #{advantage_player}"
    end
  end

  def advantage_player
    if point_difference.positive?
      @player1_name
    else
      @player2_name
    end
  end

  def point_difference
    @p1_points - @p2_points
  end
end
