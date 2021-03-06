
=begin
require("/home/ivan/Documentos/ProgramaGeneration/Week 7/onlineExercices/rubyExercise6/subtitles.rb")
readSub("/home/ivan/Documentos/ProgramaGeneration/Week 7/onlineExercices/rubyExercise6/gotSub.srt",2500)
=end

# -----Part 1------

=begin
inputfile: string --> route of the input file
shift: int --> shift in milisecons (positive or negative)
=end
def shiftSub(inputFile, shift)
	shift = shift /1000.0
	text = File.open(inputFile).read
	puts "Please, write the name of the new subtitles..."
	newName = gets.chomp + ".srt"
	newFile = File.new(newName,"w")
	text.each_line do |line|
		if line[2] == ":" && line[5] == ":"
			#puts line
			subSeconds1 = [line[(0..1)].to_f*3600, line[(3..4)].to_f*60, (line[(6..11)].gsub(",",".")).to_f].reduce(:+)	+ shift		
			subSeconds2 = [line[(17..18)].to_f*3600, line[(20..21)].to_f*60, (line[(23..28)].gsub(",",".")).to_f].reduce(:+) + shift

			subSeconds1 = [(subSeconds1/3600).to_i, ((subSeconds1/3600 - (subSeconds1/3600).to_i)*60).to_i, ((((subSeconds1/3600 - (subSeconds1/3600).to_i)*60)-((subSeconds1/3600 - (subSeconds1/3600).to_i)*60).to_i)*60).round(3)]
			subSeconds2 = [(subSeconds2/3600).to_i, ((subSeconds2/3600 - (subSeconds2/3600).to_i)*60).to_i, ((((subSeconds2/3600 - (subSeconds2/3600).to_i)*60)-((subSeconds2/3600 - (subSeconds2/3600).to_i)*60).to_i)*60).round(3)]
			
			line[(0..1)] = toStr(subSeconds1[0],2)
			line[(3..4)] = toStr(subSeconds1[1],2)
			line[(6..11)] = toStr(subSeconds1[2],6).gsub(".",",")

			line[(17..18)] = toStr(subSeconds2[0],2)
			line[(20..21)] = toStr(subSeconds2[1],2)
			line[(23..28)] = toStr(subSeconds2[2],6).gsub(".",",")
			#puts line
			newFile.puts(line)
		else
			newFile.puts(line)
		end
	end
	newFile.close
	puts newName + " created at " + Time.now.to_s
	return nil
end

=begin 
toStr function --> Transform a number to string and adds a 0 at the begining of the string if the string is shorter than leng
n: int --> number to add 0
leng: int --> suposed length to the string
=end
def toStr(n, leng)
	n = n.to_s
	if (n.to_f.to_i.to_s.length < 2) 
		n = "0" + n
	end
	while n.length < leng do
		n = n + "0"
	end
	return n
end





# -----Part 2------

def writeTypos(inputFile)
	puts "Processing... Please, wait..."
	pt = potentialTypos(inputFile)
	puts "Please, enter the name of the new SRT file..."
	newName = gets.chomp + ".srt"
	newFile = File.new(newName,"w")
	for i in pt.keys
		newLine = ""
		pt[i].each do |add|
			newLine += add + " , "
		end
		newFile.puts(i + ": " + newLine)
	end
	newFile.close
	puts newName +  "created at: " + Time.now.to_s
end


def potentialTypos(inputFile)
	text = File.open(inputFile).read
	arrWords = unixWords("/usr/share/dict/words")
	counter = 0
	prevLine=""
	potTypos={}
	text.each_line do |line|
		counter += 1
		if line == "\r\n"
			counter = 0
		end
		#puts counter
		#puts line
		if counter == 2
			prevLine = line
		end
		if counter > 2
			#/\W|\d/ regular expresion to exclude non digit and non letter
			words = line.split(/\W|\d/)
			for i in words
				if !(arrWords.include? i.downcase) && i != ""
					if potTypos.include? i
						potTypos[i].push(prevLine[(0..11)])
					else
						potTypos[i]=[prevLine[(0..11)]]
					end
				end
			end
		end
	end
	return potTypos
end

def unixWords(inputFile)
	text = File.open(inputFile).read
	words = []
	text.each_line do |line|
		words.push(line.gsub("\n",""))
	end
	return words
end


# -----Part 3------


def profanity(inputFile)
	puts "Please, enter the name of the censored file..."
	newName = gets.chomp + ".srt"
	newFile = File.new(newName, "w")
	text = File.open(inputFile).read
	arrWords = bannedWords("./swearWords.txt")
	counter = 0
	protect = true
	text.each_line do |line|
		counter += 1
		if line == "\r\n"
			counter = 0
		end
		if counter == 2  && line[(3..4)].to_i >= 30 && line[(20..21)].to_i >= 30
			#if its protected time
			protect = false
		end
		if counter > 2 && protect == true
			#/\W|\d/ regular expresion to exclude non digit and non letter
			words = line.split(/\W|\d/)
			for i in words
				if arrWords.include?(i.downcase) && i != ""
					line = line.gsub(i, "CENSORED")
				end
			end
		end
		newFile.puts(line)
	end
	newFile.close
	puts newName + " created at: " + Time.now.to_s
	return nil
end


def bannedWords(inputFile)
	text = File.open(inputFile).read
	words = []
	text.each_line do |line|
		words.push(line.gsub("\r\n",""))
	end
	return words
end


