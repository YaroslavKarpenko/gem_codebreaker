module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    let(:difficulty) { :easy }

    before(:each) do
      game.difficulty = difficulty
    end

    describe '#assign_difficulty' do
      it 'easy difficulty is when @difficulty equals 0' do
        game.difficulty = :easy
        expect(game.difficulty).to eq :easy
      end

      it 'medium difficulty is when @difficulty equals 1' do
        game.difficulty = :medium
        expect(game.difficulty).to eq :medium
      end

      it 'hell difficulty is when @difficulty equals 2' do
        game.difficulty = :hell
        expect(game.difficulty).to eq :hell
      end
    end
  end
end
