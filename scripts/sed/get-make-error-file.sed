#! /bin/sed

# get the full path to the file on which make reports an error.
# assumes one recursive call to make is made and the error occurs on the
# recursive invocation

# skip lines that don't start with make
/^make/! b

# grab the filename from this line and move it to the hold space
/Error 1/ {s:.*\[\(.*\)\].*:/\1:; h;}

# grab the path name from this line, append the filename, remove eol chars
/Error 2/ {s:.*\[\(.*\)\].*:\1:; G; s:[\n\r]\+::gp;}
