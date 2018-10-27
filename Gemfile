source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1'

# Database
gem 'mysql2', '>= 0.4.4', '< 0.6.0'

# Assets
gem 'bootstrap', '~> 4.1.3'
gem 'bootswatch', github: 'thomaspark/bootswatch'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# Application server
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'mini_racer', platforms: :ruby

# Authentication
gem 'sorcery'

# Background Job
gem 'whenever', require: false

# Configuration
gem 'dotenv-rails', require: 'dotenv/rails-now'

# Slim
gem 'slim-rails'
gem 'html2slim'

# Twitter
gem 'twitter'

# UI/UX
gem 'rails-i18n', '~> 5.0.0'
gem 'jbuilder', '~> 2.5'
gem 'chart-js-rails'
gem 'yen'

# Storage
gem 'mini_magick', '~> 4.8'

# Soft delete
gem 'paranoia'

# Model
gem 'active_hash'

# Decorator
gem 'draper'

# Seeds
gem 'seed-fu'

# Pagination
gem 'kaminari'
gem 'kaminari-i18n'
gem 'bootstrap4-kaminari-views'

group :development, :test do
  # Debugger
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Code analyze
  gem 'rubocop-rails_config'
  gem 'rails_best_practices'
  gem 'scss_lint', require: false
  gem 'slim_lint'

  # Deploy
  gem 'capistrano', '3.9.0'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano-rbenv-vars'

  # CLI
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development do
  # Debugger
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end
