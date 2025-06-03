#!/bin/bash

# Función para calcular las horas de luz restantes hasta el atardecer
horas_luz_restantes() {
    # Verificar que se haya pasado un argumento
    if [ $# -ne 1 ]; then
        echo "Uso: $0 <hora_atardecer> (en formato hh:mm:ss)"
        exit 1
    fi

    # Hora del atardecer pasada como argumento
    atardecer=$1

    # Validar formato de hora del atardecer (hh:mm:ss)
    if ! [[ $atardecer =~ ^[0-2][0-9]:[0-5][0-9]:[0-5][0-9]$ ]]; then
        echo "Error: La hora del atardecer debe estar en formato hh:mm:ss (ej. 17:37:00)"
        exit 1
    fi

    # Obtener la hora actual en formato hh:mm:ss
    hora_actual=$(date +%H:%M:%S)

    # Convertir hora actual y atardecer a segundos desde medianoche
    # Hora actual
    hora=$(echo $hora_actual | cut -d: -f1)
    min=$(echo $hora_actual | cut -d: -f2)
    seg=$(echo $hora_actual | cut -d: -f3)
    segundos_actual=$((hora * 3600 + min * 60 + seg))

    # Hora del atardecer
    hora_atardecer=$(echo $atardecer | cut -d: -f1)
    min_atardecer=$(echo $atardecer | cut -d: -f2)
    seg_atardecer=$(echo $atardecer | cut -d: -f3)
    segundos_atardecer=$((hora_atardecer * 3600 + min_atardecer * 60 + seg_atardecer))

    # Calcular diferencia en segundos
    diferencia=$((segundos_atardecer - segundos_actual))

    # Si la diferencia es negativa, el atardecer ya pasó
    if [ $diferencia -lt 0 ]; then
        #"El atardecer ya pasó hoy. Horas de luz restantes: 0"
        # Formatear salida con ceros a la izquierda si es necesario
        printf "%02d:%02d:%02d\n" $horas $minutos $segundos
        exit 0
    fi

    # Convertir diferencia a formato hh:mm:ss
    horas=$((diferencia / 3600))
    resto=$((diferencia % 3600))
    minutos=$((resto / 60))
    segundos=$((resto % 60))

    # Formatear salida con ceros a la izquierda si es necesario
    printf "%02d:%02d:%02d\n" $horas $minutos $segundos
}

# Llamar a la función con el argumento proporcionado
horas_luz_restantes "$1"
