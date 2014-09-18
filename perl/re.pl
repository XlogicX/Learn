#/usr/bin/perl

#Shows how to test if a string matches a regular expression (yes/no) and uses more than one modifier
if ("A Simple String To Test" =~ /^\w+.+string/si) {	#See if a string matches regular expression
	print "Matched\n";
} else { print "Did Not Match\n";}


#Splitting with a regular expression
my $scalar_list = "item 1,     item 2, item 3";	#A text string delimitted by comma and variable whitespace
my @items = split(/,\s+/, $scalar_list);		#Splitting this up into an array called items
print "$items[1]:$items[0]\n";					#printing a couple of the elements


#Extraction/parsing
my $parse_this = "Text with some digits: 1234 and some hexidecimal deadbeef1337";
if ($parse_this =~ /[^\d]+(\d+).+\s([0-9a-f]+)$/) {		#Our regex; groups we want in ()'s
	print "Number: $1 Hex: $2\n";						#display both extracted groups
}

#Find and Replace with regex
my $wrong_name = "Mark decided to write in the hypertext markup language";	#our string
$wrong_name =~ s/mark/Greg/gi;		#changing all instances of "Mark" with "Greg" with no case-sensitivity
print "$wrong_name\n";				#lulz at hypertext gregup language
