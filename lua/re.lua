#!/usr/bin/lua

--This split function is from a Well House Consultants training course, 
--code found at http://www.wellho.net/resources/ex.php4?item=u108/split
--This is preferable to using a non-core library/module
function string:split(delimiter)
  local result = { }
  local from = 1
  local delim_from, delim_to = string.find( self, delimiter, from )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
    from = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from )
  end
  table.insert( result, string.sub( self, from ) )
  return result
end

--Shows how to test if a string matches a regular expression (yes/no)
if string.match("A Simple String To Test", "^%w+.+String") then
	print("Match")
else
	print("Did Not Match")
end

--Splitting with a regular expression, split function used has arrays starting at '1' index; not '0'
scalar_list = "item 1,     item 2, item 3"		--A text string delimitted by comma and variable whitespace
items = scalar_list.split(scalar_list,",%s+")	--Splitting this up into an array called items
print(items[2] .. ":" .. items[1])				--printing a couple of the elements

--Extraction/parsing
local parse_this = "Text with some digits: 1234 and some hexidecimal deadbeef1337"	--our string
local parsed = {}																	--declare the array
parsed[0], parsed[1] = string.match(parse_this, "[^%d]+(%d+).+%s([0-9a-f]+)") 		--peices go into array
print("Number: " .. parsed[0] .. " Hex: " .. parsed[1])								--print the formatted elements

--Find and Replace with regex
local wrong_name = "Mark decided to write in the hypertext Markup language"	--our string
wrong_name = string.gsub(wrong_name, 'Mark', "Greg")	--changing all instances of "Mark" with "Greg" with no case-sensitivity
print(wrong_name)		--lulz at hypertext gregup language
