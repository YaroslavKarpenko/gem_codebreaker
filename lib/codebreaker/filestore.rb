# frozen_string_literal: true

require_relative 'autoloader'

module Codebreaker
  module FileStore
    include Data
    include Constants
    FILE_DIRECTORY = './storage'
    FILE_NAME = 'players.yml'

    def save_file(game)
      raise PhaseError unless game.phase == WIN

      rating = load_file
      rating << fetch_game_data(game)
      store = YAML::Store.new(storage_path)
      store.transaction { store[:players] = rating }
      store
    end

    def load_file
      create_storage unless storage_exists?
      (YAML.load_file(storage_path) || {})[:players] || []
    end

    def create_storage
      Dir.mkdir(FILE_DIRECTORY) unless Dir.exist?(FILE_DIRECTORY)
      File.open(storage_path, 'w+') unless File.exist?(storage_path)
      YAML.load_file(storage_path)
    end

    private

    def storage_path
      File.join(FILE_DIRECTORY, FILE_NAME)
    end

    def storage_exists?
      Dir.exist?(FILE_DIRECTORY) && File.exist?(storage_path)
    end
  end
end
