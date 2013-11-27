require 'rubygems'
require 'sequel'
require 'sinatra'


class MyApp < Sinatra::Base
  
before do
  @db = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://happyhour.db')
  @happyhour = @db[:happyhour]
end

  get "/" do
    erb :index, :locals => {:title => "~*ada happy hour voting mechanism*~"} 
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
    erb :cute_pictures_of_animals, :locals => {:title => "~*pics of animals*~"} 
  end

  get "/blog/:post_name" do
    params[:post_name]
    erb "/posts/#{params[:post_name]}".to_sym
  end


end



