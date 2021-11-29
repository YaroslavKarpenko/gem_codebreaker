module Validate
  include Errors

  def name_validator(name)
    raise LengthError unless (3..20).cover?(name.length)
  end

  def guess_validator(guess)
    raise InputError unless guess.match(/^[1-6]{4}$/)
  end
end
