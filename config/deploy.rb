require "whenever/capistrano"

set :application, "tweetmemybus.com"#"set your application name here"
set :repository,  "https://github.com/hugeeee/tweet_me_my_bus" # https://github.com/hugeeee/tweet_me_my_bus

set :scm, :git
set :scm_passphrase, "*****"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
#default_run_options[:pty] = true
set :user, "hkinghall"

role :web, "hkinghall@csserver.ucd.ie"# hkinghall@csserver.ucd.ie            # Your HTTP server, Apache/etc
role :app, "hkinghall@csserver.ucd.ie"                          # This may be the same as your `Web` server
role :db,  "hkinghall@csserver.ucd.ie", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :deploy_to, "~/var/www/apps/#{application}"
set :use_sudo, false

after "deploy:symlink", 'deploy:update_code', "deploy:update_crontab"

############################ THIS IS NOT FINISHED HERE YET?
namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
