require 'rubygems'
require 'sinatra'

before do
  puts request.env['HTTP_USER_AGENT']
  halt 417, 'Expectation Failed' unless request.env['HTTP_USER_AGENT'] =~ /Firefox/
end

get '/' do
  'Oh &hearts; welcome, Firefox user!'
end
