require 'sinatra'
require 'sinatra/reloader'
require './classes/Song'

songs = []

get '/' do 
	@songs = songs
	erb :index
end

get '/songs' do 
	erb :songs
end

post '/songs/new' do
	songs.push(Song.new(params["songName"], params["artist"]))
	if songs.length < 10
		redirect to('/')
	else
		"IS WORTH FUCKING NOTHING"
	end
end