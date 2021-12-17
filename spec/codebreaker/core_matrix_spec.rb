module Codebreaker
  RSpec.describe Game do
    subject(:core_matrix) { Game.new }

    data = YAML.load_file('./spec/fixtures/sample.yml')
    data.each do |secret_code, guess, expected|
      it "should return #{expected} when the secret key is #{secret_code} and the guess is #{guess}" do
        core_matrix.instance_variable_set(:@secret_code, secret_code)
        expect(core_matrix.generate_matrix(guess)).to eq expected
      end
    end
  end
end
