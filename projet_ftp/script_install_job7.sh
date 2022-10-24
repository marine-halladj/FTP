#!/bin/bash

#Installer proftpd complet 
apt install proftpd*

#Mise à jour du système

apt update | apt upgrade

#Modification fichier proftpd.conf pour section anonyme et section tls  

sed -i '164,203 s/^#//g' /etc/proftpd/proftpd.conf
sed -i '143 s/^#//g' /etc/proftpd/proftpd.conf

#Modification fichier tls.conf pour configuration FTPS

sed -i '9,12 s/^#//g' /etc/proftpd/tls.conf
sed -i '27,28 s/^#//g'/etc/proftpd/tls.conf
sed -i '45 s/^#//g' /etc/proftpd/tls.conf
sed -i '49s/^#//g' /etc/proftpd/tls/conf

#Generation clés ssl 

openssl genrsa -out /etc/ssl/private/proftpd.key 1024
openssl req -new -x509 -days 3650 -key /etc/ssl/private/proftpd.key -out /etc/ssl/proftpd.crt -passin pass "" \
	-subj '/C= /ST= /L= /O= /OU= /CN= /emailAddress= '

#redemarrage serveur apres modification

systemctl start proftpd.service 
