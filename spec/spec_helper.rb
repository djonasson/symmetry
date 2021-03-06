require 'rubygems'

require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

def load_coverage
  # SimpleCov & Coveralls
  unless ENV['DRB']
    require 'simplecov'
    require 'coveralls'
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ])
    SimpleCov.start 'rails'
    Coveralls.wear!('rails')
  end
end

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  load_coverage

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'
  #require 'rspec/autorun'

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      # Choose a test framework:
      with.test_framework :rspec
      with.library :rails
    end
  end

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Symmetry::Engine.root.join("spec/support/**/*.rb")].each { |f| require f }

  def in_memory_database?
    Rails.env.test? and Rails.configuration.database_configuration['test']['database'] == ':memory:'
  end

  if in_memory_database?
    puts "creating sqlite in memory database"
    load "#{Rails.root}/db/schema.rb"
  end

  require File.expand_path('../data/schema', __FILE__)
  require File.expand_path('../data/models', __FILE__)

  ActiveRecord::Migration.maintain_test_schema!

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Symmetry::Engine.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    #config.raise_errors_for_deprecations!
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

  load_coverage
end
