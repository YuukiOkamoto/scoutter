lock '3.9.0'

set :application, 'scoutter'
set :repo_url, 'git@github.com:YuukiOkamoto/scoutter.git'

# Default branch is :master
set :branch, ENV['BRANCH'] || 'master'

# Default value for :linked_files is []
set :linked_files, %w(.env config/database.yml config/master.key)

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_path, '/usr/local/rbenv'

# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :puma_bind, 'unix:///var/www/scoutter/shared/tmp/sockets/puma.sock'
set :puma_state, '/var/www/scoutter/shared/tmp/pids/puma.state'
set :puma_pid, '/var/www/scoutter/shared/tmp/pids/puma.pid'
set :puma_access_log, '/var/www/scoutter/shared/log/puma.error.log'
set :puma_error_log, '/var/www/scoutter/shared/log/puma.access.log'



namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :confirm do
    on roles(:app) do
      puts "This stage is '#{fetch(:stage)}'. Deploying branch is '#{fetch(:branch)}'."
      puts 'Are you sure? [y/n]'
      ask :answer, 'n'
      if fetch(:answer) != 'y'
        puts 'deploy stopped'
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke 'deploy'
    end
  end

  before :starting, :confirm
end
