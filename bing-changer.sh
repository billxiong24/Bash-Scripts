#!/bin/bash
################# SCRIPT TO SET DESKTOP PICTURE TO BING BACKGROUND PICTURE #####################
#cron uses limited env, have to export specific env variable.
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

#piece together the URL 
bing=http://www.bing.com
day="&idx=0"
number="&n=1"
market="&mkt=en-US"
resolution="_1920x1080"
extension=".jpg"

#get the xml file with this url + wget
xmlURL=$bing"/HPImageArchive.aspx?format=xml"$day$number$market
wget -q -O "/home/billxiong24/xml_file" $xmlURL


#need to extract link between urlbase tags in the xml file
#-o means only print what is matched. cut -d "d" means use "d" as the delimiter, and -f
#specifies which part of the cut you want. -f1 is the  first part, -f2 is the second part, etc.
xml_urlbase=$(cat /home/billxiong24/xml_file | grep -o "<url.ase>.*</url.ase>" | cut -d ">" -f2 | cut -d "<" -f1)

#customize resolution, otherwise you can just extract link between url tags instead of urlbase
xml_url=$xml_urlbase$resolution$extension
#complete image url that you can download using wget
pic_url=$bing$xml_url

echo $pic_url is the url to be downloaded


cd /home/billxiong24/Pictures
#use date to ensure unique file name
filename=$(date +%Y-%m-%d)-bing.jpg

cd /home/billxiong24
#Download URL into Pictures folder 
wget -q -O "/home/billxiong24/Pictures/${filename}" $pic_url
#command to change background
gsettings set org.gnome.desktop.background picture-uri file:///home/billxiong24/Pictures/"${filename}"
#don't care about the xml file
rm /home/billxiong24/"xml_file"

