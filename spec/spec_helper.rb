require 'bundler/setup'
require 'kaminari'
require 'database_cleaner'
require 'simplecov'
require 'easy_management/testing/support/database_connection'

SimpleCov.start do
  add_filter { |src| src.filename =~ /spec/ }
end

require 'easy_management'

Dir[File.expand_path('../lib/**/*.rb', __dir__)].each { |file| require file }

EasyManagement::Testing::Support::DatabaseConnection.establish_sqlite_connection File.expand_path('test.sqlite3')

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  config.after(:suite) do
    ModelBuilder.clean
  end
end