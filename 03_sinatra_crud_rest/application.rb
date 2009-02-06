require 'rubygems'
require 'sinatra'
require 'activerecord'

require 'lib/note'

configure do
  ActiveRecord::Base.establish_connection( :adapter => 'sqlite3', :database => 'notes.db')
  load 'lib/schema.rb' unless Note.table_exists?
end
