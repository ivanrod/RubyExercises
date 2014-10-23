require 'sinatra'
require 'sinatra/reloader'

get '/' do 
	erb :index
end

get '/counting' do 
	erb :counting
end

post '/result' do 
	@result = operate(params["number1"],params["number2"],params["operator"])
	"The result is #{@result}"
end

def operate(number1,number2,operator)
	number1 = number1.to_f
	number2 = number2.to_f
	if operator == "Add"
		return number1 + number2
	elsif operator == "Substract"
		return number1 - number2
	elsif operator == "Multiply"
		return number1 * number2
	elsif operator == "Divide"
		return number1 / number2
	end
end
		