# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Rails.logger = Le.new('a5ca113f-348e-48ba-921d-c724075584a2', :debug => true, :local => true)
