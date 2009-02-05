require 'rubygems'
require 'sinatra'

# $ ruby application.rb
configure do
  PASSWORD = 'password'
end

# $ ruby application.rb -e production -p 5678
configure :production do
  PASSWORD = '5f4dcc3b5aa765d61d8327deb882cf99'
end

get '/:password' do
  params[:password] == PASSWORD ? '&iexcl;Welcome!' : 'What?'
end
