#!/usr/bin/ruby

#Shows how to test if a string matches a regular expression (yes/no) and uses more than one modifier
if /^\w+.+string/si.match('A Simple String To Test')
	puts "Match"
else puts "Did Not Match" end

#Splitting with a regular expression
scalar_list = "item 1,     item 2, item 3"		#A text string delimitted by comma and variable whitespace
items = scalar_list.split(/,\s+/)				#Splitting this up into an array called items
puts "%s:%s" % [items[1], items[0]]				#printing a couple of the elements

#Extraction/parsing
parse_this = "Text with some digits: 1234 and some hexidecimal deadbeef1337"
extracted = /[^\d]+(\d+).+\s([0-9a-f]+)$/.match(parse_this)		#Our regex; groups we want in ()'s
puts "Number: %s Hex: %s" % [extracted.captures[0], extracted.captures[1]]		#display both extracted groups

#Find and Replace with regex
wrong_name = "Mark decided to write in the hypertext markup language"	#our string
wrong_name = wrong_name.gsub(/mark/i, "Greg")	#changing all instances of "Mark" with "Greg" with no case-sensitivity
puts wrong_name									#lulz at hypertext gregup language
