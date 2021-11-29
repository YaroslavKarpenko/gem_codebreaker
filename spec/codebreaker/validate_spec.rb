RSpec.describe Validate do
  let(:dummy_class) { Class.new { extend Validate } }

  context '#name_validator' do
    it 'should raise LengthError if name is Oz' do
      expect { dummy_class.name_validator('Oz') }.to raise_error Errors::LengthError
    end

    it 'should raise LengthError if name is Barack_Hussein_Obama_II' do
      expect { dummy_class.name_validator('Barack_Hussein_Obama_II') }.to raise_error Errors::LengthError
    end
  end
  
  context '#guess_validator' do
    context 'LengthError' do
      it 'should raise LengthError if guess length is five' do
        expect { dummy_class.guess_validator('12345') }.to raise_error Errors::InputError
      end

      it 'should raise LengthError if guess length is three' do
        expect { dummy_class.guess_validator('123') }.to raise_error Errors::InputError
      end
    end
  end

  context '#guess_validator' do
    context 'InputError' do
      it 'should raise InputError if guess contain undefined char' do
        expect { dummy_class.guess_validator('chr1') }.to raise_error Errors::InputError
      end

      it 'should raise InputError if guess contain number bigger then 6' do
        expect { dummy_class.guess_validator('6789') }.to raise_error Errors::InputError
      end

      it 'should raise InputError if guess contain zero number' do
        expect { dummy_class.guess_validator('0123') }.to raise_error Errors::InputError
      end
    end
  end
end
