set :application, 'apteka.ws'
set :stage, :production
set :repo_url, 'https://github.com/BrandyMint/pharmely.git'
#ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, ->{"/home/pharmely/#{fetch(:application)}"}
server 'icfdev.ru', user: 'pharmely', port: 246, roles: %w{web app sidekiq db}
set :rails_env, :production
set :branch, ENV['BRANCH'] || 'master'
fetch(:default_env).merge!(rails_env: :production)
