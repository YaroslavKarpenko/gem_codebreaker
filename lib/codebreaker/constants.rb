# frozen_string_literal: true

module Codebreaker
  module Constants
    SECRET_CODE_RANGE = (1..6).to_a.freeze
    SECRET_CODE_LENGTH = 4
    INCLUSION_SYMBOL = '-'
    CORRECT_POSITION_SYMBOL = '+'

    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    START_POINT = :start
    GAME_IN_PROGRESS = :game
    LOSE = :lose
    WIN = :win

    GAME_ATTEMPTS = 0
    GAME_HINTS = 0
  end
end
