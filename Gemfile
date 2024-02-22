# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in docuseal.gemspec
gemspec

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"

gem "standard", "~> 1.3"

group :development, :test do
  gem "webmock", "~> 3.19.1"
  gem "byebug", "~> 11.1"
  gem "pry", "~> 0.14.2"
  gem "pry-byebug", "~> 3.10"
  gem "pry-rescue", "~> 1.5"
  gem "pry-stack_explorer", "~> 0.6.1"
end

group :test do
  gem "simplecov"
  gem "simplecov-cobertura"
end
