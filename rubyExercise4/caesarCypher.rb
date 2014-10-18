=begin
message: string
shift: int
=end
def caesar(message, shift)
	newMessage = ""
	for i in (0..message.length)
		if (65 < message[i].ord < 90) && ( 97 < message[i].ord < 122 ) 
			newNum = message[i].ord + shift
		end
		newMessage = newMessage + newNum.chr
	end
	return newMessage
end