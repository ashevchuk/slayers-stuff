#!/bin/bash

USERNAME="hempslayer"
PASSWORD="fkujhbnv"

PROGNAME=dyndnslogin
COOKIE=`mktemp --tmpdir="/tmp" -t ${PROGNAME}_cookie_***XXXX`
OUTPUT=`mktemp --tmpdir="/tmp" -t ${PROGNAME}_output_***XXXX`
USERAGENT="Mozilla/5.0"

MULTIFORM=`curl -s -k -A $USERAGENT -c $COOKIE https://account.dyn.com \ | awk -F\' '/multiform/{ print $6 }'`

curl -s -k --location -A "$USERAGENT" -b $COOKIE -c $COOKIE -o $OUTPUT \--data "username=$USERNAME&password=$PASSWORD&iov_id=&sub mit=Log+in&multiform=$MULTIFORM" \https://account.dyn.com/

if grep -E "(Welcome|Hi).*$USERNAME" $OUTPUT > /dev/null 2>&1
then
    echo Login successful
else
    echo Login failed
    FAILED="true"
fi

rm $COOKIE
rm $OUTPUT

if [ "$FAILED" = "true" ]
then
    exit 1
fi
