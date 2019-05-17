require 'bundler/setup'
require 'bicycle'

RSpec.configure do |config|
  config.filter_run_when_matching(:focus)
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  config.order = :random
  Kernel.srand(config.seed)
end
