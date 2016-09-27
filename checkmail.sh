 #!/bin/bash
 FOLDER=
 PASSWORD= #put password here
 tag="title"
 if [ -z "$FOLDER" -o $# -eq 0 ]; then
	#No argument supplied, or invalid
	FOLDER="Inbox"
 else
	FOLDER=$1
 fi
 
 #Need to provide authentication
 wget -q -O /home/billxiong24/Utility_Scripts/gmail.xml --user="billx0477@gmail.com" --password="$PASSWORD" https://mail.google.com/mail/feed/atom/$FOLDER
 #grep -o '<title>.*</title>' gmail.xml

 #get sender
 cat gmail.xml | grep -oPm1 "(?<=<name>)[^<]+" > senders.txt
 #get subject, in title tags
 cat gmail.xml | grep -oPm1 "(?<=<title>)[^<]+" | sed '1d' > subjects.txt
 
 pr -m -t -w 150 senders.txt subjects.txt > updated_email.txt
 repl=$(cat updated_email.txt);
 str="&quot;"
 #replace weird characters with what they're supposed to be
 sed -i 's/&quot;/\"/g' updated_email.txt 
 sed -i "s/&#39;/'/g" updated_email.txt
 
 #These were temporary files
 rm senders.txt subjects.txt
