source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.7"

gem "rails",           "8.1.0" #変更
gem "image_processing",           "~> 1.12.2"
gem "active_storage_validations", "~> 0.9.8"
gem "bcrypt",          "~> 3.1.18"
gem "faker",           "~> 2.21.0"
#課題でkaminariを使ってページネーションの実装をするためコメントアウト
#gem "will_paginate",           "3.3.1"
#gem "bootstrap-will_paginate", "1.0.0"
gem 'kaminari' #kaminariを使う
gem "bootstrap-sass",  "~> 3.4.1"
gem "sassc-rails",     "~> 2.1.2"
gem "sprockets-rails", "~> 3.4.2"
gem "importmap-rails", "~> 1.1.5"
gem "turbo-rails",     "~> 1.4.0"
gem "stimulus-rails",  "~> 1.2.1"
gem "jbuilder",        "~> 2.14.1"
gem "puma",            ">= 6.0" #変更Puma 5.x が Rack 3.x と互換性がないため
gem "bootsnap",        "~> 1.16.0", require: false
gem "sqlite3",         "~> 2.7.4"
gem "concurrent-ruby", "~> 1.3.4"
gem 'rubyzip', '~> 2.3.0'
gem "mutex_m"

group :development, :test do
  gem 'reline', '~> 0.5.10'
  gem "debug",   "~> 1.7.1", platforms: %i[ mri mingw x64_mingw ]
  #拡張課題＿RSpecを使ってみる
  gem 'rspec-rails', '~> 6.0.0' # RSpec本体
end

group :development do
  gem "web-console",         "~> 4.2.0"
  gem "solargraph",          "~> 0.53.4"
  #gem "irb",                 "1.10.0"
  gem "repl_type_completor", "~> 0.1.2"
end

group :test do
  gem 'database_cleaner-active_record'
  gem "capybara",                 "~> 3.40"
  gem "selenium-webdriver",       "~> 4.11.0"
  gem "rails-controller-testing", "~> 1.0.5"
  gem "minitest",                 "~> 5.18.0"
  gem "minitest-reporters",       "~> 1.6.0"
  gem "guard",                    "~> 2.18.0"
  gem "guard-minitest",           "~> 2.4.6"
end

group :production do
  gem "pg", "~> 1.3.5"
  gem "aws-sdk-s3", "~> 1.114.0", require: false
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "devise", "~> 4.9"
