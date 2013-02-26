source :rubygems

gem 'rails'

gem 'thin'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'haml-rails'
gem 'sass-rails'
gem 'compass-rails'
gem 'psych'
gem 'rbovirt'
gem 'openstack'
gem 'gettext_i18n_rails'

# gem "alchemy", "~> 1.0.0"
gem 'alchemy', :git => 'git://github.com/ui-alchemy/alchemy.git', :branch => 'master'

group :assets do
  gem 'therubyracer'
  gem 'uglifier'
end

group :sqlite do
  gem 'sqlite3'
end

group :development, :test do
  gem 'debugger'
end

group :development do
  gem 'gettext', '>=1.9.3', :require => false
  gem 'ruby_parser'
end

group :test do
  gem 'debugger'
  gem 'capybara'
  gem 'simplecov', :require => false
  gem 'launchy'
  gem 'factory_girl'
  gem 'vcr'
  gem 'fakeweb'
  gem 'rspec-rails'
end
