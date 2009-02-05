require 'rubygems'
require 'sinatra'

before do
  puts request.env['HTTP_USER_AGENT']
  @firefox = request.env['HTTP_USER_AGENT'] =~ /Firefox/
end

get '/' do
  @firefox ? 'Oh &hearts; welcome, Firefox user!' : 'What do you want?'
end
