#!/usr/bin/lua

--This is our subroutine at the beggining of script
function check_length(value)
	if string.len(value) > 30 then	--if the string was bigger than 30 chars, FAIL
		print("You didn't follow the rules, enter a line that is less than 30 characters:\n")
		return "FAIL"
	end
end

print("Welcome to our example Lua script")
print("please enter your file name: ")
local filename = io.read()  --read user input for filename

local FILE = (io.open(filename, "r"))	--Open a filehandle
local line_amount = 0					--init variable for amount of lines
local line_length = {}					--init an array for length of each line
local last								--will contain our last line
while true do							--infinite while loop
	local line = FILE:read("*line")		--read current line of file
	if not line then break end			--exit loop if no more lines
	last = line 						--note the current line (last loop will have last line)
	line_length[line_amount] = string.len(line)	--comput length of current line and store to array
	line_amount = line_amount + 1		--Note the increase of lines/loops
end
FILE:close()	--close our filehandle

print("Our last line was\n" .. last)	--display what our last line was

local i = 0					--loop iterator init
local total_chars = 0		--set total characters to 0
while line_amount > i do	--while we still have lines to process
	total_chars = total_chars + line_length[i]	--tally the total characters from line
	i = i + 1				--increment loop counter
end

--print off some general statisics on file
print("The file had " .. line_amount .. " lines and " .. total_chars .. " total characters\n")

print("Enter another line that is less than 30 characters:\n") --prompt for another line
local another_line = io.read()		--see if it is more than 30 characters
while check_length(another_line) == "FAIL" do	--keep checking that it is < 30 chars
	another_line = io.read()		--see if it is more than 30 characters
end

local FILE = (io.open(filename, "a"))	--re-open file in append mode
FILE:write(another_line .. "\n")		--write to file
