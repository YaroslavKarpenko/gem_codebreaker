module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    let(:difficulty) { :easy }

    before do
      game.difficulty = difficulty
      game.assign_difficulty
      game.start
    end
    it 'checks attempts amount' do
      expect(game.user.attempts).to eq 15
    end

    it 'checks dicreasing of attempts' do
      game.generate_matrix([1, 1, 1, 1])
      expect(game.user.attempts).to eq 14
    end

    it 'checks hints amount' do
      expect(game.user.hints).to eq 2
    end

    it 'checks dicreasing of hints' do
      game.use_hint
      expect(game.user.hints).to eq 1
    end
  end
end
