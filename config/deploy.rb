server "experience", :app, :web, :db, :primary => true

default_run_options[:pty] = true

set :client, "naava"
set :project, "website"
set :repository, "git@github.com:jhoglund/Naava.git"
set :ssh_options, {:forward_agent => true}

set :deploy_to, "/home/clients/sites/#{client}/#{project}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm, :git

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

after "deploy", "deploy:cleanup"