# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name                  = 'capistrano-cache-cleaner'
  gem.version               = '1.0.0'
  gem.date                  = '2020-08-25'
  gem.summary               = 'Set of tasks to clean cache'
  gem.description           = 'Set of tasks to clean cache'
  gem.authors               = ['Anton Topchii']
  gem.email                 = 'player1@infinitevoid.net'
  gem.homepage              =
    'https://github.com/crawler/capistrano-cache-cleaner'
  gem.license               = 'MIT'

  gem.files                 = %w[lib/capistrano/cache.rb lib/capistrano/tasks/cache.rake]
  gem.require_paths         = %w[lib]

  gem.required_ruby_version = '>= 2.7'
  gem.add_dependency 'capistrano', '~> 3.0'
  gem.add_dependency 'sshkit', '~> 1.2'
end
