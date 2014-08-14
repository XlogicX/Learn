#!/usr/bin/bash

#This is our subroutine/function at the beggining of the script
check_length () {
	value=$1						#$1 is the parameter
	value_length=${#value}			#Get the length of the string
	if [ $value_length -gt 30 ]		#if its longer than 30 chars
	then
		valid="no"					#report back that it's not valid
	else
		valid="yes"					#otherwise it is
	fi
}

echo "Welcome to our example bash script"
echo "please enter your file name: "
read filename						#Get input

line_amount=0				#init var to 0
while read -r line 			#for each line in our file
do
    last=$line 							#note tue current line (will be last line in last iteration)
    line_length[line_amount]=${#line} 	#put the amount of characters of line into array of line lengths
    line_amount=`expr $line_amount + 1` #increment the line amount
done < "$filename" 						#specify the input file

i=0								#init loop iterator
total_chars=0					#set total chars to 0
while [ $line_amount -gt $i ] 	#while we still have lines
do
	total_chars=`expr $total_chars + ${line_length[$i]}` #tally up the total amount of chars so far
	i=`expr $i + 1` 	#Next iteration
done

#Print off some statistics
echo "There were $line_amount lines in the file and the last line was"
echo "\"$last\""
echo "The total amount of characters was $total_chars"

echo "Enter another line that is less than 30 characters: "
read another_line				#Get the line
check_length $another_line 		#use function to see if it is less/more than 30 chars
while [ $valid == "no" ] 		#if it's more than 30 chars
do
	echo "You didn't follow the rules, enter another line that is less than 30 characters: "
	read another_line 			#prompt again
	check_length $another_line
done

echo $another_line >> $filename #append new line back to the end of our file
