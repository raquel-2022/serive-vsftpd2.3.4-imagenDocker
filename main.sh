#!/bin/bash
# start vsftpd
source /etc/apache2/envvars
apachectl -f /etc/apache2/apache2.conf

/usr/local/sbin/vsftpd /etc/vsftpd.conf 


