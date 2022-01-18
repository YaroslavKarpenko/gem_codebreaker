module Codebreaker
  RSpec.describe Statistics do
    describe '#show_staristics' do
      let(:test_module) { Class.new { include FileStore }.new }
      let(:expected_values) do
        [
          { name: 'name3', difficulty: :hell, available_attempts: 5, used_attempts: 4, available_hints: 1,
            used_hints: 1 },
          { name: 'name2', difficulty: :medium, available_attempts: 10, used_attempts: 3, available_hints: 1,
            used_hints: 0 },
          { name: 'name1', difficulty: :easy, available_attempts: 15, used_attempts: 4, available_hints: 2,
            used_hints: 1 }
        ]
      end

      before do
        stub_const('Codebreaker::FileStore::FILE_NAME', 'test.yml')
        stub_const('Codebreaker::FileStore::FILE_DIRECTORY', 'spec/fixtures')
      end

      it 'returns stats' do
        expect(Statistics.new.show_statistics).to eq expected_values
      end

      it 'returns array' do
        expect(Statistics.new.show_statistics.class).to eq(Array)
      end
    end
  end
end
