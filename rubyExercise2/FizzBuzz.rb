def FizzBuzz(param, param2)
	param % param2 == 0
end

def concatenate(param1,listHash)
	message = ""
	listHash.keys.each do |m|
		if FizzBuzz(param1, m)
			message  += listHash[m]
		end
	end
	if message == ""
		puts param1
	else
		puts message
	end
end

(0..1000).each do |i|
	concatenate(i,{5=>"Buzz", 3=>"Fizz", 7=>"Pum", 13=>"Pepe"})
end	


=begin
(0..1000).each do |i|
	if FizzBuzz(i,5) && FizzBuzz(i,3) && FizzBuzz(i,7)
		puts "FizzBuzzPum"
	elsif FizzBuzz(i,5) && FizzBuzz(i,3)
		puts "FizzBuzz"
	elsif FizzBuzz(i,5) && FizzBuzz(i,7)
		puts "BuzzPum"
	elsif FizzBuzz(i,3) && FizzBuzz(i,7)
		puts "FizzPum"
	elsif FizzBuzz(i,5)
		puts "Buzz"
	elsif FizzBuzz(i,3)
		puts "Fizz"
	elsif FizzBuzz(i,7)
		puts "Pum"
	else
		puts i 
	end
end		
=end

