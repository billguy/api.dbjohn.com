source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.5'

gem 'rails', '7.2.1'
gem 'pg', group: :production
gem 'puma'
gem 'bootsnap', require: false
gem 'rack-cors'
gem 'jwt_sessions'
gem 'acts-as-taggable-on'
gem 'exifr'
gem 'exception_notification-rake', github: 'nikhaldi/exception_notification-rake'
gem 'geocoder'
gem 'google-cloud-storage', require: false
gem 'kaminari'
gem 'bcrypt', require: 'bcrypt'
gem 'active_model_serializers'
gem 'permalink'
gem 'mini_magick'
gem 'recaptcha'
gem 'redis'
gem 'image_processing'

group :development, :test do
  gem 'sqlite3'
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
  gem 'bullet'
end
