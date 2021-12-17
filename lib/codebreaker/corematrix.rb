require_relative 'autoloader'

module Codebreaker
  module CoreMatrix
    include Validation
    include Constants

    def matrix(inputted_guess)
      matrix, copy_of_the_code, guess = check_position(inputted_guess)
      check_inclusion(matrix, copy_of_the_code, guess)
    end

    private

    def check_position(inputted_guess)
      copy_of_the_code = @secret_code.dup
      matrix = ''
      inputted_guess.each_index do |index|
        next unless copy_of_the_code[index] == inputted_guess[index]

        copy_of_the_code[index] = false
        inputted_guess[index] = nil
        matrix << CORRECT_POSITION_SYMBOL
      end
      [matrix, copy_of_the_code, inputted_guess]
    end

    def check_inclusion(matrix, copy_of_the_code, inputted_guess)
      inputted_guess.each_index do |index|
        copy_of_the_code.each_index do |i|
          next unless inputted_guess[index] == copy_of_the_code[i]

          copy_of_the_code.delete_at(i)
          inputted_guess[index] = nil
          matrix << INCLUSION_SYMBOL
        end
      end
      matrix
    end
  end
end
