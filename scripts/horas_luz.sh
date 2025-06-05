#!/bin/bash

# Función para calcular las horas restantes hasta el atardecer o amanecer
horas_restantes() {
    # Verificar argumentos
    if [ $# -ne 3 ]; then
        echo "Uso: $0 [--sunset|--sunrise] <hora_atardecer> <hora_amanecer> (horas en formato hh:mm:ss)"
        exit 1
    fi

    modo=$1
    atardecer=$2
    amanecer=$3

    # Validar formato de hora (hh:mm:ss)
    if ! [[ $atardecer =~ ^[0-2][0-9]:[0-5][0-9]:[0-5][0-9]$ ]] || ! [[ $amanecer =~ ^[0-2][0-9]:[0-5][0-9]:[0-5][0-9]$ ]]; then
        echo "Error: Las horas deben estar en formato hh:mm:ss (ej. 17:37:00)"
        exit 1
    fi

    # Obtener la hora actual en formato hh:mm:ss
    hora_actual=$(date +%H:%M:%S)

    # Convertir hora actual, atardecer y amanecer a segundos desde medianoche
    # Hora actual
    hora=$(echo $hora_actual | cut -d: -f1 | sed 's/^0*//')  # Eliminar ceros a la izquierda
    min=$(echo $hora_actual | cut -d: -f2 | sed 's/^0*//')
    seg=$(echo $hora_actual | cut -d: -f3 | sed 's/^0*//')
    hora=${hora:-0}  # Si está vacío (por ej. "00"), establecer en 0
    min=${min:-0}
    seg=${seg:-0}
    segundos_actual=$((hora * 3600 + min * 60 + seg))

    # Hora del atardecer
    hora_atardecer=$(echo $atardecer | cut -d: -f1 | sed 's/^0*//')
    min_atardecer=$(echo $atardecer | cut -d: -f2 | sed 's/^0*//')
    seg_atardecer=$(echo $atardecer | cut -d: -f3 | sed 's/^0*//')
    hora_atardecer=${hora_atardecer:-0}
    min_atardecer=${min_atardecer:-0}
    seg_atardecer=${seg_atardecer:-0}
    segundos_atardecer=$((hora_atardecer * 3600 + min_atardecer * 60 + seg_atardecer))

    # Hora del amanecer
    hora_amanecer=$(echo $amanecer | cut -d: -f1 | sed 's/^0*//')
    min_amanecer=$(echo $amanecer | cut -d: -f2 | sed 's/^0*//')
    seg_amanecer=$(echo $amanecer | cut -d: -f3 | sed 's/^0*//')
    hora_amanecer=${hora_amanecer:-0}
    min_amanecer=${min_amanecer:-0}
    seg_amanecer=${seg_amanecer:-0}
    segundos_amanecer=$((hora_amanecer * 3600 + min_amanecer * 60 + seg_amanecer))

    # Calcular diferencia según el modo
    if [ "$modo" = "--sunset" ]; then
        # Diferencia hasta el atardecer
        diferencia=$((segundos_atardecer - segundos_actual))
        if [ $diferencia -lt 0 ]; then
            echo "00:00:00"
        else
            horas=$((diferencia / 3600))
            resto=$((diferencia % 3600))
            minutos=$((resto / 60))
            segundos=$((resto % 60))
            printf "%02d:%02d:%02d\n" $horas $minutos $segundos
        fi
    elif [ "$modo" = "--sunrise" ]; then
        # Diferencia hasta el amanecer
        if [ $segundos_actual -gt $segundos_atardecer ]; then
            segundos_amanecer=$((segundos_amanecer + 86400))  # Amanecer del día siguiente
        fi
        diferencia=$((segundos_amanecer - segundos_actual))
        if [ $diferencia -lt 0 ]; then
            echo "00:00:00"
        else
            horas=$((diferencia / 3600))
            resto=$((diferencia % 3600))
            minutos=$((resto / 60))
            segundos=$((resto % 60))
            printf "%02d:%02d:%02d\n" $horas $minutos $segundos
        fi
    else
        echo "Error: Modo inválido. Use --sunset o --sunrise"
        exit 1
    fi
}

# Llamar a la función con los argumentos proporcionados
horas_restantes "$1" "$2" "$3"
