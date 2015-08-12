set :application, 'apteka.ws'
set :stage, :production
set :repo_url, 'git@github.com:BrandyMint/pharmely.git'
#ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, ->{"/home/wwwapteka/#{fetch(:application)}"}
server '128.199.44.98', user: 'wwwapteka', port: 22, roles: %w{web app sidekiq db}
set :rails_env, :production
set :branch, ENV['BRANCH'] || 'master'
fetch(:default_env).merge!(rails_env: :production)
