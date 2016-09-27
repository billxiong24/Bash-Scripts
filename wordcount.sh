#!/bin/bash
#counts number of each word in a file, and sorts them in descending order
[[ $# -lt 1 ]] && { echo "Not enough arguments."; exit 1; }

# -nr is reversed numerical 
sed -e 's/\.//g'  -e 's/\,//g' -e 's/ /\
/g' "$1" | tr 'A-Z' 'a-z' | sort | uniq -c | sort -nr
