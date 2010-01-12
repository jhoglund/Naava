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

require 'lib/crawler'
 
namespace :admin do
 
  desc "Crawl pages using the Mechanize gem. Set URL variable as a starting point. Set CREDS as username:password if you are hitting a password protected site. To generate a Google Sitemap in /public/sitemap.xml, set SITEMAP=true. To suppress output and only show errors, set QUIET=true. To show more details during output, set DEBUG=true."
  task :crawl_pages do
    start_url = ENV["URL"] || "http://www.navayoga.se/"
    sitemap = Crawler.new(start_url, (ENV["CREDS"] if ENV["CREDS"]), ENV["QUIET"] || false, ENV["SITEMAP"] || false, ENV["DEBUG"] || false)
  end
 
end
