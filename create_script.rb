require 'sequel'

db = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://happyhour.db')
db.create_table(:happyhour) do
  primary_key :id
  string :location
  integer :votes, default: 0
end