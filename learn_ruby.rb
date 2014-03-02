#!/usr/bin/ruby

#Define our subroutine for checking line length (in characters)
def check_length value
	if value.length > 30
		puts "You didn't follow the rules, enter a line that is less than 30 characters:\n"
		return "FAIL"
	else
		return
	end
end

puts "Welcome to our example ruby script\n"
puts "please enter your file name: ";
filename = gets.chomp						#Get input from user
puts "The filename is %s" % filename		#This is variable interpolation

file = File.open(filename, "r")		#how to read a file
last_line = ""						#init the variable
line_count = 0						#init linecount to 0
line_length = Array.new				#how to init an array
file.each_line do |line|			#go through each line, will be stored in var "line"
	last_line = line 						#note the current line in last_line
	line_length[line_count] = line.length 	#count chars and put it in our array
	line_count = line_count + 1 			#Iterate the line counter
end
file.close									#close our file up

puts "The last line was %s" % last_line		#report what the last line was

i = 0								#set loop iterator
total_chars = 0						#init total characters to 0
while line_count > i  do			#while we still have lines
	total_chars += line_length[i]	#tally up the character count
	i += 1 						    #next
end

puts "The file had %s lines and %s total characters\n" % [line_count, total_chars] #stats

puts "Enter another line that is less than 30 characters:\n"
next_line = gets.chomp				#get input from user
check_length (next_line)			#user our subroutine to check length
while check_length (next_line) == "FAIL"	#keep checking that it is < 30 chars
	next_line = gets.chomp
end

file = File.open(filename, "a") 	#"a" for append
	file.write(next_line + "\n")	#write user submitted line to file
file.close
