# frozen_string_literal: true
require_relative 'validation/validation'
require_relative 'autoloader'
module Codebreaker
  class User
    include Constants
    include Validation
    attr_accessor :attempts, :hints, :name

    def initialize(name: :name, attempts: GAME_ATTEMPTS, hints: GAME_HINTS)
      name_validator(name)
      @name = name
      @attempts = attempts
      @hints = hints
    end
  end
end
