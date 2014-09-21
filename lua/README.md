Environment
=====
OS: Linux

Editor: SublimeText

Interpreter: lua

Execution: lua skeleton.lua

Regular Expressions (Meat)
=====
General Goals to make use of Regular Expressions

* How to show whether an expression matches (or not) a string
* Use multiple modifiers for one regex (case insensitive, multiline, etc...)
* Show how to split a string into an array with a regex defined delimiter
* Show how to parse/capture individual pieces of a string using regex
* Show how to do a Find-and-Replace using regex

The goal of this is not to teach how to do regular expressions in general; the goals are to support the implementation of regular expression in the language you choose to use. In other words "I know how regex works, but what is the syntax this language uses for a regex 'split'"

Some notes on regular expressions/patterns in Lua:
They aren't full pcre, either deal with Lua's regex limitations or use external libraries. This example code goes with the former (for the sake of self sufficiency). There is no built-in split function, a simple split subroutine provided in this example. Find-and-Replace uses a gsub method, though it supports regex. Regex syntax is slightly different; there is no \w, instead it would be %w. Extraction/parsing is done more explicitly with an array. I'm expecting there may be more awkward regex lua-isms, but have yet to discover them.

The Regular Expression example script is called re.lua
