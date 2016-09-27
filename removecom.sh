#!/bin/bash
#for c syntax-like comments 
#Arguments- $1: file to remove comments from
#           $2: destination file to put code with no comments    
#Comments must be on separate lines from code. (Will try to fix later)

#error checking
[[ "$#" -lt 2 ]] && { echo "Not enough arguments."; exit 1; }

file="$1"
#if only 1 argument, set destination file to 1st argument
dest_file="$2"

if [ -z $file ]; then
    echo "Invalid file input. Exiting..."
    exit 1
fi
#If file exists, prompt, overwrite if yes

if [ -d $dest_file ]; then
    echo -n "File exists. Override? (y/n)"
    read response
    if [[ "$response" -eq "yes" || "$response" -eq "y" || response -eq "" ]]; then
        echo "" > $dest_file
    else
        echo "File not overwritten. Exiting..."
        exit 1
    fi
fi

function multi_line()
    while read line; do
        #check for /* part of the comment
        first="/\*.*"
        #checks for */ part of the comment
        last=".*\*/"
        test1=$(echo "$line" | grep "$first")
        test2=$(echo "$line" | grep "$last")

        #if we found a match of /*
        if [ ! -z "$test1" ]; then
            #keep going until we find a */
            while [ -z "$test2" ]; do
                read line
                test2=$(echo "$line" | grep "$last")
            done
            read line
        fi
        echo "$line" >> $2
    done < $1
    exit 0
}

function script_syntax(){
    egrep -v "^ \+[#]|#" $1
}
function remove_com(){
    sed 's/\/\/.*//;s/\/\*.*\*\///' $1 > temp 
    multi_line temp $2
    rm temp
}
extension=${file##*.}
#check extension and execute corresponding function
if [[ "$extension" -eq "c" || $extension -eq "java" || $extension -eq "cpp" ]]; then
    remove_com $file $dest_file    
elif [[ "$extension" -eq "py" || "$extension" -eq "py" ]]; then
    script_syntax $file
else
    echo "Language not supported."; exit 1
fi
