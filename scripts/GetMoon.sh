#!/bin/bash

# -------------------------------------------------------------------
# File: GetMoon.sh                                       /\
# Type: Bash Shell Script                               /_.\
# By Fernando Gilli fernando<at>wekers(dot)org    _,.-'/ `",\'-.,_
# ------------------------                     -~^    /______\`~~-^~:
# Get Moon data from moongiant.com
# / OS : $Linux, $FreeBSD (X Window)
# ------------------------
# adapted for the current version by: 
#________          _________        .__                ___.                  
#\______ \_______  \_   ___ \_____  |  | _____    _____\_ |_________   ____  
# |    |  \_  __ \ /    \  \/\__  \ |  | \__  \  /     \| __ \_  __ \_/ __ \ 
# |    `   \  | \/ \     \____/ __ \|  |__/ __ \|  Y Y  \ \_\ \  | \/\  ___/ 
#/_______  /__|     \______  (____  /____(____  /__|_|  /___  /__|    \___  >
#        \/                \/     \/          \/      \/    \/            \/ 
# Julio Alberto Lascano http://drcalambre.blogspot.com/
# Last modified:2023-09-21
# -------------------------------------------------------------------

# Working directory
DirShell="$HOME/.cache"
DirScripts="$HOME/.config/conky/scripts"

# ****************************
wget -q -O ${DirShell}/raw "http://www.moongiant.com/phase/today" > /dev/null 2>&1

cp ${DirShell}/raw ${DirShell}/ico

[ -f ${DirShell}/moon_tmp.jpg ] && rm ${DirShell}/moon_tmp.jpg
[ -f ${DirShell}/moon.jpg ] && rm ${DirShell}/moon.jpg


sed -i -e '/^ *$/d' -e 's/^ *//g' ${DirShell}/raw
sed -i '/Illumination/!d' ${DirShell}/raw
sed -i 's/<br>/\n/g' ${DirShell}/raw
sed -i 's|<[^>]*>||g' ${DirShell}/raw
sed -i -e '4d' ${DirShell}/raw

#ico name
sed -i '/var jArray=\|"todayMoonContainer"/!d' ${DirShell}/ico
sed -i -e 's/"\]};//g' -e 's/^.*today_phase\///g' -e 's/\.jpg.*$//g' ${DirShell}/ico
cat  ${DirShell}/ico >> ${DirShell}/raw
img_in=$(sed -n 4p ${DirShell}/raw)
[ -f ${DirShell}/ico ] && rm  ${DirShell}/ico



 # day moon -> more dark
  wget -q -O ${DirShell}/get_moon_icon_tmp "https://moon.nasa.gov/moon-observation/daily-moon-guide/" > /dev/null 2>&1

  now_ico="$(LANG=en_us_88591 date +'%d %b %Y')"
  
  grep -E -o "${now_ico}.{0,428}" ${DirShell}/get_moon_icon_tmp | \
  sed 's/&quot;/ /g'| sed 's/, /\n/g' | sed -e '2,13d' | sed 's/image_src ://g' | \
  sed 's/^ *//g' | sed 's/\.jpg.*/.jpg/' > ${DirShell}/get_moon_icon
  
  img_ico=$(sed -n 2p ${DirShell}/get_moon_icon)

  wget -q --output-document=${DirShell}/moon_tmp.jpg https://moon.nasa.gov/$img_ico > /dev/null 2>&1

  [ -f ${DirShell}/get_moon_icon_tmp ] && rm  ${DirShell}/get_moon_icon_tmp


# exec too
bash ${DirScripts}/lune_die.sh > /dev/null 2>&1

#EOF

