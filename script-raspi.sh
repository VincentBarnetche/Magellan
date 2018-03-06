#!/bin/bash

flight_num=1
autopilot_name=Pixhawk

path_dir=/home/pi/$autopilot_name/logs/$(date +%Y-%m-%d)/flight$flight_num
path_parm=$path_dir/mav.parm

sensor_id=28-0516812abbff #different selon la sonde, commence toujours par "28-"
path_sensor=/sys/bus/w1/devices/$sensor_id/w1_slave




#boucle while a decommenter pour un vol
#while [ true ]; do



#PARAMETRES PIXHAWK
#afficher fichier mav.parm | selectionner lignes 2,3 (a modifier selon besoin) | remplacer un nombre indefini d'espaces en tabulation | garder la 2e colonne | remplacer les fins de lignes par le caractere '|'

if [ -e $path_parm ]; then
cat $path_parm | sed -n '2,3p' | sed 's/  */\t/g' | cut -f2 | tr '\n' '|' >> log.txt
fi

#une fois que la copie est reussie, le repertoire du vol peut etre supprime pour liberer de l'espace. Attention toutefois a l'incrementation de $flight_num
#if [[ $? -eq 0 ]]; then
#rm -r $path_dir
#fi



#DONNEES DE VOL
#Les logs telemetrie sont inutilisables sur la Raspberry puisque sans Mission Planner.
#Donc, connecter la Raspberry au Pixhawk via le MAVProxy.

#sudo mavproxy.py --master=/dev/ttyAMA0 --baudrate 57600 --aircraft Pixhawk --cmd="alt" >> log.txt

#Par exemple la commande "alt" renvoie l'altitude et la pression ; isoler les valeurs dans le texte ainsi recupere.
#Une autre piste serait de modifier la sortie standard des fichiers python afin de rediriger les resultats des commandes MAVLink vers le fichier log.txt. 





#TEMPERATURE SONDE DS18B20
#verifier que la sonde est detectee
if [ -e $path_sensor ]; then

#verifier que le CRC est bon
grep "YES" $path_sensor > /dev/null
if [[ $? -eq 0 ]]; then

#recuperer la temperature en la convertissant avec le bon format (XX.XXX)
cat $path_sensor | grep "t=" | awk -F "t=" '{print $2/1000}' >> log.txt

fi
fi


(( flight_num+=1 ))

#repos pendant 10 minutes jusqu'a la prochaine connexion au Pixhawk
#sleep 10m

#done
