# = A Sinatra application running standalone or in context of Rails metal
# 
# Run this standalone with
#   $ rackup metal/app/metal/api.rb -s thin -p 4000
# and see it on
#   http://localhost:4000/api/

# == Load Rails unless already loaded
require(File.dirname(__FILE__) + "/../../../config/environment") unless defined?(Rails)

# == Sinatra application
# Note that our URLs do not begin with "api"
# This allows us to test/run it apart from Rails and still run it
# on "/api/" in context of Rails,
# thanks to <tt>Rack::Builder#map</tt> in config.ru
require 'sinatra/base'
module SinatraMetal

  class Api < Sinatra::Base

    enable :logging, :static

    # Test: http://localhost:4000/api
    get '/?' do
      Time.now.to_s
    end

    # Part of application (JSON "API service")
    #   http://localhost:4000/api/products/953125641/in_stock.json
    get '/products/:id/in_stock.json' do
     response['Content-Type'] = 'application/json; charset=utf-8'
     @product = Product.find params[:id]
     @product.to_json(:only => ['id', 'name', 'in_stock'])
    end

  end

end
