module Codebreaker
  RSpec.describe Game do
    let(:game) { described_class.new }
    let(:difficulty) { :easy }

    before(:each) do
      game.difficulty = difficulty
    end

    describe '#available_difficulties' do
      it 'returns hash' do
        expect(game.available_difficulties.class).to eq(Hash)
      end

      it 'returns available difficulties' do
        expect(game.available_difficulties).to eq(Game::DIFFICULTIES)
      end
    end
  end
end
