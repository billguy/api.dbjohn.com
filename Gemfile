source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'sqlite3', group: [:test, :development]
gem 'mysql2', group: :production
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rack-cors'
gem 'jwt_sessions'
gem 'acts-as-taggable-on'
gem 'exifr'
gem 'exception_notification-rake', github: 'nikhaldi/exception_notification-rake'
gem 'geocoder'
gem 'google-cloud-storage', '~> 1.11', require: false
gem 'kaminari'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'active_model_serializers', '~> 0.10.7'
gem 'permalink'
gem 'mini_magick'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'shoulda-matchers', '~> 3.1'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.7'
  gem 'factory_bot_rails'
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'bullet', github: 'flyerhzm/bullet'
  gem 'capistrano',  '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-passenger'
end
