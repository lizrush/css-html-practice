require 'sequel'

db = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://happyhour.db')
db.create_table(:happyhour) do
  primary_key :id
  String :location
  Integer :votes, default: 0
  # add column for date created, then use ruby magic to determine current weeks bars and only display those ones
end



# to delete

# heroku pg:reset DATABASE_URL --confirm liz-sinatra

# to create_script

# heroku run ruby create_script.rb