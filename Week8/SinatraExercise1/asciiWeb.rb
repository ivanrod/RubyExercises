require 'sinatra'
require 'sinatra/reloader'
require 'artii'

get "/ascii/:asciiText" do
	@ascii = params["asciiText"]
	a = Artii::Base.new
	@asciiText = a.asciify(@ascii)
	erb :ascii
end