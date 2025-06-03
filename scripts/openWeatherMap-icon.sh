#!/bin/bash

# -------------------------------------------------------------------
# File: openWeatherMap-icon.sh
# Type: Bash Shell Script
# By Julio Alberto Lascano http://drcalambre.blogspot.com/
#________          _________        .__                ___.                  
#\______ \_______  \_   ___ \_____  |  | _____    _____\_ |_________   ____  
# |    |  \_  __ \ /    \  \/\__  \ |  | \__  \  /     \| __ \_  __ \_/ __ \ 
# |    `   \  | \/ \     \____/ __ \|  |__/ __ \|  Y Y  \ \_\ \  | \/\  ___/ 
#/_______  /__|     \______  (____  /____(____  /__|_|  /___  /__|    \___  >
#        \/                \/     \/          \/      \/    \/            \/ 
#
# Last modified:2022-09-15
#
# weather_conditions can be "current","cnt01","cnt02","cnt03"
# cnt:  A number of timestamps, which will be returned in the API response.
# -------------------------------------------------------------------
weather_code=$1
weather_conditions=$2

if [[ "$weather_conditions" == "current" ]] 
then
  cp -r ~/.config/conky/icons/${weather_code}.png ~/.cache/openWeatherMap-icon.png
fi

if [[ "$weather_conditions" == "cnt01" ]] 
then
  cp -r ~/.config/conky/icons/${weather_code}.png ~/.cache/openWeatherMap-cnt01-icon.png
fi

if [[ "$weather_conditions" == "cnt02" ]] 
then
  cp -r ~/.config/conky/icons/${weather_code}.png ~/.cache/openWeatherMap-cnt02-icon.png
fi

if [[ "$weather_conditions" == "cnt03" ]] 
then
  cp -r ~/.config/conky/icons/${weather_code}.png ~/.cache/openWeatherMap-cnt03-icon.png
fi
