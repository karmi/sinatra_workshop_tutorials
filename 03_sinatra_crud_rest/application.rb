require 'rubygems'
require 'sinatra'
require 'activerecord'

require 'lib/note'

configure do
  ActiveRecord::Base.establish_connection( :adapter => 'sqlite3', :database => 'notes.db')
  load 'lib/schema.rb' unless Note.table_exists?
end

# List: GET /
get '/' do
  @notes = Note.all(:order => 'created_at DESC')
  haml :index
end

# Detail: GET /1
get '/:id/?' do
  @note = Note.find params[:id]
  haml :show
end

# Edit: GET /1/edit
get '/:id/edit' do
  @note = Note.find params[:id]
  haml :edit
end

# Create: POST /
post '/' do
  @note = Note.create( params[:note] )
  if @note.valid?
    session[:success] = 'Created new note'
    redirect '/' and return
  else
    @notes = Note.all(:order => 'created_at DESC')
    haml :index
  end
end

# Update: PUT /1
put '/:id' do
  @note = Note.find params[:id]
  @note.update_attributes params[:note]
  redirect '/'
end

# Destroy: DELETE /1
delete '/:id' do
  @note = Note.destroy params[:id]
  session[:success] = 'Note was successfully deleted'
  redirect '/'
end
