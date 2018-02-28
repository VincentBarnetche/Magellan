#!/bin/bash

flight_num=1
autopilot_name=Pixhawk

path_dir=/home/pi/$autopilot_name/logs/$(date +%Y-%m-%d)/flight$flight_num
path_parm=$path_dir/mav.parm

sensor_id=28-0516812abbff
path_sensor=/sys/bus/w1/devices/$sensor_id/w1_slave

#boucle while à décommenter pour un vol
#while [ true ]; do

#pour récupérer des paramètres du Pixhawk : afficher fichier mav.parm | sélectionner lignes 2,3 (à modifier selon besoin) | remplace un nombre indéfini d'espaces en tabulation | garde la 2e colonne | remplace les fins de lignes par le caractère '|'
if [ -e $path_parm ]; then
cat $path_parm | sed -n '2,3p' | sed 's/  */\t/g' | cut -f2 | tr '\n' '|' >> log.txt
fi

#pour récupérer la température de la sonde DS18B20
if [ -e $path_sensor ]; then
#find $path_sensor/ -name "28-*" -exec cat {}/w1_slave \; | grep "t=" | awk -F "t=" '{print $2/1000}' >> log.txt #| sed '/YES/d' | cut -d'=' -f2 >> log
cat $path_sensor | grep "t=" | awk -F "t=" '{print $2/1000}' >> log.txt
fi

#une fois que la copie est réussie, le répertoire du vol peut être supprimé pour libérer de l'espace. Attention toutefois à l'incrémentation de $flight_num
#if [[ $? -eq 0 ]]; then
#rm -r $path_dir
#fi


(( flight_num+=1 ))

#repos pendant 10 minutes jusqu'à la prochaine connexion au Pixhawk
#sleep 10m

#done
