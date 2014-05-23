#!/bin/bash

#Script de recogida de practicas

path_practicas=$1

path_destino=$2

find $path_practicas -type f -name "prac.sh" -exec ls '{}' \; > .aux_pract_files

numLines=`wc -l .aux_pract_files | cut -d' ' -f1`


count=1
lastcount=1

while [ $count -le $numLines ]
do
    item=`head -$count .aux_pract_files|tail -$lastcount`
    pathitem=`dirname $item`
    nomfile=`basename $pathitem`.sh
    cp $item $path_destino/$nomfile
    if [ $count -eq 1 ]
    then
        lastcount=$count
    fi;
    let count=`expr $count + 1`
done;