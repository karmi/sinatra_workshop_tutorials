# Inspired by Ryan Tomayko, http://github.com/rtomayko/wink/tree/master/lib/wink/models.rb#L276
ActiveRecord::Schema.define(:version => 1) do
  create_table :notes do |t|
    t.text   :body
    t.datetime :created_at, :default => 'NOW()'
  end
end