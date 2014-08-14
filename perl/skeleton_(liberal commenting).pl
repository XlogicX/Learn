#!/usr/bin/perl

=pod

this starts our multiline comment of what this script does
This script is a barebones perl script that uses many of the most common perl
features as a reference to how they can be used for any other basic perl script.

We go through printing, taking input, some basic math, variables, arrays, 
logic/comparisons, loops, subroutines, and handling files. These are enough 
basics to get most people started in the right direction. Next steps of learing
would be perl regular expressions, reading a perl book, and asking every question
to google with site:stackoverflow.com added to it

What this script does:
asks for a filename (a text file that should exist in the same directory as this
script), opens the file and notes the last line, how many lines there are, and
stores each line in an array. We then go through a loop to discover how many total
characters were in the file. The script then reports on some of these stats. Finally,
The script asks us for another line (that has to be less than 30 characters) and
adds this line back to our text file.

Although this script may look like a longish intimidating perl script, without comments
it is only really 44 lines of code, which isn't bad for a script that does a little
bit of everything.

=cut

#Below is how you use perl modules, in this case we used "warnings" and "strict."
#We Don't even need these ones, they mostly just harass you when you are coding
#Wrong. And if you haven't noticed, lines that start with a # are not interpreted
#as code, except for line 1,  that is a unixy thing.
use warnings;
use strict;

#Consider the below our, "hello world". the \n is a way to tell the script
#to go to the next line.
print "Welcome to our example perl script\n";

#Just another print statement prompting for an input
print "please enter your file name: ";
#There's a few things going on here. Things that start with the $ are variables.
#Before using a variable, you have to declare it; you do this with the word "my"
#in front of it. You can assign text, numbers, and all things to a variable; the
#variable will "contain" these values. In the case below, <STDIN> is a specail
#way of saying "whatever the user types in, until they hit enter";
my $filename = <STDIN>;
#Chomp is a cool function that removes the "enter" from a variable. Otherwise,
#if I printed $filename out to the screen, it would also have the side-effect
#of going to the next line
chomp($filename);

#We get to try and open the filename that the user typed in. These are called
#"FileHandles". We are using "open" to make a filehandle called FILE. You then
#specify the file name in quotes, you could literally type a path in, but in
#this case we are using a variable. If it doesn't exist, the command follows the
#path in our "or" statement and quits the program with a useful error message.
open FILE, "$filename" or die "Couldn't open $filename, $!\n";
my $last_line; 		#we can use underscores in variable names
my $line_count = 0;	#We are putting the value of 0 in our variable named $line_count
#This is an array, it's like a variable, but it can hold multiple values. You treat
#just like a variable, but you also tell it which value. $line_length[0] = "whatever";,
#$line_length[1] = "a different value";, $line_length[2] = 4;...those are all valid
#statements. Note that arrays are declared with "@", but used with "$" if only
#refering to one value/element
my @line_length;
my $i = 0;				#We will use this variable to note how many times we have "while'd"
while (<FILE>) {		#While there are still lines in the file
	#Overwrite what is in $last_line with our current line. $_ is a special variable that
	#contains the current value of the thing being looped.
	$last_line = $_;	
	$line_count = $line_count + 1; #adds 1 to our variable. $line_count++; is a quicker way
	#Ok, this next line looks like a mouthfull. Lets start at the right. $_ is still our
	#current line in the file we are on. We are calculating its length (in characters). We
	#are next assigning this value to our $line_length array, the slot we put it in is within
	#the []'s; which happens to be whichever number $i currently has. Remember that $i gets
	#one value larger each time we go through this loop
	$line_length[$i] = length($_);
	$i++;				#Increment the $i variable by 1
}						#Go to the next line in our file
#$last_line will have the side-effect of containing the last line in the file
close FILE;		#Now we will close our read-only version of the filehandle

#Tell the user how many lines were in the file and what the last line of the file was
print "There were $line_count lines in our file\n";
print "Our last line was:\n$last_line\n";

#We are now about to count how many lines of text are in the whole file
#in a unconventional way. But it is an example of how to loop through a whole array
$i = 0;		#reset $i (our iterator) back to 0
#below is an obscure perl hack. when assigning an @array to a $variable, the number
#of elements of the array is what is actually stored in the $variable. So if an
#array had 7 values, $lines would contain '7' after the below command
my $lines = $line_count;
my $total_chars = 0;		#total characters in whole file
#a foreach loop would be much more appriopriate, but this method is just more
#exposure to some fundamentals
while ($lines > $i) {		#while the amount of lines is still greater than times looped
	#take the nth ($i) value of $line_length and add it to our total chars
	$total_chars += $line_length[$i];
	$i++;
}

#This command could have been more sane, but it shows how you can peice together
#multiple components into one print statement with the . character. It is called
#concatenating.
print "The file had " . $lines . " lines and " . $total_chars . " total " . "characters\n";

#Prompt user to enter a line of text
print "Enter another line that is less than 30 characters:\n";
my $line = <STDIN>;		#Take the user input
#Below is a function that we created called check_length. We pass this function the
#variable that the user just typed in. The function checks to make sure that the
#user didn't type more than 30 characters.
check_length($line);

#We are opening our file back up for writing to. It is almost the same command, but
#you put 1 or 2 >'s before the filename. 1 > will overwrite the file, and >> will
#append to the file; below we are choosing to add to the file (append)
open FILE, ">>$filename" or die "Couldn't open $filename, $!\n";
#normally print goes to stdout be default (your screen). We are now specifing to
#print to the file, and we adding the user supplied line to the file
print FILE $line;
close FILE;	#close it back up

#This is the actual subroutine/function that checks to see if a variable is more than
#30 characters long
sub check_length {					#We declare the subroutine with the "sub" keyword
	my $value = shift;				#the "shift" word gets us the value passed to the subroutine
	my $length = length($value);	#the length() function computes the length of a variable
	if ($length gt 30) {			#is $length greater than (gt) 30?
		print "You didn't follow the rules, enter a line that is less than 30 characters:\n";
		$line = <STDIN>;			#Ask for a different input
		check_length($line);		#OMG recursion
	} else {
		#No need to do anything else, but any code that you wanted to execute in the case that
		#the length is not gt that 30 could go here, but we want the length to be less than 30
		#...for some reason
	}
}

#Now do something totally stupid
my $x="02345678cf";my @y;my ($a,$b)=('','');
if ($x=~/(\d{8}\w{2})|Really?\d+|a..{4}$/) {@y=split(//,$1);
$a=$y[5].$y[8];$a=$a.$a;$a=$y[3].$y[7].$y[5].$y[4].$a.$y[5].$y[9].$y[1]
.$y[0].$y[4].$y[6].$y[5].$y[9].$y[6].$y[1].$a.$y[5].$y[3].$y[2].$y[9];}
while ($a=~/^(.)(.)/){$b.=pack("C*",map{$_?hex($_):()}$1.$2);$a=~s/^..//;}
print "$b\n";
