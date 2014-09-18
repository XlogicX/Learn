#/usr/bin/python
import re

#Shows how to test if a string matches a regular expression (yes/no) and uses more than one modifier
expression = re.compile(r"^\w+.+string", re.I | re.S)	#compile the expression
if expression.match("A Simple String To Test"):		#See if a string matches it
	print "Matched"
else:
	print "Did Not Match"

#Splitting with a regular expression
scalar_list = "item 1,     item 2, item 3"	#A text string delimitted by comma and variable whitespace
items = re.split(",\s+", scalar_list) 		#Splitting this up into an array called items
print items[1] + ":" + items[0]				#printing a couple of the elements

#Extraction/parsing
parse_this = "Text with some digits: 1234 and some hexidecimal deadbeef1337"
extractions = re.compile(r"[^\d]+(\d+).+\s([0-9a-f]+)$")		#Our regex; groups we want in ()'s
peices = extractions.match(parse_this)							#exec our re and result in peices
print "Number: " + peices.group(1) + " Hex:" + peices.group(2)	#display both extracted groups
