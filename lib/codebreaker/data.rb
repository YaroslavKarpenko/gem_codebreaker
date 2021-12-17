# frozen_string_literal: true

require_relative 'autoloader'
module Codebreaker
  module Data
    include Constants

    def fetch_game_data(game)
      results = {}
      results[:name] = game.user.name
      results[:difficulty] = game.difficulty
      results[:available_attempts] = DIFFICULTIES[game.difficulty][:attempts]
      results[:available_hints] = DIFFICULTIES[game.difficulty][:hints]
      results.merge(fetch_user_data(game))
    end

    def fetch_user_data(game)
      user_data = {}
      user_data[:used_attempts] = used_attempts(game)
      user_data[:used_hints] = used_hints(game)
      user_data
    end

    private

    def used_attempts(game)
      DIFFICULTIES[game.difficulty][:attempts] - game.user.attempts
    end

    def used_hints(game)
      DIFFICULTIES[game.difficulty][:hints] - game.user.hints
    end
  end
end
