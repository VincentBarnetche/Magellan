#!/bin/bash

flight_num=1
autopilot_name=Pixhawk

#path=/home/pi/$autopilot_name/logs/$(date +%Y-%m-%d)/flight$flight_num
path_dir=/home/barnetche/Documents/$(date +%Y-%m-%d)
path=$path_dir/data.txt

#pour utiliser le bus 1-Wire, ajouter dans le fichier /etc/modules les lignes suivantes :
#w1-therm
#w1-gpio pullup=1

#sensor_id=28-0000054c2ec2
#path_sensor=/sys/bus/w1/devices/$sensor_id/w1_slave
path_sensor=/home/barnetche/Documents/w1/data.txt

#boucle while à décommenter pour un vol
#while [ true ]; do


if [ -e $path ]; then
cat $path | sed -n '2,3p' | sed 's/  */\t/g' | cut -f2 | tr '\n' '|' >> log.txt

if [ -e $path_sensor ]; then
cat $path_sensor | sed '/YES/d' | cut -d'=' -f2 >> log.txt

#une fois que la copie est réussie, le répertoire du vol est supprimé pour libérer de l'espace
if [[ $? -eq 0 ]]; then
rm -r $path_dir
fi

fi

fi

(( flight_num+=1 ))

#repos pendant 10 minutes jusqu'à la prochaine connexion au Pixhawk
#sleep 10m

#done
