require 'active_record'
require 'database_cleaner'
require 'yaml'
require 'shoulda-matchers'
require 'factory_girl'
require 'pry'

require_relative 'matchers'

def setup
  config = YAML.load_file('./config/database.yml')
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || config['test'])

  migrations = ActiveRecord::Migrator.up('./db/migrate')

  FactoryGirl.find_definitions

  DatabaseCleaner.strategy = :transaction

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end
