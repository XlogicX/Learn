#/usr/bin/python

#This is our subroutine at the beggining of script
def check_length( value ):
	length = len(value)		#pythons length function
	if (length > 30):		#comparison
		print "You didn't follow the rules, enter a line that is less than 30 characters:\n"
		return "FAIL"
	else:
		return

print "Welcome to our example python script"
print "please enter your file name: "
filename = raw_input()		#Get input

txtfile = open(filename)	#Open filehandle in readmode (default)

line_amount = 0		#init var to 0
line_length=[]		#declare our array (list)
for line in txtfile:	#for every line in our text file
	last = line 		#note the current line; it will be the last line when finished
	line_length.append(len(last))	#create new array/list element for # of characters of current line
	line_amount += 1 #becuase you really can't do ++ in python?

print "Our last line was:\n%s\n" % (last)	#Give feedback of what the last line was

txtfile.close()		#Close the filehandle in the "read" context

i = 0					#loop iterator init
total_chars = 0			#set total characters to 0
while (line_amount > i):	#While we still have lines
	total_chars += line_length[i]	#tally up the total amount of chars so far
	i += 1			#next iteration

#Give som file stats
print "The file had %s lines and %s total characters\n" % (line_amount,total_chars)

print "Enter another line that is less than 30 characters:\n"
another_line = raw_input()						#get the line
while (check_length(another_line) == "FAIL"):	#keep checking that it is < 30 chars
	another_line = raw_input()

txtfile = open(filename, "a")			#re-open file in append mode
txtfile.write(another_line + "\n");		#add the line to text file (with newline)
txtfile.close()							#close filehandle
