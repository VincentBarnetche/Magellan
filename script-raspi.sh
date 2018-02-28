#!/bin/bash

flight_num=1
autopilot_name=Pixhawk

path_dir=/home/pi/$autopilot_name/logs/$(date +%Y-%m-%d)/flight$flight_num
path_parm=$path_dir/mav.parm

sensor_id=28-0516812abbff "différent selon la sonde, commence toujours par "28-"
path_sensor=/sys/bus/w1/devices/$sensor_id/w1_slave



#boucle while à décommenter pour un vol
#while [ true ]; do



#pour récupérer des paramètres du Pixhawk : afficher fichier mav.parm | sélectionner lignes 2,3 (à modifier selon besoin) | remplacer un nombre indéfini d'espaces en tabulation | garder la 2e colonne | remplacer les fins de lignes par le caractère '|'
if [ -e $path_parm ]; then
cat $path_parm | sed -n '2,3p' | sed 's/  */\t/g' | cut -f2 | tr '\n' '|' >> log.txt
fi

#une fois que la copie est réussie, le répertoire du vol peut être supprimé pour libérer de l'espace. Attention toutefois à l'incrémentation de $flight_num
#if [[ $? -eq 0 ]]; then
#rm -r $path_dir
#fi



#pour récupérer la température de la sonde DS18B20 : vérifier que la sonde est détectée
if [ -e $path_sensor ]; then

#vérifier que le CRC est bon
grep "YES" $path_sensor > /dev/null
if [[ $? -eq 0 ]]; then

#récupérer la température en la convertissant avec le bon format (XX.XXX)
cat $path_sensor | grep "t=" | awk -F "t=" '{print $2/1000}' >> log.txt

fi
fi


(( flight_num+=1 ))

#repos pendant 10 minutes jusqu'à la prochaine connexion au Pixhawk
#sleep 10m

#done
