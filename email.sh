#!/bin/bash
#Sends email using mutt, using smtp (gmail) server
#TODO use IMAP to access and send emails from Duke address

if [ "$1" == -h ]; then
    echo "arg1- Subject"
    echo "arg2- To address"
    echo "arg3- text file used to send message body"
    echo "arg4...- attachments"
    exit 0
fi
if [ "$#" -lt 3 ]; then
    echo "Warning: not enough arguments. Use -h for help."
    exit 1
fi

SUBJECT=$1
TO=$2
BODY=$3
#shift to get to attachments 
shift 3
mutt -s "$SUBJECT" -a "$*" -- "$TO" < $BODY
#or echo "Message here" | mail -s "subject" dest@mail.com
#or cat $filename | mail -s....
#or ssmtp dest@mail.com < $(file with message details)