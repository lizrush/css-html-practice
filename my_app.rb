require 'rubygems'
require 'sequel'
require 'yaml'
require 'sinatra/base'


class MyApp < Sinatra::Base
  
before do
  @db = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://happyhour.db')
  @happyhour = @db[:happyhour]

  @posts = Dir.glob("views/posts/*.erb").map do |post_name|
      post_name.split("/").last.slice(0..-5)
  end
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

  get "/blog" do
    erb :blog, :locals => {:title => "blog"}
  end

  get "/blog/:post_name" do
    page = erb("/posts/#{params[:post_name]}".to_sym, layout: false)
    page_body = page.split("\n\n", 2).last
    erb page_body, :locals => {:title => "blog"}
  end

  def meta_data
    if @meta_data
      @meta_data
    else
      @meta_data = {}
      @posts.each do |post|
      html = erb("/posts/#{post}".to_sym, layout: false)
      meta = YAML.load(html.split("\n\n", 2).first)
      @meta_data[post] = meta
      end
    end
    @meta_data
   end
end



