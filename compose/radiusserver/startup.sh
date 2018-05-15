#!/bin/bash
#debug
#/usr/sbin/radiusd -X
/bin/chown -R radiusd.radiusd /var/run/radiusd
/usr/sbin/radiusd -C
/bin/bash -c " while ! nc -z 172.100.0.2 389;
	       do 
		 echo 'cant contact with ldap (ip 172.100.0.2)' &> /dev/stderr;
		 sleep 2;
	       done;" 
/usr/sbin/radiusd -X #-d /etc/raddb
