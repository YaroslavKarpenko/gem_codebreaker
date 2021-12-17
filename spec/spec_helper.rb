# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
  add_filter 'spec'
  add_filter 'vendor'
end

require 'ffaker'
require_relative 'spec_loader'
