require 'sinatra'
require 'sinatra/reloader'
require 'imdb'
require 'json'

@showHash = {}
@showJson = @showHash.to_json
selectedShows = {}
#index View
get '/' do 
	@selectedShows = selectedShows
	erb :index
end

#'/list2' views to allow AJAX
x=''

post '/list2' do 
	if request.xhr?
		x = request.body.read.to_s
		return x
	else
		return 'error'
	end
end

get '/list2' do 
	if request.xhr?
		#@x = request.body.read.to_s
		@show = Imdb::Search.new(x)
		@showList = []
		@show.movies.each do |item|
			@showList.push([item.title, item.id])
		end
		@showHash ={'showList' => @showList}
		@showJson = @showHash.to_json
		return @showJson
	else
		return 'error'
	end
end

#'/show' view to add shows


post '/show' do 
	movie = Imdb::Movie.new(params[:showType])
	@title = movie.title
	@rating = movie.rating
	@cover = movie.poster
	@url = movie.url

	if @rating.to_f > 9
		@class = 'darkGreen'
	elsif @rating.to_f > 8
		@class = 'green'
	elsif @rating.to_f > 5.5
		@class = 'yellow'
	else
		@class = 'red'
	end
			
			

	@selectedShows = selectedShows
	@selectedShows[params[:showType]] = [@title, @rating, @cover, @url, @class]
	selectedShows = @selectedShows
	erb :show
end

