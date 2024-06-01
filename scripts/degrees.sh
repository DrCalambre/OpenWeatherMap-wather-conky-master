#!/bin/bash
# -------------------------------------------------------------------
# File: degrees.sh                                    
# Type: Bash Shell Script                             
# By Julio Alberto Lascano http://drcalambre.blogspot.com/
#________          _________        .__                ___.                  
#\______ \_______  \_   ___ \_____  |  | _____    _____\_ |_________   ____  
# |    |  \_  __ \ /    \  \/\__  \ |  | \__  \  /     \| __ \_  __ \_/ __ \ 
# |    `   \  | \/ \     \____/ __ \|  |__/ __ \|  Y Y  \ \_\ \  | \/\  ___/ 
#/_______  /__|     \______  (____  /____(____  /__|_|  /___  /__|    \___  >
#        \/                \/     \/          \/      \/    \/            \/ 
#
# Last modified:2020-12-10                    
# ------------------------
# Manipulate data of weather
# / OS : $GNULinux, $FreeBSD (X Window)
# -------------------------------------------------------------------
# deg is the wind direction and the default unit of measurement is degrees (meteorological). 
# To convert the value to a point on a compass I used an example by Dolores Portalatin (meskarune): 
# https://gist.github.com/meskarune/e415748a104f0479f54dd642d66011e8?permalink_comment_id=3126898

# $1 = degrees to direction
# $2 =  weather_conditions can be "current","cnt01","cnt02","cnt03"
# cnt:  A number of timestamps, which will be returned in the API response.
function compass {
	if [[ "$cnt_code" == "current" ]] 
	then
		cp -r ~/.config/conky/icons/compass/"$1".png ~/.cache/direction_compass-icon.png
		echo "$2" > ~/.cache/direction_compass.txt
	fi

	if [[ "$cnt_code" == "cnt01" ]] 
	then
		cp -r ~/.config/conky/icons/compass/"$1".png ~/.cache/direction_compass-cnt01-icon.png
		echo "$2" > ~/.cache/direction_compass-cnt01.txt
	fi

	if [[ "$cnt_code" == "cnt02" ]] 
	then
		cp -r ~/.config/conky/icons/compass/"$1".png ~/.cache/direction_compass-cnt02-icon.png
		echo "$2" > ~/.cache/direction_compass-cnt02.txt
	fi

	if [[ "$cnt_code" == "cnt03" ]] 
	then
		cp -r ~/.config/conky/icons/compass/"$1".png ~/.cache/direction_compass-cnt03-icon.png
		echo "$2" > ~/.cache/direction_compass-cnt03.txt
	fi
}

cnt_code=$2

case $1 in
	0) compass "green_n" "N";;
	1) compass "green_nne" "NNE";;
	2) compass "green_ne" "NE";;
	3) compass "green_ene" "ENE";;
	4) compass "green_e" "E";;
	5) compass "green_ese" "ESE";;
	6) compass "green_se" "SE";;
	7) compass "green_sse" "SSE";;
	8) compass "green_s" "S";;
	9) compass "green_ssw" "SSO";;
	10) compass "green_sw" "SO";;
	11) compass "green_wsw" "OSO";;
	12) compass "green_w" "O";;
	13) compass "green_wnw" "ONO";;
	14) compass "green_nw" "NO";;
	15) compass "green_nnw" "NNO";;
	16) compass "green_n" "N";;
	*) compass "no_wind" "Sin viento";;
esac


