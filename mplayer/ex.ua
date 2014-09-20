#!/bin/bash

ROOT_URL=http://www.ex.ua

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

PLAY_LIST=$(wget "${URL}" -O - | grep -P "/get/\d?" | perl -lne '/<a.*href='"'(.*?)'"'\s.*>.*<\/a>/; print "http://www.ex.ua" . $1;' | uniq)

if [ "${ARGS}" = '-d' ]; then
    echo $PLAY_LIST
    exit 0;
fi

if [ "${ARGS}" = '-g' ]; then
	smplayer -add-to-playlist $PLAY_LIST # > /dev/null 2>&1 &
    else
	mplayer -fs $PLAY_LIST # > /dev/null 2>&1 &
fi

exit 0
