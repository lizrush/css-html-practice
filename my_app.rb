require 'rubygems'
require 'sequel'
require 'sinatra'


class MyApp < Sinatra::Base
  
before do
  @db = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://happyhour.db')
  @happyhour = @db[:happyhour]
end

  get "/" do
    erb :index
  end

  post "/" do
  	@happyhour.insert(location: params[:location]) 
  	erb :index
	end

	post "/voted" do
		count = @happyhour.where(:id => params[:id]).select(:votes)
  	@happyhour.where(id: params[:id]).update(votes: count + 1)
  	redirect "/"
  end

  get "/cute_pictures_of_animals" do
    erb :cute_pictures_of_animals
  end

end



