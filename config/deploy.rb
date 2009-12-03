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