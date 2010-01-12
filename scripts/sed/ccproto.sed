#! /bin/sed

# keep track of scope
/\s*\(public\|\protected\|private\):\s*$/ p

/.*(.*).*;.*$/ p
