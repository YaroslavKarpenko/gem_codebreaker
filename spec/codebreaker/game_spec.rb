require_relative '../spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    let(:difficulty) { :easy }
    before(:each) do
      game.difficulty = difficulty
      game.instance_variable_set(:@secret_code, [3, 1, 4, 2])
    end

    context '#start' do
      it 'saves secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).size).to eq Game::SECRET_CODE_LENGTH
      end

      it 'code is number with 1 to 6 digits' do
        expect(game.instance_variable_get(:@secret_code).join).to match(/[1-6]+/)
      end
    end

    context 'end of game' do
      it 'returns true if the guess is right' do
        expect(game.win?([3, 1, 4, 2])).to be_truthy
      end

      it 'should return false if the guess us wrong' do
        expect(game.win?([1, 2, 3, 4])).to be_falsy
      end

      it 'should return false if player has not lost' do
        game.user.attempts = 1
        expect(game.lose?).to be_falsy
      end

      it 'should return true if player has lost' do
        game.user.attempts = 0
        expect(game.lose?).to be_truthy
      end
    end
    describe '#matrix' do
      it 'should decrease attempts by 1' do
        expect { game.display_matrix([1, 1, 1, 1]) }.to change(game.user, :attempts).by(-1)
      end
    end
  end
end
