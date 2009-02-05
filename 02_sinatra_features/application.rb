require 'rubygems'
require 'sinatra'

before do
  @views = Dir['views/*.*'].entries.collect { |f| { :name => File.basename(f), :size => File.size(f) } }
end

get '/' do
  erb :index
end

# GET http://localhost:4567/views/index.erb
get %r{/views/(.+\..{1,4})} do
  filename = params[:captures]
  @file = { :name => filename, :contents => File.read("views/#{filename}") }
  erb :item
end
