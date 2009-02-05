require 'rubygems'
require 'sinatra'

before do
  @views = Dir['views/*.*'].entries.collect { |f| { :name => File.basename(f), :size => File.size(f) } }
end

error do
  File.read('public/500.html')
end

get '/' do
  erb :index
end

# GET http://localhost:4567/views/index.erb
# GET http://localhost:4567/views/item.XXXXX => Error 500
# (Errors are handled differently in :development and :production)
get %r{/views/(.+\..{1,4})} do
  filename = params[:captures]
  @file = { :name => filename, :contents => File.read("views/#{filename}") }
  erb :item
end
