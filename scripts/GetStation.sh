#!/bin/bash

# GetStation.sh
# Este script calcula la estación actual y los días restantes para la siguiente estación en función de la ubicación actual.

# Obtener la latitud usando ipinfo.io
latitude=$(curl -s https://ipinfo.io/ | jq -r '.loc' | cut -d ',' -f 1)

# Determinar el hemisferio basado en la latitud
if (( $(echo "$latitude > 0" | bc -l) )); then
    hemisphere="norte"
else
    hemisphere="sur"
fi

# Obtener la fecha actual
current_date=$(date +%Y-%m-%d)

# Establecer las fechas de inicio de las estaciones según el hemisferio
if [[ "$hemisphere" == "norte" ]]; then
    spring_start=$(date -d "$(date +%Y)-03-21" +%Y-%m-%d)
    summer_start=$(date -d "$(date +%Y)-06-21" +%Y-%m-%d)
    autumn_start=$(date -d "$(date +%Y)-09-21" +%Y-%m-%d)
    winter_start=$(date -d "$(date +%Y)-12-21" +%Y-%m-%d)
    next_year_spring_start=$(date -d "$(( $(date +%Y) + 1 ))-03-21" +%Y-%m-%d)
else
    spring_start=$(date -d "$(date +%Y)-09-21" +%Y-%m-%d)
    summer_start=$(date -d "$(date +%Y)-12-21" +%Y-%m-%d)
    autumn_start=$(date -d "$(date +%Y)-03-21" +%Y-%m-%d)
    winter_start=$(date -d "$(date +%Y)-06-20" +%Y-%m-%d)
    next_year_autumn_start=$(date -d "$(( $(date +%Y) + 1 ))-03-21" +%Y-%m-%d)
fi

# Calcular la estación actual y la próxima estación
if [[ "$hemisphere" == "norte" ]]; then
    if [[ "$current_date" > "$winter_start" ]] || [[ "$current_date" < "$spring_start" ]]; then
        current_season="Invierno"
        next_season="Primavera"
        next_season_date=$spring_start
        current_icon="winter"
        next_icon="spring"
    elif [[ "$current_date" < "$summer_start" ]]; then
        current_season="Primavera"
        next_season="Verano"
        next_season_date=$summer_start
        current_icon="spring"
        next_icon="summer"
    elif [[ "$current_date" < "$autumn_start" ]]; then
        current_season="Verano"
        next_season="Otoño"
        next_season_date=$autumn_start
        current_icon="summer"
        next_icon="autumn"
    else
        current_season="Otoño"
        next_season="Invierno"
        next_season_date=$winter_start
        current_icon="autumn"
        next_icon="winter"
    fi
else
    if [[ "$current_date" > "$summer_start" ]] || [[ "$current_date" < "$autumn_start" ]]; then
        current_season="Verano"
        next_season="Otoño"
        next_season_date=$autumn_start
        current_icon="summer"
        next_icon="autumn"
    elif [[ "$current_date" < "$winter_start" ]]; then
        current_season="Otoño"
        next_season="Invierno"
        next_season_date=$winter_start
        current_icon="autumn"
        next_icon="winter"
    elif [[ "$current_date" < "$spring_start" ]]; then
        current_season="Invierno"
        next_season=   "Primavera"
        next_season_date=$spring_start
        current_icon="winter"
        next_icon="spring"
    else
        current_season="Primavera"
        next_season="Verano"
        next_season_date=$summer_start
        current_icon="spring"
        next_icon="summer"
    fi
fi

# Calcular los días restantes para la próxima estación
current_date_sec=$(date -d "$current_date" +%s)
next_season_date_sec=$(date -d "$next_season_date" +%s)
days_until_next_season=$(( (next_season_date_sec - current_date_sec) / 86400 ))

# Copiar la estación actual y la proxima en el directorio temporal del usuario.
cp -r ~/.config/conky/icons/${current_icon}.png ~/.cache/current_station.png
cp -r ~/.config/conky/icons/${next_icon}.png ~/.cache/next_station.png

# Mostrar la estación actual, el icono y los días restantes para la próxima estación
echo "$current_season;$current_icon;$next_season;$next_icon;$days_until_next_season"

