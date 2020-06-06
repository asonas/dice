source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.2'

gem 'action_args'
gem 'bootsnap', require: false
gem 'jbuilder'
gem 'pg'
gem 'puma'
gem 'ridgepole'
gem 'sass-rails'
gem 'simpacker'
gem 'slim-rails'

group :development do
  gem 'awesome_print'
  gem 'byebug', platform: :mri
  gem "capistrano", require: false
  gem 'capistrano-rbenv'
  gem 'listen'
  gem 'pry-byebug', group: :test
  gem 'pry-rails', group: :test
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'database_rewinder'
  gem 'factory_bot_rails'
  gem 'guard-rspec'
  gem 'rspec-rails', group: :development
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
