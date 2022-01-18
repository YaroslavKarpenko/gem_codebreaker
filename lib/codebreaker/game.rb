# frozen_string_literal: true

require_relative 'autoloader'

module Codebreaker
  class Game
    include Constants
    include Validation
    include CoreMatrix
    include FileStore

    attr_reader :secret_code, :attempts, :hints, :name
    attr_accessor :difficulty, :user

    def initialize(user: User.new, difficulty: DIFFICULTIES)
      @secret_code = SECRET_CODE_RANGE.sample(SECRET_CODE_LENGTH)
      @user = user
      @difficulty = difficulty
      @available_hints = @secret_code.dup
    end

    def use_hint
      return nil if @available_hints.empty?

      hint = @available_hints.sample
      @available_hints.delete_at(@available_hints.find_index(hint))
      user.hints -= 1
      hint
    end

    def assign_difficulty
      user.attempts = DIFFICULTIES[@difficulty][:attempts]
      user.hints = DIFFICULTIES[@difficulty][:hints]
    end

    def check_for_hints?
      (user.hints <= DIFFICULTIES[@difficulty][:hints]) && !user.hints.zero?
    end

    def check_for_attempts?
      (user.attempts < DIFFICULTIES[@difficulty][:attempts]) && !user.attempts.zero?
    end

    def available_difficulties
      DIFFICULTIES
    end

    def win?(result)
      return unless result == @secret_code

      true
    end

    def lose?
      return unless user.attempts.zero?

      true
    end

    def display_matrix(inputted_guess)
      guess_validator(inputted_guess)
      user.attempts -= 1
      matrix(inputted_guess)
    end

    def save_game(game)
      save_file(game)
    end
  end
end
