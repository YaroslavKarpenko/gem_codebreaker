module Codebreaker
  RSpec.describe FileStore do
    let(:test_class) { Class.new { include FileStore }.new }
    let(:user) { User.new(name: 'player1', hints: 2, attempts: 15) }
    let(:game) { Game.new(user: user, difficulty: :easy) }

    describe '#load_file' do
      before do
        stub_const('Codebreaker::FileStore::FILE_NAME', 'test1.yml')
        stub_const('Codebreaker::FileStore::FILE_DIRECTORY', 'spec/fixtures')
      end

      it 'returns false when file is empty' do
        expect(test_class.create_storage).to be_falsy
      end
    end

    describe '#save_file' do
      let(:expected_values) do
        [
          { available_attempts: 15, available_hints: 2, difficulty: :easy, name: 'player1', used_attempts: 0,
            used_hints: 0 }
        ]
      end

      before do
        stub_const('Codebreaker::FileStore::FILE_NAME', 'test_3.yml')
        stub_const('Codebreaker::FileStore::FILE_DIRECTORY', 'spec/fixtures')
      end

      after do
        if File.exist?("#{FileStore::FILE_DIRECTORY}/#{FileStore::FILE_NAME}")
          File.delete("#{FileStore::FILE_DIRECTORY}/#{FileStore::FILE_NAME}")
        end
      end

      it 'creates file, puts data inside and deletes file' do
        test_class.save_file(game)
        expect(test_class.load_file).to eq(expected_values)
      end
    end
  end
end
