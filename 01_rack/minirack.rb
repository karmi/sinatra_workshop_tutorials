require 'rubygems'
require 'rack'

# Try http://localhost:8080/?k=v
app = Proc.new do |env|
        [ 200,
        {'Content-Type' => 'text/plain'},
        "Received params: #{XXX___this_is_the_fail___XXXRack::Request.new(env).params.inspect}" ]
end

stack = Rack::Builder.app do
 use Rack::CommonLogger
 use Rack::ShowExceptions
 run app
end

Rack::Handler::Thin.run stack
