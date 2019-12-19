require 'rspec'
require_relative 'tennis'

TEST_CASES = [
   [0, 0, 'Love-All', 'player1', 'player2'],
   [1, 1, 'Fifteen-All', 'player1', 'player2'],
   [2, 2, 'Thirty-All', 'player1', 'player2'],
   [3, 3, 'Deuce', 'player1', 'player2'],
   [4, 4, 'Deuce', 'player1', 'player2'],

   [1, 0, 'Fifteen-Love', 'player1', 'player2'],
   [0, 1, 'Love-Fifteen', 'player1', 'player2'],
   [2, 0, 'Thirty-Love', 'player1', 'player2'],
   [0, 2, 'Love-Thirty', 'player1', 'player2'],
   [3, 0, 'Forty-Love', 'player1', 'player2'],
   [0, 3, 'Love-Forty', 'player1', 'player2'],
   [4, 0, 'Win for player1', 'player1', 'player2'],
   [0, 4, 'Win for player2', 'player1', 'player2'],

   [2, 1, 'Thirty-Fifteen', 'player1', 'player2'],
   [1, 2, 'Fifteen-Thirty', 'player1', 'player2'],
   [3, 1, 'Forty-Fifteen', 'player1', 'player2'],
   [1, 3, 'Fifteen-Forty', 'player1', 'player2'],
   [4, 1, 'Win for player1', 'player1', 'player2'],
   [1, 4, 'Win for player2', 'player1', 'player2'],

   [3, 2, 'Forty-Thirty', 'player1', 'player2'],
   [2, 3, 'Thirty-Forty', 'player1', 'player2'],
   [4, 2, 'Win for player1', 'player1', 'player2'],
   [2, 4, 'Win for player2', 'player1', 'player2'],

   [4, 3, 'Advantage player1', 'player1', 'player2'],
   [3, 4, 'Advantage player2', 'player1', 'player2'],
   [5, 4, 'Advantage player1', 'player1', 'player2'],
   [4, 5, 'Advantage player2', 'player1', 'player2'],
   [15, 14, 'Advantage player1', 'player1', 'player2'],
   [14, 15, 'Advantage player2', 'player1', 'player2'],

   [6, 4, 'Win for player1', 'player1', 'player2'],
   [4, 6, 'Win for player2', 'player1', 'player2'],
   [16, 14, 'Win for player1', 'player1', 'player2'],
   [14, 16, 'Win for player2', 'player1', 'player2'],

   [6, 4, 'Win for player1', 'player1', 'player2'],
   [4, 6, 'Win for player2', 'player1', 'player2'],
   [6, 5, 'Advantage player1', 'player1', 'player2'],
   [5, 6, 'Advantage player2', 'player1', 'player2']
]

RSpec.describe TennisGame do
  let(:game) { described_class.new(player1, player2) }

  shared_examples 'game' do |p1_points, p2_points, score, p1_name, p2_name|
    let(:player1) { p1_name }
    let(:player2) { p2_name }

    before do
      (0..[p1_points, p2_points].max).each do |i|
        game.won_point(player1) if i < p1_points
        game.won_point(player2) if i < p2_points
      end
    end

    it { expect(game.score).to eq score }
  end

  TEST_CASES.each do |test_case|
    it_behaves_like 'game', *test_case
  end
end
