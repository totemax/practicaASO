#!/bin/bash
#### Functions #####

function displayMenu
{
    #Initial Prompt message
    #clear
    echo 'ASO 13/14 - Práctica 5';
    echo 'Jesús Jorge Serrano';
    
    echo 
    echo 
    echo 'Herramienta de gestión de prácticas'
    echo '-----------------------------------'
    
    local opcion
    echo 'Menú'
    echo
    echo '1) Programar recogida de prácticas'
    echo '2) Empaquetar prácticas de una asignatura'
    echo '3) Ver tamaño y fecha del fichero de la asignatura'
    echo '4) Enviar un backup de prácticas a un servidor remoto'
    echo '5) Finalizar programa'
    read -p "Opción:" opcion
    return $opcion
}


function error_log
{
    if [ $# -gt 0 ];
    then
        error_time=`date "+%d%m%Y %k:%M"`
        echo "$error_time $1" >> informe_prac.log
    fi
    return 0
}

function register_cron
{
    
    #todo: implementar
    return 0
}

displayMenu
submenu=$?

while [ $submenu -ne 5 ];
do
    clear
    case $submenu in 
        1)
            echo 'Menú 1 - Programar recogida de prácticas'
            echo
            read -p "Asignatura cuyas prácticas desea recoger:" asignatura
            is_valid=1
            while [ $is_valid -eq 1 ]; 
            do
                read -p "Hora a la que debe realizarse la recogida:" hora
                date_result=`date -d $hora 2>&1`
                is_valid=$?
                if [ $is_valid -eq 1 ]
                then
                    echo 'La hora introducida no es válida'
                    error_log "Error al introducir la fecha del cron: $date_result"
                fi
            done
            read -p "Ruta absoluta con las cuentas de los alumnos:" path_alumnos
            read -p "Ruta absoluta para almacenar prácticas:" path_almacen
            if [ -d $path_alumnos ]
            then
                hora_cron=`date -d $hora "+%k:%M"`
                echo "Se va a programar la recogida de las prácticas de ASO a las $hora_cron. Origen: $path_alumnos. Destino: $path_almacen"
                read -p "¿Está de acuerdo (s/n)?" result
                if [ "$result" = "s" ]
                then
                    register_cron "$hora" "$path_alumnos" "$path_almacen"
                fi;
            else
                error_log "La ruta de la cuenta de los alumnos no existe."
                read -p "La ruta de la cuenta de los alumnos no existe."
            fi;
        ;;
        2)
            echo 'Menú 2 – Empaquetar prácticas de la asignatura'
            echo 
            read -p 'Asignatura cuyas prácticas se desea empaquetar:' asignatura 
            read -p 'Ruta absoluta del directorio de prácticas:' path_practicas
            if [ -d $path_practicas ]
            then 
                echo "Se van a empaquetar las prácticas de la asignatura ASO presentes en el directorio $path_practicas."
                read -p "¿Está de acuerdo (s/n)?" result
                if [ "$result" = "s" ]
                then
                    nom_fichero="`echo $asignatura | tr '[:upper:]' '[:lower:]'`-`date '+%y%m%d-%k%M'`.tgz"
                    read -p "$nom_fichero"
                fi;
            else
                error_log "La ruta de las prácticas no existe."
                read -p "La ruta de las prácticas no existe."
            fi;
        ;;
    esac
    
    displayMenu
    submenu=$?
done