#include <stdio.h>	//of course
#include <stdlib.h>	//to use exit (1)
#include <string.h> //mostly for strlen function
FILE * textfile;	//This is our file handle called textfile

char user_line[100];	//becuase I didn't pass by refernece...

main() {
	printf("Welcome to our example C program\n");
	printf("please enter your file name: ");

	char filename[50];			//filename length no larger than 50 chars
	gets(filename);				//Get the user provided file name	

	int chars;				//var for how many characters in each line
	int total_chars = 0;	//var for how many characters in whole file
	int lines = 0;			//a count for how many lines are in the file
	char last_line[100];	//a string containing the last line in the file

	textfile = fopen(filename, "r");		//open file in readmode
	if(!textfile) {
		printf("Your file doesn't exist, are we even real?\n");
		exit (1);
	}

	char line[100];						//holds a line of text from textfile
	while (!feof(textfile)) {			//while we are not at the end of the file
		fgets(line, 100, textfile);		//get up to 100 characters of current line of text file into line array
		if (!feof(textfile)) {			//if not on the last line
			chars = strlen(line) - 1;	//count the characters minus the \n
			total_chars += chars;		//tally it to our total
			lines++;					//increment our line count
			strcpy(last_line, line);	//copy our current line to the last_line string
		}
	}
	fclose (textfile);		//close the file for now

	//output some stats on the file
	printf("Our last line was %s", last_line);
	printf("The file had %d lines and %d total characters.\n\n", lines, total_chars);

	printf("Enter another line that is less than 30 characters:\n");
	gets(user_line);			//get the user input
	checklength(user_line);		//run our function to check the length of the line

	textfile = fopen(filename, "a");	//open file in append mode
	fprintf(textfile, "%s\n", user_line);		//append the user provided line to the file
	fclose (textfile);							//and close the file
}

checklength (char line[100]) {
	if (strlen(line) > 30) {	//check to see if line is greater than 30
		printf("You didn't follow the rules, enter a line that is less than 30 characters:\n");
		gets(user_line);			//get the user provided line again
		checklength(user_line);		//check again, OMG recursion
	}
}
