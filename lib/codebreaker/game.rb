# frozen_string_literal: true

require_relative 'autoloader'

module Codebreaker
  class Game
    include Constants
    include Validation
    include CoreMatrix
    include FileStore

    attr_reader :secret_code, :user, :attempts, :hints, :name
    attr_accessor :difficulty, :phase

    def initialize(secret_code: '', user: User.new, difficulty: DIFFICULTIES, phase: START_POINT)
      @secret_code = secret_code
      @user = user
      @difficulty = difficulty
      @phase = phase
    end

    def start
      raise PhaseError unless @phase == START_POINT

      @secret_code = SECRET_CODE_RANGE.sample(SECRET_CODE_LENGTH)
      @available_hints = @secret_code.dup
      @phase = GAME_IN_PROGRESS
      assign_difficulty
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
      (user.hints <= DIFFICULTIES[@difficulty][:hints]) && user.hints.positive?
    end

    def check_for_attempts?
      (user.attempts < DIFFICULTIES[@difficulty][:attempts]) && user.attempts.positive?
    end

    def available_difficulties
      DIFFICULTIES
    end

    def win?(result)
      return unless result == @secret_code

      @phase = WIN
      true
    end

    def lose?
      return unless user.attempts.zero?
      raise PhaseError unless user.attempts.zero?

      @phase = LOSE
      true
    end

    def generate_matrix(inputted_guess)
      guess_validator(inputted_guess)
      user.attempts -= 1
      matrix(inputted_guess)
    end

    def save_game(game)
      save_file(game)
    end
  end
end
