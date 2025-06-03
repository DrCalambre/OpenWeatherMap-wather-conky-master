#!/bin/bash

# -------------------------------------------------------------------
# File: time.sh                                          /\
# Type: Bash Shell Script                               /_.\
# By Fernando Gilli fernando<at>wekers(dot)org    _,.-'/ `",\'-.,_
# Last modified:2020-12-10                     -~^    /______\`~~-^~:
# ------------------------
# Manipulate data of moon
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
# Last modified:2022-09-15
# -------------------------------------------------------------------

# set language
lang="pt-es"

#Working directory
DirShell="$HOME/.cache"


case $lang in

     # translate pt-es
     pt-es)
          proxlem=$(sed -n 4p ${DirShell}/moon_phase_die | tr ' ' '\n'|tac| tr '\n' ' ' | cut -c1-22)
          proxlemc=$(sed -n 4p ${DirShell}/moon_phase_die | cut -c1-9)
          proxlemcfull=$(sed -n 2p ${DirShell}/moon_phase_die | cut -c1-9)
          proxlfullem=$(sed -n 2p ${DirShell}/moon_phase_die | tr ' ' '\n'|tac| tr '\n' ' ' | cut -c1-22)
          on="en"
          mm="mm"
          prox="Próx"
          ;;

	*)
          # default
          proxlemc=$(sed -n 4p ${DirShell}/moon_phase_die | cut -c1-9);
          proxlem=$proxlemc
          proxlfullem=$(sed -n 2p ${DirShell}/moon_phase_die | cut -c1-22)
          on="in"
          mm="mm"
          prox="Next"
          proxlemcfull=$(sed -n 2p ${DirShell}/moon_phase_die | cut -c1-9)
          ;;

esac


case $1 in

      mnext)
	     proxl=$(sed -n 3p ${DirShell}/moon_phase_die)
	     if [ $(sed -n 4p ${DirShell}/moon_phase_die | wc -m) -gt 9 ]; then
			echo "$proxl$proxlemc"
	     else
            echo "$prox $proxl:$proxlem"

         fi
       ;;

      mnextfull)
         proxlfull=$(sed -n 1p ${DirShell}/moon_phase_die)
	     if [ $(sed -n 2p ${DirShell}/moon_phase_die | wc -m) -gt 9 ]; then
			echo "$proxlfull$proxlemcfull"
	     else
            echo "$prox $proxlfull:$proxlfullem"
         fi
      ;;
esac

#EOF

