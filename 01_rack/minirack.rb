require 'rubygems'
require 'rack'

Rack::Handler::Thin.run proc { |env| [ 200, {'Content-Type' => 'text/plain'}, "Hello World!" ] }
