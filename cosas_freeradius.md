https://www.redeszone.net/2017/06/02/servidor-radius-funciona/
https://hub.docker.com/r/tpdock/freeradius/
https://hub.docker.com/r/marcelmaatkamp/freeradius/~/dockerfile/
https://www.ip-sa.pl/doc/dslam/maxtnt/radius/userfile.htm
https://freeradius.org/radiusd/man/users.txt


#Funciona:
client private-network-1 {
        ipaddr = 192.168.2.0
        netmask = 24
        secret = testing123-1
        shortname = private-network-1
        require_message_authenticator = no
        nas_type = other
}

[isx47590131@i12 ~]$ radtest pere kpere 192.168.2.51 100 testing123-1
Sent Access-Request Id 43 from 0.0.0.0:49311 to 192.168.2.51:1812 length 74
	User-Name = "pere"
	User-Password = "kpere"
	NAS-IP-Address = 192.168.2.42
	NAS-Port = 100
	Message-Authenticator = 0x00
	Cleartext-Password = "kpere"
Received Access-Accept Id 43 from 192.168.2.51:1812 to 0.0.0.0:0 length 44
	Framed-IP-Address = 10.0.0.1
	Reply-Message = "Bienvenid@, pere"


## En el sevidor ldap
instalado passw sshserver


## añadido en /etc/raddb/aviable-mods/ldap
https://github.com/FreeRADIUS/freeradius-server/blob/v3.0.x/raddb/mods-available/ldap
https://tecadmin.net/freeradius-authentication-with-openldap/



## Per configurar freeradius amb el router 
##(https://medium.com/@georgijsr/freeradius-2-1-12-ubuntu-14-04-server-with-ldap-authentication-and-ldap-fail-over-6611624ff2c9):
client %router_name% {
ipaddr = %router_ip%
secret = %router_password%
limit {
max_connections = 50
lifetime = 0
idle_timeout = 30
  }
}

