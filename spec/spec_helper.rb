# frozen_string_literal: true

require 'bundler/setup'
require 'simplecov'
require 'codecov'
require 'pry'

SimpleCov.start do
  enable_coverage :branch
end

SimpleCov.formatter = SimpleCov::Formatter::Codecov if ENV['COVERAGE']

require 'numbered_list/numbered_list'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
