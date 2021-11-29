require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    before do
      game.start
    end

    context '#start' do
      it 'saves secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).size).to eq Game::SECRET_CODE_LENGTH
      end

      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end
    end

    context '#generate_matrix' do
      it 'should inscrements attempts by one' do
        expect { game.generate_matrix('1111') }.to change { game.attempts }.by(1)
      end

      [['6543', '5643', '++--'],
       ['6543', '6411', '+-'],
       ['6543', '6544', '+++'],
       ['6543', '3456', '----'],
       ['6543', '6666', '+'],
       ['6543', '2666', '-'],
       ['6543', '2222', ''],
       ['6666', '1661', '++'],
       ['1234', '3124', '+---'],
       ['1234', '1524', '++-'],
       ['1234', '1234', '++++']].each do |secret_code, guess, expected|
        it "should return #{expected} when the secret key is #{secret_code} and the guess is #{guess}" do
          game.instance_variable_set(:@secret_code, secret_code)
          expect(game.generate_matrix(guess)).to eq expected
        end
      end
    end

    context '#set_hint' do
      it 'secret code include hint' do
        expect(game.instance_variable_get(:@secret_code)).to include game.use_hint
      end

      it 'should return empty if used hint' do
        game.instance_variable_set(:@available_hints, '1')
        game.use_hint

        expect(game.use_hint).to eq ' '
      end
    end

    context '#assign_difficulty' do
      it 'if difficulty easy @difficulty is 0' do
        game.difficulty = :easy
        expect(game.difficulty).to eq 0
      end

      it 'if difficulty medium @difficulty is 1' do
        game.difficulty = :medium
        expect(game.difficulty).to eq 1
      end

      it 'if difficulty hell @difficulty is 2' do\
        game.difficulty = :hell
        expect(game.difficulty).to eq 2
      end
    end

    context '#assign_name' do
      it 'should assign name' do
        name = FFaker::Name.name
        game.name = name
        expect(game.name).to eq name
      end
    end

    context '#available_difficulties' do
      it 'return hash' do
        expect(game.available_difficulties.class).to eq(Hash)
      end

      it 'return constant from class' do
        expect(game.available_difficulties).to eq Game::DIFFICULTIES
      end
    end
  end

  RSpec.shared_examples 'callable attempts and hints' do
    before { stub_const('Codebreaker::Game::DIFFICULTIES', { difficulty => { attempts: 1, hints: 1 } }) }

    let(:game) { Game.new }

    before(:each) do
      game.start
      game.difficulty = difficulty
    end

    context '#present_attempts' do
      it 'should return true if attempt was not use' do
        expect(game.present_attempts?).to be_truthy
      end

      it 'should return false if attempt was use' do
        game.generate_matrix('1111')
        expect(game.present_attempts?).to be_falsey
      end
    end

    context '#present_hints' do
      it 'should return true if hint was not use' do
        expect(game.present_hints?).to be_truthy
      end

      it 'should return false if hint was use' do
        game.use_hint
        expect(game.present_hints?).to be_falsey
      end
    end

    context '#available_attempts' do
      it 'should return one if attempt was not use' do
        expect(game.available_attempts).eql? 1
      end
    end
    context '#available_hints' do
      it 'should return one if hint was not use' do
        expect(game.available_hints).eql? 1
      end
    end
  end

  RSpec.describe Game do
    context 'easy' do
      it_behaves_like 'callable attempts and hints' do
        let(:difficulty) { :easy }
      end
    end

    context 'medium' do
      it_behaves_like 'callable attempts and hints' do
        let(:difficulty) { :medium }
      end
    end

    context 'hell' do
      it_behaves_like 'callable attempts and hints' do
        let(:difficulty) { :hell }
      end
    end
  end
end
