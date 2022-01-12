# frozen_string_literal: true

require_relative 'autoloader'

module Codebreaker
  class Statistics
    include FileStore
    def show_statistics
      load_file.each.sort_by { |game| [game[:available_attempts], game[:used_hints], game[:used_attempts]] }
    end
  end
end
