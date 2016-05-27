#!/bin/bash

perc=$1

now=`~/bin/spotify_control.sh info | grep sp_now | cut -d' ' -f 2`
duration=`~/bin/spotify_control.sh info | grep sp_total | cut -d' ' -f 2`

fragment=$((duration / 100))
jump=$((now + fragment * perc))

if [[ $jump -gt $duration ]] ; then
    jump=$duration
fi

if [[ $jump -lt 0 ]] ; then
    jump=0
fi

~/bin/spotify_control.sh jump $jump
