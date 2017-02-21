source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.2.4'


gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'figaro'

gem 'therubyracer'
gem 'execjs'


gem 'pusher'

# Default web server
gem 'puma', '~> 3.0'

# Enable cors
gem 'rack-cors'

# Front
gem 'sprockets-rails'
gem 'sprockets', '>= 3.0.0'

gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'font-awesome-rails'
gem 'simple_form'
gem 'maskedinput-rails'

# Secure
gem 'bcrypt', '~> 3.1.7'

# Authentication
gem 'devise'
gem 'devise-bootstrap-views'

gem 'koala', '~> 2.2'
gem 'ledermann-rails-settings'

# JSON
gem 'active_model_serializers', '~> 0.10.0'
gem 'faker'

# Pagination
gem 'kaminari'
gem 'bootstrap-kaminari-views'

# Image / videos
gem 'paperclip', '~> 5.0.0'
gem 'paperclip-av-transcoder'

# Static
gem 'aws-sdk', '>= 2.0.0'

# CEP
gem 'via_cep'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
