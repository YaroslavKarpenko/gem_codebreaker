module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    let(:difficulty) { :easy }

    before(:each) do
      game.difficulty = difficulty
      game.start
    end

    describe '#assign_name' do
      it 'sets name' do
        name = FFaker::Name.name
        game.user.name = name
        expect(game.user.name).to eq name
      end
    end
  end
end
