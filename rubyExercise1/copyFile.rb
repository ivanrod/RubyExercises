puts "What is the source file?"
inputFile = gets.chomp
file_contents = IO.read(inputFile)

puts "What is the destination file?"
outputFile = gets.chomp
IO.write(outputFile, file_contents)