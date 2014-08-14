<?php

#This is our subroutine at the beggining of script
function check_length($value) {
	if (strlen($value) > 30) {			#is $length greater than (gt) 30?
		print "You didn't follow the rules, enter a line that is less than 30 characters:\n";
		return "FAIL";
	} else {
		return;
	}
}

echo "Welcome to our example PHP script\n";
echo "please enter your file name: ";
$filename = chop(fgets(STDIN));		#Get input, chop like chomp in perl

$FILE = fopen ($filename,"r");		#Open filehandle in readmode

$lines = 0;					#init var to 0
$line_length = array();		#declare our array
$last = '';					#init our variable for the last line				
while (($buffer = fgets($FILE, 4096)) !== false) {	#while there is still a line in the file
	$last = $buffer;								#put that line in $last variable
	$line_length[$lines] = strlen($buffer);			#note the amount of characters to our array
	$lines++;										#increment line count
}
fclose($FILE);										#politely close filehandle

echo "Our last line was: $last\n";		#Give feedback of what the last line was

$i = 0;					#loop iterator init
$total_chars = 0;		#set total characters to 0
while ($lines > $i) {	#While we still have lines
	$total_chars += $line_length[$i];	#tally up the total amount of chars so far
	$i = $i + 1;		#next iteration
}

#Give some file stats
echo "The file had $lines lines and $total_chars total characters\n";

echo "Enter another line that is less than 30 characters:\n";
$another_line = chop(fgets(STDIN));					#get the line
while (check_length($another_line) == "FAIL") {		#keep checking that it is < 30 chars
	$another_line = chop(fgets(STDIN));
}

$FILE = fopen ($filename,"a");		#re-open file in append mode
fwrite($FILE, "$another_line\n");	#add the line to text file (with newline)
fclose($FILE);						#close filehandle
?>
