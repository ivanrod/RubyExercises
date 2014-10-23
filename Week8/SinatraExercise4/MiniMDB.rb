require 'sinatra'
require 'sinatra/reloader'
require 'imdb'

get '/' do 
	erb :index
end

post '/' do
	if params["showType"] == "tvShow"
	end
	show = Imdb::Search.new(params["showName"])
	erb :index
end