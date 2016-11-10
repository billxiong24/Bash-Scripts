 #!/bin/bash
 # arg1 is email, arg2 is password- put in this file you want to 
 #Need to provide authentication
 wget -q -O gmail.xml --user="$1" --password="$2" https://mail.google.com/mail/feed/atom/
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
 
 type=
 [[ $# -eq 0 ]] || type=$1;
 if [ "$type" == "subject" ]; then
    cat subjects.txt
 elif [ "$type" == "sender" ]; then
    cat senders.txt;
 else
    cat updated_email.txt
 fi
 # temporary files
 rm subjects.txt senders.txt updated_email.txt gmail.xml
