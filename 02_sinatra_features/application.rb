require 'rubygems'
require 'sinatra'

get '/' do
  "Hello, world!"
end

get '/special' do
  "Hello, special!"
end

get '/:name' do
  "Hello, #{params[:name]}!"
end

# GET http://localhost:4567/download/file.txt
get '/download/*.*' do
  "Got #{params[:splat].inspect}"  # Broken in < 0.9.0.4 (eats first letter)
end

# GET http://localhost:4567/hello/123-start
get %r{/hello/(\d{0,4})\-([\w]+)} do
  "Hello, #{params[:captures].inspect}!"
end
