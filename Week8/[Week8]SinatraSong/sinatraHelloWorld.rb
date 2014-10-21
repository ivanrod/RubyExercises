require 'sinatra'
require "sinatra/reloader"

get '/' do
  erb :index
end

get '/hello/:username' do
	@name = params["username"] 
	"Hello  #{@name}"
end

post '/hello' do
  @name = params["username"]
  "Hello #{@name}"
end