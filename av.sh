#!/bin/bash

#run using ./ph.sh or bash ph.sh separated by search term. Search term does not have to be in quotes.
#Example: ./ph.sh Remy Lacroix and Jada Stevens
#No argument just opens the 4 sites
if [ "$#" -eq 0 ]; then
    google-chrome --incognito "pornhub.com" "spankbang.com" "xvideos.com" "tube8.com"
    exit 0
fi
args=$@
search_term=${args[@]}

urlbases=( "http://www.pornhub.com/video/search?search=" "http://www.spankbang.com/s/" "http://www.xvideos.com/?k=" "http://www.tube8.com/searches.html?q=" )
#account for spaces
search_term=${search_term//" "/"+"}

for (( i=0; i < ${#urlbases[@]}; i++ )); do
urlbases[$i]=${urlbases[$i]}$search_term
done
#opens 4 incognito tabs with aforementioned websites. Enjoy! :D
google-chrome --incognito ${urlbases[@]}