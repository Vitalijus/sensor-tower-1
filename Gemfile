source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# MongoDB database
gem 'mongo', '~> 2.2', '>= 2.2.5'

group :development, :test do
  gem 'rspec', '~> 3.4'
  gem 'pry', '~> 0.14.1'
end

group :development do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
