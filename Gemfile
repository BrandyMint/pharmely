source 'https://rubygems.org'

gem 'sorcery'
gem 'authority'

gem 'grape', github: 'intridea/grape'
gem 'grape-swagger', github: 'tim-vandecasteele/grape-swagger'
gem 'grape-swagger-rails', github: 'BrandyMint/grape-swagger-rails'
gem 'grape-rails-routes'
gem 'grape-entity'

gem 'hashie'

gem 'settingslogic'

gem 'semver2'

gem "bugsnag"
gem 'enumerize'

# Reading xlsx, ods, csv
gem 'roo', github: 'roo-rb/roo'
gem 'roo-xls', github: 'roo-rb/roo-xls'
gem 'spreadsheet'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0'
gem 'bootstrap-sass', '~> 3.3.1'
gem 'autoprefixer-rails'

gem 'carrierwave'

gem 'sinatra', '>= 1.3.0', :require => nil
gem 'sidekiq', '~> 3.3.0'
gem 'sidekiq-reset_statistics'
gem 'sidekiq-failures'
gem 'sidekiq-unique-jobs'
gem 'sidekiq-status'
gem 'sidekiq_mailer'
gem 'sidetiq', github: 'tobiassvn/sidetiq'


gem 'therubyracer'
gem 'activerecord-session_store'

gem 'chewy', github: 'toptal/chewy'
gem 'virtus'
gem 'simple-navigation', :git => 'git://github.com/andi/simple-navigation.git'
gem 'simple-navigation-bootstrap'

gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'kaminari'
gem 'kaminari-i18n'
#gem 'bootstrap-kaminari-views'
gem 'kaminari-bootstrap'

gem 'slim-rails'

gem 'pg'

gem 'draper'

gem 'phantomjs'
gem 'watir-rails'
gem 'watir-dom-wait'

gem 'mechanize'

#gem 'devise', github: 'plataformatec/devise', branch: 'lm-rails-4-2'
gem 'inherited_resources' #, github: 'codecraft63/inherited_resources', branch: 'master'
gem 'responders'#, '~> 2.0'
gem 'activeadmin', github: 'activeadmin'
gem 'active_admin_editor'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #gem 'byebug'
  gem 'test_after_commit'

  gem 'pry'
  gem 'pry-syntax-hacks'
  gem 'pry-nav'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem "rspec-rails"
  gem 'rspec-collection_matchers'
  gem 'rb-inotify', require: false
  gem 'factory_girl_rails'
  gem "listen", "~> 2.7.12"
  gem 'guard'

  gem 'guard-rspec', require: false
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-ctags-bundler'
end


group :deploy do
  gem 'capistrano', '~> 3.2.1', :require => false
  gem 'capistrano-rbenv', '~> 2.0', :require => false
  gem 'capistrano-rails', '~> 1.1', :require => false
  gem 'capistrano-bundler', :require => false
  gem "capistrano-db-tasks", :require => false
end
