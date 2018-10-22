# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :passenger_restart_with_touch, true
set :application, "dbjohn_api"
set :repo_url, ENV['GIT_REPO']
set :deploy_to, APP_CONFIG['CAP_APP_DIR']
set :default_env, {
    'PATH' => "#{deploy_to}/bin:$PATH",
    'GEM_HOME' => "#{deploy_to}/gems",
    'RUBYLIB' => "#{deploy_to}/lib"
}
set :tmp_dir, "/home/#{ENV['CAP_USER']}/tmp"
server APP_CONFIG['domain'], user: APP_CONFIG['CAP_USER'], roles: %w{app db web}
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/config.yml', )
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :keep_releases, 2
