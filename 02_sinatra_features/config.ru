# Run with:
# 
#   $ rackup --server mongrel --port 4000
#   $ thin --rackup config.ru --daemonize --log thin.log --pid thin.pid --environment production --port 4000 start
# 
# or:
# 
#   $ rake start
# 
# and see documentation:
# 
# $ rackup --help
# 
# Usage: rackup [ruby options] [rack options] [rackup config]
# 
# Rack options:
#   -s, --server SERVER      serve using SERVER (webrick/mongrel)
#   -p, --port PORT          use PORT (default: 9292)
#   -E, --env ENVIRONMENT    use ENVIRONMENT for defaults (default: development)
#   -D, --daemonize          run daemonized in the background
#   -P, --pid FILE           file to store PID (default: rack.pid)


require 'sinatra' 
require File.join(File.dirname(__FILE__), 'application.rb')
 
disable :run
set :environment, :production

map "/sinatra" do
  run Application
end
