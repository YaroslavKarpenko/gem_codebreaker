require_relative 'validation/errors'
require_relative 'validation/validate'

module Codebreaker
  class Game
    include Validate

    attr_reader :secret_code, :difficulty, :attempts, :hints, :name

    SECRET_CODE_RANGE = (1..6).to_a.freeze
    SECRET_CODE_LENGTH = 4
    INCLUSION_SYMBOL = '-'.freeze
    CORRECT_POSITION_SYMBOL = '+'.freeze

    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    def initialize
      @secret_code = ''
      @difficulty = 0
      @attempts = 0
      @hints = 0
      @name = ''
    end

    def start
      @secret_code = SECRET_CODE_RANGE.sample(SECRET_CODE_LENGTH).join
      @available_hints = @secret_code.dup
    end

    def generate_matrix(inputted_guess)
      guess_validator(inputted_guess)
      @attempts += 1
      matrix(inputted_guess)
    end

    def use_hint
      return ' ' if @available_hints.empty?

      hint = @available_hints.chars.sample
      @available_hints.sub!(hint, '')
      @hints += 1
      hint
    end

    def difficulty=(difficulty)
      @difficulty = DIFFICULTIES.keys.index(difficulty)
    end

    def name=(name)
      name_validator(name)
      @name = name
    end

    def present_hints?
      @hints < DIFFICULTIES.values[difficulty][:hints]
    end

    def present_attempts?
      @attempts < DIFFICULTIES.values[difficulty][:attempts]
    end

    def available_difficulties
      DIFFICULTIES
    end

    def available_attempts
      DIFFICULTIES.values[difficulty][:attempts] - @attempts
    end

    def available_hints
      DIFFICULTIES.values[difficulty][:hints] - @hints
    end

    private

    def matrix(inputted_guess)
      inputted_guess, matrix, unnecessary_char = check_position_in_matrix(inputted_guess)
      _, matrix, = check_for_inclusion_in_matrix(inputted_guess, matrix, unnecessary_char)
      matrix
    end

    def check_position_in_matrix(inputted_guess)
      matrix = ''
      unnecessary_char = ''
      (0...SECRET_CODE_LENGTH).select { |index| inputted_guess[index] == @secret_code[index] }.reverse_each do |index|
        matrix += CORRECT_POSITION_SYMBOL
        unnecessary_char += inputted_guess.slice!(index)
      end
      [inputted_guess, matrix, unnecessary_char]
    end

    def check_for_inclusion_in_matrix(inputted_guess, matrix = '', unnecessary_char = '')
      inputted_guess.each_char do |char|
        if @secret_code.include?(char) && !unnecessary_char.include?(char)
          matrix += INCLUSION_SYMBOL
          unnecessary_char += char
        end
      end
      [inputted_guess, matrix, unnecessary_char]
    end
  end

  class Error < StandardError; end
end
