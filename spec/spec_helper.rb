RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
  config.order = :random
  Kernel.srand config.seed
end

def active_record_version
  Gem::Version.new(ActiveRecord::VERSION::STRING)
end

require "sinatra/main"
require "yaml"
require "active_record"
if active_record_version < Gem::Version.new("5.0.0")
  ActiveRecord::Base.raise_in_transactional_callbacks = true
end
require "rack/test"
require "paper_trail/config"
require "paper_trail"
require "paper_trail/sinatra"
require_relative "models/widget"
