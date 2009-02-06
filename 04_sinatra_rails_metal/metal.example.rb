# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

require 'sinatra/base'

class Api < Sinatra::Base

  get '/api/products/:id/in_stock.json' do
   response['Content-Type'] = 'application/json; charset=utf-8'
   @product = Product.find params[:id]
   @product.to_json(:only => ['id', 'name', 'in_stock'])
  end

end
