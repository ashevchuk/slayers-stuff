#!/bin/bash

URL="http://www.ex.ua"

if [ -z "$1" ]; then
	echo "Usage: $0 [-g for smplayer | -d for dump] [ex.ua list url]"

	exit 1
fi

if [ ! -z "$2" ]; then
	URL=$2
	ARGS=$1
    else
	URL=$1
	ARGS=
fi

if [ "${ARGS}" = '-d' ]; then
    wget "${URL}" -O - | grep -P "/get/\d?" | perl -lne '/<a.*href='"'(.*?)'"'\s.*>.*<\/a>/; print "http://www.ex.ua" . $1;' | uniq
    exit 0;
fi

if [ "${ARGS}" = '-g' ]; then
	wget "${URL}" -O - | -P "/get/\d?" | perl -lne '/<a.*href='"'(.*?)'"'\s.*>.*<\/a>/; print "http://www.ex.ua" . $1;' | uniq | xargs smplayer -add-to-playlist > /dev/null 2>&1 &
	exit 0;
    else
	wget "${URL}" -O - | -P "/get/\d?" | perl -lne '/<a.*href='"'(.*?)'"'\s.*>.*<\/a>/; print "http://www.ex.ua" . $1;' | uniq | mplayer -fs -playlist - > /dev/null 2>&1 &
	exit 0;
fi

exit 0
