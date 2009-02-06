require 'sinatra/base'

class Application < Sinatra::Base

  enable :logging

  get '/?' do
    "Hello, Rack world!"
  end

end

Application.run! if __FILE__ == $0


# Run with 
#   $ ruby application.rb
# or +rackup+
#   $ rackup --server webrick --port 4000 --env production
# or +thin+
#   $ rake start
#   $ thin --rackup config.ru --daemonize --log thin.log --pid thin.pid --environment production --port 4000 start