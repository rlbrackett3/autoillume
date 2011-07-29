source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'

# Asset template engines
group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-script'
  gem 'uglifier'
end

gem 'haml'
gem 'jquery-rails'

# admin / user authentication
# gem "bcrypt-ruby", :require => "bcrypt" #required by rails

# Deploy with Heroku
gem 'heroku'

# friendly urls (slugging)
# gem 'friendly_id'

# storing images in amazon s3 with carrierwave
gem 'carrierwave', git: 'git://github.com/jnicklas/carrierwave.git'
gem 'fog'
gem 'mini_magick'

# pagination
# gem 'kaminari'

# client side validations
gem 'client_side_validations'

# ordering and sorting with ranked-model
gem 'ranked-model'

# nested forms gem from ryan bates https://github.com/ryanb/nested_form.git
gem 'nested_form', git: 'git://github.com/ryanb/nested_form.git'

# integrate remote multipart file uploads with remotipart
gem 'remotipart', '~> 0.4'

# text formatting with textile
gem 'RedCloth'

# Use unicorn as the web server
gem 'unicorn'
gem 'foreman'

# Deploy with Capistrano
gem 'capistrano'

# State Machine for handling post states
gem 'state_machine'
gem 'ruby-graphviz', :require => 'graphviz'

# Special validations
# datetime validations
#gem 'validates_timeliness', '~> 3.0.5' #https://github.com/adzap/validates_timeliness.git

group :development, :production do
  gem 'pg'
end

# development only gems
group :development do
  gem 'heroku-rails'
  # JS runtime environment
  gem 'therubyracer'
  # production env simulation
  gem 'foreman'
  # more descriptive models
  gem 'annotate'
  # gem 'annotate', :git => 'git://github.com/jeremyolliver/annotate_models.git', :branch => 'rake_compatibility'
  # Ryan Bates nifty generators
  gem 'nifty-generators'
  # haml and sass support for rails
  gem 'haml-rails'
end

# gems used in testing and development
group :development, :test do
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'database_cleaner'
  gem 'autotest-rails'
  # To use debugger
  gem 'ruby-debug19', :require => 'ruby-debug'
end

# test only gems
group :test do
  gem 'sqlite3'
  # Pretty printed test output
  gem 'turn', :require => false
  # Mocks and Stubs for testing
  gem 'mocha'
end
