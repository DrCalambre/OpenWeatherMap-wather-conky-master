#!/bin/bash

# --------------------------------------------------------------------------------------------------------------------------------------
# File: aplicar_marca_agua.sh
# By Julio Alberto Lascano http://drcalambre.blogspot.com/
#________          _________        .__                ___.                  
#\______ \_______  \_   ___ \_____  |  | _____    _____\_ |_________   ____  
# |    |  \_  __ \ /    \  \/\__  \ |  | \__  \  /     \| __ \_  __ \_/ __ \ 
# |    `   \  | \/ \     \____/ __ \|  |__/ __ \|  Y Y  \ \_\ \  | \/\  ___/ 
#/_______  /__|     \______  (____  /____(____  /__|_|  /___  /__|    \___  >
#        \/                \/     \/          \/      \/    \/            \/ 
# --------------------------------------------------------------------------------------------------------------------------------------
# Last modified:2024-05-28
# --------------------------------------------------------------------------------------------------------------------------------------
# Descripción del script: aplicar_marca_agua.sh
# --------------------------------------------------------------------------------------------------------------------------------------
# Uso: aplicar_marca_agua.sh -m [marca_agua] -d [directorio_imagenes] -s [factor_escala] -o [directorio_salida]
# --------------------------------------------------------------------------------------------------------------------------------------
# Este script automatiza el proceso de aplicar una marca de agua a todas las imágenes en un directorio especificado.
# A continuación se explica paso a paso lo que hace el script:
#
# 1. Verificación de comandos de ImageMagick:
#    - Se verifica si los comandos 'identify', 'convert' y 'composite' están disponibles.
#
# 2. Definición de parámetros:
#    - MARCA_DE_AGUA: Ruta de la imagen que se utilizará como marca de agua.
#    - DIRECTORIO_IMAGENES: Directorio que contiene las imágenes a las que se aplicará la marca de agua.
#    - FACTOR_ESCALA: Factor de escala que determina el tamaño proporcional de la marca de agua en relación con el ancho de la imagen original.
#    - DIRECTORIO_SALIDA: Directorio donde se guardarán las imágenes con la marca de agua aplicada.
#
# 3. Verificación de parámetros y rutas:
#    - Se verifica que todos los parámetros necesarios se han proporcionado.
#    - Se verifica que la ruta de la marca de agua y el directorio de imágenes existen.
#    - Si el directorio de salida no existe, se crea automáticamente.
#
# 4. Bucle para procesar cada imagen:
#    - Se utiliza un bucle 'for' para iterar sobre cada archivo en el directorio de imágenes especificado.
#    - Se verifica si el archivo actual en el bucle es un archivo regular utilizando la condición 'if [ -f "$IMAGEN" ]'.
#
# 5. Obtención del tamaño de la imagen:
#    - Se utiliza el comando 'identify' para obtener el tamaño de la imagen en píxeles.
#
# 6. Cálculo del tamaño de la marca de agua:
#    - Se calcula el tamaño de la marca de agua proporcional al tamaño de la imagen original, utilizando el factor de escala definido.
#
# 7. Redimensionamiento de la marca de agua:
#    - Se redimensiona la marca de agua al tamaño calculado y se elimina cualquier perfil de color incrustado para evitar advertencias.
#
# 8. Aplicación de la marca de agua:
#    - Se aplica la marca de agua al pie de la imagen con un margen inferior centrado utilizando el comando 'composite'.
#
# 9. Eliminación de archivos temporales:
#    - Se elimina el archivo temporal de la marca de agua redimensionada después de aplicarla a la imagen.
# --------------------------------------------------------------------------------------------------------------------------------------


# Verificación de comandos de ImageMagick
if ! command -v identify &> /dev/null || ! command -v convert &> /dev/null || ! command -v composite &> /dev/null
then
    echo "ImageMagick no está instalado o los comandos necesarios no están disponibles. Por favor, instálalo antes de ejecutar este script."
    exit 1
fi

# Manejo de errores
# Se añade manejo de errores para asegurar que el script se detenga si ocurre algún problema. 
# Se hace con: set -e lo que hace que el script termine si algún comando falla.

set -e

# Uso: aplicar_marca_agua.sh -m [marca_agua] -d [directorio_imagenes] -s [factor_escala] -o [directorio_salida]
while getopts "m:d:s:o:" opt; do
    case ${opt} in
        m ) MARCA_DE_AGUA=$OPTARG ;;
        d ) DIRECTORIO_IMAGENES=$OPTARG ;;
        s ) FACTOR_ESCALA=$OPTARG ;;
        o ) DIRECTORIO_SALIDA=$OPTARG ;;
        \? ) echo "Uso: aplicar_marca_agua.sh -m [marca_agua] -d [directorio_imagenes] -s [factor_escala] -o [directorio_salida]"
             exit 1 ;;
    esac
