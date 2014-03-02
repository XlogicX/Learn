#!/usr/bin/perl
use warnings;
use strict;

print "Welcom to our example perl script\n";

print "please enter your file name: ";
my $filename = <STDIN>;		#Perl way to get input
chomp($filename);			#This strips the "enter-key" part of input

#Opens a filehandle that user gave
open FILE, "$filename" or die "Couldn't open $filename, $!\n";

my $last_line; 			#init var for last line of text file
my $line_count = 0;		#Our var for counting lines
my @line_length;		#An array that stores # of characters per line
my $i = 0;				#generic loop iterator (set to 0)
while (<FILE>) {		#While there is still a line in the file
	$last_line = $_;				#set $last line to our current line
	$line_count = $line_count + 1;	#Iterate our line count (maths)
	$line_length[$i] = length($_);	#add the length of this line to our array
	$i++;							#increment loop
}
close FILE;							#close the filehandle

#give user some useless statistics on file
print "There were $line_count lines in our file\n";
print "Our last line was:\n$last_line\n";

#Count the total characters
$i = 0;									#init loop counter to 0
my $lines = @line_length;				#get the number of lines
my $total_chars = 0;					#init the total character counter
while ($lines gt $i) {					#while we still have lines
	$total_chars += $line_length[$i];	#tally the total characters
	$i++;								#Next line
}

#print more stats, mostly to show variable interpolation
print "The file had " . $lines . " lines and " . $total_chars . " total " . "characters\n";

print "Enter another line that is less than 30 characters:\n";
my $line = <STDIN>;
check_length($line);	#demonstarte a subroutine

#open file back up in append mode and write the user submitted line to it
open FILE, ">>$filename" or die "Couldn't open $filename, $!\n";
print FILE $line;
close FILE;

#This subroutine makes sure that the value is less then 30 chars
sub check_length {
	my $value = shift;			#gets the value passed to it in $value
	my $length = length($value);#get character lenght in $length
	if ($length gt 30) {			#is $length greater than (gt) 30?
		print "You didn't follow the rules, enter a line that is less than 30 characters:\n";
		$line = <STDIN>;			#Ask for a different input
		check_length($line);		#OMG recursion
	} else {

	}
}

#Now do something totally stupid
my $x="02345678cf";my @y;my ($a,$b)=('','');
if ($x=~/(\d{8}\w{2})|Really?\d+|a..{4}$/) {@y=split(//,$1);
$a=$y[5].$y[8];$a=$a.$a;$a=$y[3].$y[7].$y[5].$y[4].$a.$y[5].$y[9].$y[1]
.$y[0].$y[4].$y[6].$y[5].$y[9].$y[6].$y[1].$a.$y[5].$y[3].$y[2].$y[9];}
while ($a=~/^(.)(.)/){$b.=pack("C*",map{$_?hex($_):()}$1.$2);$a=~s/^..//;}
print "$b\n";
