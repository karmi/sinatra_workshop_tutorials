# Load Sinatra from edge instead from gem's
$LOAD_PATH.unshift File.join( File.dirname(__FILE__), '..', 'vendor/sinatra-sinatra/lib' )

require 'rubygems'
require 'sinatra'

set :views,       'templates'
set :environment, 'production'

before do
  @views = Dir["#{Sinatra::Application.views}/*.*"].entries.collect do |f|
    { :name => File.basename(f), :size => File.size(f) }
  end
end

error do
  File.read('public/500.html')
end

get '/' do
  erb :index
end

# GET http://localhost:4567/views/index.erb
get %r{/views/(.+\..{1,4})} do
  filename = params[:captures]
  @file = { :name => filename, :contents => File.read( File.join(Sinatra::Application.views, filename) ) }
  erb :item
end

get '/about' do
  "I'm running on Sinatra version " + Sinatra::VERSION
end