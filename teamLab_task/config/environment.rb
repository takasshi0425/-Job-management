# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Add additional load paths for your own custom dirs
config.load_paths += %W( #{RAILS_ROOT}/app/batches )
