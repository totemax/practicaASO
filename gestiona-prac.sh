#!/bin/bash

echo 'ASO 13/14 - Práctica 5';
echo 'Jesús Jorge Serrano';

echo 
echo 
echo 'Herramienta de gestión de prácticas'
echo '-----------------------------------'

#### Functions #####

displayMenu(){
    echo 'Menú'
    case $1 in 
        0)
            echo '1) Programar recogida de prácticas'
            echo '2) Empaquetar prácticas de una asignatura'
            echo '3) Ver tamaño y fecha del fichero de la asignatura'
            echo '4) Enviar un backup de prácticas a un servidor remoto'
            echo '5) Finalizar programa'
        ;;
    esac
    read -p "Opción:" opcion
    return $opcion
}

opcion=displayMenu 0
echo $opcion
