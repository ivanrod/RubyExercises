require 'sinatra'
require 'sinatra/reloader'
require 'imdb'
require 'json'

@showHash = {}
@showJson = @showHash.to_json

get '/' do 
	erb :index
end

post '/list' do
	if params["showType"] == "tvShow"
	end
	
	if request.xhr?
		@show = Imdb::Search.new(params["showName"])
		@showList = []
		@show.movies.each do |item|
			@showList.push(item.title)
		end
		@showHash ={'showList' => @showList}
		@showJson = @showHash.to_json
	else
	    return @showJson
	end
end

get '/hello/data.json' do
	@show = Imdb::Search.new(params["showName"])
	@showList = []
	@show.movies.each do |item|
		@showList.push(item.title)
	end
	@showHash ={'showList' => @showList}
	@showJson = @showHash.to_json
end
x=''
get '/list2' do 
	if request.xhr?
		#@x = request.body.read.to_s
		@show = Imdb::Search.new(x)
		@showList = []
		@show.movies.each do |item|
			@showList.push(item.title)
		end
		@showHash ={'showList' => @showList}
		@showJson = @showHash.to_json
		return @showJson
	else
		return 'error'
	end
end

post '/list2' do 
	if request.xhr?
		x = request.body.read.to_s
		return x
	else
		return 'error'
	end
end