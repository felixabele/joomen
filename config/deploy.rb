# application name ( should be rails1 rails2 rails3 ... )
set :application, "rails1"
set :normalize_asset_timestamps, false

# user to login to the target server
set :user, "user18821475"

# password to login to the target server
set :password, "klack7*bum"

# allow SSH-Key-Forwarding
set :ssh_options, { :forward_agent => true }

set :svn_user, 'felix_abele@hotmail.de'
set :svn_password, 'guardian'
set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm_verbose, true

set :repository,
Proc.new { "--username #{svn_user} --password #{svn_password} http://subversion.assembla.com/svn/joomen" }

# run in pty to allow remote commands via ssh
default_run_options[:pty] = true

# don't use sudo it's not necessary
set :use_sudo, false

# set the location where to deploy the new project
set :deploy_to, "/home/#{user}/#{application}"

# live
role :app, "zeta.railshoster.de"
role :web, "zeta.railshoster.de"
role :db,  "zeta.railshoster.de", :primary => true


############################################
# Default Tasks by RailsHoster.de
############################################
namespace :deploy do

  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Additional Symlinks ( database.yml, etc. )"
  task :additional_symlink, :roles => :app do
    run "ln -fs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end

end
after "deploy:symlink","deploy:additional_symlink","deploy:migrate", "deploy:create_symlink"