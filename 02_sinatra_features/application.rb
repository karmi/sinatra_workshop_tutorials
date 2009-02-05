require 'rubygems'
require 'sinatra'

helpers do

  def decorated(string)
    "&hearts;#{string}&hearts;"
  end

  def human_date(datetime)
    datetime.strftime('%d. %B %Y')
  end

end

get '/decorated/:name' do
  "Oh, hello, #{decorated( params[:name] )}!"
end

get '/date' do
  human_date( Time.now )
end
