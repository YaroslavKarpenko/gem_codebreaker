# frozen_string_literal: true

require_relative 'errors'
module Codebreaker
  module Validation
    def name_validator(name)
      raise LengthError unless (3..20).cover?(name.length)
    end

    def guess_validator(guess)
      raise InputError unless guess.join.match(/^[1-6]{4}$/)
    end
  end
end