done

# Verificación de parámetros
if [ -z "$MARCA_DE_AGUA" ] || [ -z "$DIRECTORIO_IMAGENES" ] || [ -z "$FACTOR_ESCALA" ] || [ -z "$DIRECTORIO_SALIDA" ]; then
    echo ""
    echo "Uso: aplicar_marca_agua.sh -m [marca_agua] -d [directorio_imagenes] -s [factor_escala] -o [directorio_salida]"
    echo ""
    echo "Todos los parámetros (-m, -d, -s, -o) son obligatorios."
    echo "-------------------------------------------------------------------------------------------------------------"
    echo "Factor de escala para el tamaño de la marca de agua -s [factor_escala]"
    echo "Por ejemplo: -s 0.15 , un factor de escala del 15% es adecuado para la fotografia de paisajes."
    echo "-------------------------------------------------------------------------------------------------------------"
    
    
    exit 1
fi

# Verificación de la existencia de la ruta de la marca de agua
if [ ! -f "$MARCA_DE_AGUA" ]; then
    echo "La ruta de la marca de agua ($MARCA_DE_AGUA) no existe."
    exit 1
fi

# Verificación de la existencia del directorio de imágenes
if [ ! -d "$DIRECTORIO_IMAGENES" ]; then
    echo "El directorio de imágenes ($DIRECTORIO_IMAGENES) no existe."
    exit 1
fi

# Verificación de la existencia del directorio de salida
if [ ! -d "$DIRECTORIO_SALIDA" ]; then
    echo "El directorio de salida ($DIRECTORIO_SALIDA) no existe. Creando el directorio..."
    mkdir -p "$DIRECTORIO_SALIDA"
fi

contador=0
tiempo_inicio=$(date +%s)


# Aplicar marca de agua a cada imagen en el directorio
for IMAGEN in "$DIRECTORIO_IMAGENES"/*; do
    if [ -f "$IMAGEN" ]; then
        nombre_imagen=$(basename "$IMAGEN")
        echo "Aplicando marca de agua a $DIRECTORIO_IMAGENES$nombre_imagen -> $DIRECTORIO_SALIDA${nombre_imagen%.*}_wm.jpg"
        
        # Obtener el tamaño de la imagen (ancho x altura)
        tamano_imagen=$(identify -format "%wx%h" "$IMAGEN")
        
        # Separar el ancho y la altura
        ancho_imagen=$(echo "$tamano_imagen" | cut -d'x' -f 1)
        altura_imagen=$(echo "$tamano_imagen" | cut -d'x' -f 2)
        
        # Calcular el tamaño de la marca de agua proporcional al tamaño de la imagen
        tamano_marca=$(echo "$ancho_imagen * $FACTOR_ESCALA" | bc)
        
        # Redimensionar la marca de agua al tamaño calculado y eliminar el perfil de color
        marca_de_agua_redimensionada=$(mktemp)
        convert "$MARCA_DE_AGUA" -resize "${tamano_marca}x${tamano_marca}" -strip "$marca_de_agua_redimensionada"
        
        # Aplicar marca de agua al pie de la imagen con margen inferior centrado
        composite -dissolve 50% -gravity South -geometry +0+3 "$marca_de_agua_redimensionada" "$IMAGEN" "$DIRECTORIO_SALIDA/${nombre_imagen%.*}_wm.jpg"
        
        # llamada script de Python para determinar el color (blanco o negro)
        color=$(python /home/antix1/src/Python/clasificar_imagen/clasificar_imagen_v3.py "$DIRECTORIO_IMAGENES$nombre_imagen")
        
        # Imprimir el resultado capturado
        echo "Resultado: $color"
        
        # Eliminar el archivo temporal de la marca de agua redimensionada
        rm "$marca_de_agua_redimensionada"
        
        # Incrementar el contador por cada imagen procesada
		contador=$((contador + 1))
    fi
done

# Calcular el tiempo total transcurrido
tiempo_fin=$(date +%s)
tiempo_total=$((tiempo_fin - tiempo_inicio))

# Convertir tiempo total a formato hh:mm:ss
horas=$((tiempo_total / 3600))
minutos=$(( (tiempo_total % 3600) / 60 ))
segundos=$((tiempo_total % 60))

# Mostrar el total de imágenes procesadas y el tiempo que tomó
echo "-------------------------------------------------------------------------------------------------------------"
echo "Total de imágenes procesadas: $contador"
# Formatear la salida
printf "Tiempo total transcurrido: %02d:%02d:%02d\n" $horas $minutos $segundos
