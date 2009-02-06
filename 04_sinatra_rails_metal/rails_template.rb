# Run with rails metal -m template.rb (requires Rails > 2.3)

file '.gitignore', <<-END
.DS_Store
*/.DS_Store
log/*.log
tmp/**/*
config/database.yml
config/deploy.rb
db/*.sqlite3
doc/app/
public/uploads/*
END

inside('vendor') do
  run "ln -s ~/Playground/Rails/rails rails"
end

run "rm public/index.html"

25.times do |i|
  # generate(:scaffold, "dummy_#{i} name:string")
end

generate(:scaffold, "product name:string description:text price:integer in_stock:integer")
route "map.root :controller => 'products'"

rake("db:create",  :env => 'development')
rake("db:create",  :env => 'production')
rake("db:migrate", :env => 'development')
rake("db:migrate", :env => 'production')
rake("db:fixtures:load FIXTURES=products", :env => 'development')
rake("db:fixtures:load FIXTURES=products", :env => 'production')

inside('app/controllers') do
  insert =<<END
class ProductsController < ApplicationController

  def in_stock
    @product = Product.find( params[:id] )
    respond_to do |format|
      format.json { render :json => @product.to_json(:only => ['id', 'name', 'in_stock']) }
      format.xml  { render :xml  => @product.to_json(:only => ['id', 'name', 'in_stock']) }
    end
  end

END
  content = File.read('products_controller.rb').sub(/class ProductsController < ApplicationController/, insert)
  File.open('products_controller.rb', 'w+') { |f| f << content }
end

inside('config') do
  insert=<<END
  map.resources :products, :member => { :in_stock => :get }
END
  content = File.read('routes.rb').sub(/map.resources :products/, insert)
  File.open('routes.rb', 'w+') { |f| f << content }
end