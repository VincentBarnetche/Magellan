# Projet Magellan


 - Configuration de la Raspberry Pi avec le Pixhawk :

        Suivre les instructions de la page internet :
http://ardupilot.org/dev/docs/raspberry-pi-via-mavlink.html

A noter que le nom donné à MyCopter dans la ligne
$ mavproxy.py --master=/dev/ttyAMA0 --baudrate 57600 --aircraft MyCopter
correspondra dans le script-raspi.sh à la variable autopilot_name.

Lors de la première connexion, les identifiants de la Raspberry sont les suivants :
(ATTENTION, les touches peuvent corespondre à un clavier QWERTY)

ID : pi
PWD : raspberry

Dans le but de ne plus avoir à entrer les identifiants par la suite, aller dans la page configuration :
sudo raspi-config -> Boot Options -> Desktop / CLI -> Console Autologin

S'assurer que la date et l'heure de la Raspberry sont bonnes ($ date). Le cas échéant, la modifier.

La communication avec le Pixhawk nécessite de désactiver l'accès du terminal en série, mais d'activer le port série physique :
sudo raspi-config -> Interfacing Options -> Serial -> NO -> YES -> OK

 - Sonde de Température DS18B20 :

Brancher le fil rouge de la sonde sur la broche n°1 de la Raspberry (3V3),
le fil blanc du signal sur la broche n°7 (GPIO4) et le fil noir de la masse
sur la broche n°9 (GND).
Une résistance de pull-up d'environ 4,7kOhm devra être branchée entre
les broches 3V3 et GND de la sonde.

Au niveau de la Raspberry, pour pouvoir utiliser le bus 1-Wire, activer le protocole 1-Wire (sudo raspi-config -> Interfacing Options -> 1-Wire -> Enable) puis ajouter dans le fichier /etc/modules les lignes suivantes :
w1-therm
w1-gpio pullup=1
