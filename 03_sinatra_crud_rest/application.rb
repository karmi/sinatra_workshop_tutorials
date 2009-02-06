# Load Sinatra from edge instead from gem's
$LOAD_PATH.unshift File.join( File.dirname(__FILE__), '..', 'vendor/sinatra-sinatra/lib' )

require 'rubygems'
require 'sinatra'
require 'activerecord'

require 'lib/note'

enable :sessions

configure do
  ActiveRecord::Base.establish_connection( :adapter => 'sqlite3', :database => 'notes.db')
  load 'lib/schema.rb' unless Note.table_exists?
end

helpers do
  def human_date(datetime)
    datetime.strftime('%d|%b|%Y')
  end
  def truncate(chars)
    chars.size > 50 ? chars.to_s[0...50] + '&hellip;' : chars
  end
  def flash(key)
    out = session[key]
    session[key] = nil
    return out
  end
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

get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end

use_in_file_templates! # Should not be needed.

__END__

@@ layout
%html
  %head
    %title= "Notes"
    %meta{ 'http-equiv' => 'Content-Type', :content => 'text/html;charset=utf-8' }
    %link{ :rel => 'stylesheet', :type => 'text/css', :href => "/style.css" }
  %body
    %h1
      %a{:href => '/'}
        Notes
    %hr
    = yield

@@ index
- if @note && ! @note.errors.empty?
  %div.failure
    There were some errors when saving the note:
    = @note.errors.full_messages.join(', ')
- if f = flash(:success)
  %div.success= f
%div
  %form{ :action => "/", :method => 'post' }
    %textarea{ 'type' => 'text', 'name' => 'note[body]' }
    %br
    %input{ 'type' => 'submit', 'value' => 'Save note', 'class' => 'submit', 'accesskey' => 's' }
- @notes.each do |note|
  %div[note]
    %p
      %em= human_date(note.created_at)
      %a{:href=>note.permalink}
        = truncate note.body
    %form{ :action => note.permalink, :method => 'post' }
      %input{ 'type' => 'hidden', 'name' => '_method', 'value' => 'delete'}
      %input{ 'type' => 'submit', 'value' => 'Delete', 'onclick' => 'return confirm("Really delete this note?")' }

@@ show
%div[@note]
  %em= human_date(@note.created_at)
  = @note.body
  %form{ :action => "/#{@note.id}/edit", :method => 'get' }
    %input{ 'type' => 'submit', 'value' => 'Edit' }
  %form{ :action => @note.permalink, :method => 'post' }
    %input{ 'type' => 'hidden', 'name' => '_method', 'value' => 'delete'}
    %input{ 'type' => 'submit', 'value' => 'Delete', 'onclick' => 'return confirm("Really delete this note?")' }

@@ edit
%div[@note]
  %em= human_date(@note.created_at)
  %form{ :action => @note.permalink, :method => 'post' }
    %input{ 'type' => 'hidden', 'name' => '_method', 'value' => 'put'}
    %textarea{ 'type' => 'text', 'name' => 'note[body]' }= @note.body
    %br
    %input{ 'type' => 'submit', 'value' => 'Update note', 'class' => 'submit', 'accesskey' => 's' }

@@ style
body
  :color #000
  :background #f8f8f8
  :font-size 90%
  :font-family Helvetica, Tahoma, sans-serif
  :line-height 1.5
  :padding 10%
  :text-align center
a
  :color #000
div.success
  :color #128B45
  :padding 0.5em 0
div.failure
  :color #E21F3A
  :padding 0.5em 0
div.note
  :text-align left
  :border 2px solid #ccc
  :padding 1em
  :margin 1em 0
div.note p
  :float left
  :margin 0 1em 0 0
  :padding 0
div.note em
  :font-size 80%
  :color #999
div.note form
  :margin 0
form
  :text-align left
textarea
  :font-family sans-serif
  :padding 0.5em
  :border 2px solid #999
  :width 100%
input.submit
  :font-size 100%
  :margin-top 0.5em
