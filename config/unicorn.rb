# config/unicorn.rb

# Set environment to development unless something else is specified
env = ENV["RAILS_ENV"] || "production"

# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete documentation.
worker_processes 3 # amount of unicorn workers to spin up

APP_PATH = "/home/deploy/deathstar"

listen "/tmp/deathstar.socket"

preload_app true

timeout 60         # restarts workers that hang for 30 seconds

pid "/tmp/unicorn.deathstar.pid"

# By default, the Unicorn logger will write to stderr.
# Additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stdout.log"

if env == "production"
  # Help ensure your application will always spawn in the symlinked
  # "current" directory that Capistrano sets up.
  working_directory APP_PATH

  # feel free to point this anywhere accessible on the filesystem
  user 'deploy', 'root' # 'user', 'group'
  shared_path = "/home/deploy/deathstar"

  stderr_path "#{shared_path}/log/unicorn.stderr.log"
  stdout_path "#{shared_path}/log/unicorn.stdout.log"
end

preload_app true

before_fork do |server, worker|
  old_pid = "/tmp/unicorn.deathstar.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
