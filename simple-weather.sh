#!/bin/bash
#Remove head -1 for all locations given by accuweather
#FILE=/home/billxiong24/weather.html
URL="http://www.accuweather.com/en/us/raleigh-nc/27601/weather-forecast/329823"
wget -q -O weather.html "$URL"

curr_temp=$(cat weather.html | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $10"°"}' | head -1)
echo "Curr temp: "$curr_temp
cond=$(cat weather.html | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $13}' | head -1 | cut -f 2 -d '"')
 
echo "Conditions: "$cond
feel_temp=$(cat weather.html | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $12"°"}' | head -1)
echo "Feels like: "$feel_temp
LOC=$(grep -o 'acm_RecentLocationsCarousel.push({name:.* d' weather.html | head -1 | grep -o '".*"' | tr -d '"')

today=$(grep -A 5 -m 2 "Today" weather.html | tail -n1 | sed 's/<[^>]\+>//g' | sed 's/^ *//' | grep -o '.*&' | tr -d '&')


[[ -z "$today" ]] && echo "Later Today: N/A" || echo "Later Today: $today°"

#cat /home/billxiong24/weather.html | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $10}' | head -1
tonight=$(grep -A 5 'Tonight' weather.html | sed 's/<[^>]\+>//g' | sed 's/^ *//' | grep -o '.*&' | tr -d '&')

tonight_show=${tonight/" Lo"/":"}
tonight_show=${tonight_show/" Hi"/":"}

LOW=$(echo $tonight_show | grep -o '[0-9]*')
echo "Tonight: $tonight_show°" 
