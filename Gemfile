# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.3.1'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
gem 'active_model_serializers', '~> 0.10.6'
gem 'annotate', '~> 2.7', '>= 2.7.2'
gem 'dalli', '~> 2.7', '>= 2.7.6'
gem 'money-rails', '~> 1.8'
gem 'puma', '~> 3.0'
gem 'rack-attack', '~> 5.0', '>= 5.0.1'
gem 'rack-cors', '~> 0.4.1'
gem 'rails', '~> 5.0.2'
gem 'rubocop', '~> 0.49.1'
gem 'sqlite3'
group :development, :test do
  gem 'faraday', '~> 0.12.1'
  gem 'pry', '~> 0.10.4'
  gem 'pry-nav', '~> 0.2.4'
  gem 'rspec-rails', '~> 3.6'
end
group :test do
  gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'faker', '~> 1.8', '>= 1.8.2'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
end
group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
