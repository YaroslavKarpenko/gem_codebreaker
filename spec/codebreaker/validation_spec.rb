module Codebreaker
  RSpec.describe Validation do
    let(:dummy_class) { Class.new { extend Validation } }

    context '#name_validator' do
      it 'should raise LengthError if name is Oz' do
        expect { dummy_class.name_validator('Oz') }.to raise_error LengthError
      end

      it 'should raise LengthError if name is Barack_Hussein_Obama_II' do
        expect { dummy_class.name_validator('Barack_Hussein_Obama_II') }.to raise_error LengthError
      end
    end

    context '#guess_validator' do
      context 'LengthError' do
        it 'should raise LengthError if guess length is five' do
          expect { dummy_class.guess_validator([1, 2, 3, 4, 5]) }.to raise_error InputError
        end

        it 'should raise LengthError if guess length is three' do
          expect { dummy_class.guess_validator([123]) }.to raise_error InputError
        end
      end
    end

    context '#guess_validator' do
      context 'InputError' do
        it 'should raise InputError if guess contain undefined char' do
          expect { dummy_class.guess_validator(%w[c h a r]) }.to raise_error InputError
        end

        it 'should raise InputError if guess contain number bigger then 6' do
          expect { dummy_class.guess_validator([6, 7, 8, 9]) }.to raise_error InputError
        end

        it 'should raise InputError if guess contain zero number' do
          expect { dummy_class.guess_validator([0, 1, 2, 3]) }.to raise_error InputError
        end
      end
    end
  end
end
