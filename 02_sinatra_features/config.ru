require 'application'

set :app_file,         'application.rb'
set :environment,      :production

disable :run, :reload
 
run Sinatra::Application
