# = A Sinatra application running standalone or in context of Rails metal
# 
# Run this standalone with
#   $ rackup metal/app/metal/api.rb -s thin -p 4000
# and see it on
#   http://localhost:4000/api/products/953125641/in_stock.json
# 
# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

require 'sinatra/base'

class Api < Sinatra::Base

  enable :logging

  get '/api/products/:id/in_stock.json' do
   response['Content-Type'] = 'application/json; charset=utf-8'
   @product = Product.find params[:id]
   @product.to_json(:only => ['id', 'name', 'in_stock'])
  end

end
