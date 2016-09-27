#!/bin/bash

#commandline arg later
subreddit="showerthoughts"
wget -O r.html www.reddit.com/r/${subreddit}/.rss
#USE NON-GREEDY MATCH- STOPS AFTER FIRST OCCURANCE. P is perl syntax, to enable nongreedy (?)
grep -oP '<title>.*?</title>' r.html | cut -f2 -d '>' | cut -f1 -d '<' > subreddit.txt
#replace &quot: with \"
sed -i 's/&quot;/\"/g' subreddit.txt
cat subreddit.txt
