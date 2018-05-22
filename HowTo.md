# Guia bàsica per posar en marxa radius

La següent explicació és únicament per aprendre com fer la instal·lació i com és el funcionament bàsic d'un servidor radius, on els usuaris estaran creats internament. Si desitges una explicació més profunda fes click [aqui.]()

## Instal·lació radius

Per començar a instal·lar *Freeradius* hem de mirar quins paquets tenim disponibles en la nostre distribució (en el meu cas fedora:24 `dnf`):

```
$ sudo dnf list all freeradius
Last metadata expiration check: 4 days, 0:54:33 ago on Thu Apr 19 08:18:59 2018.
Available Packages
freeradius.x86_64                                                             3.0.10-2.fc24
```

i l'instal·lem juntament amb el pequet utils:

```
$ sudo dnf -y install freeradius freeradius-utils
```



Podem veure que s'ha creat un usuari i un grup al fer-ho:

```
$ grep radius /etc/passwd
radiusd:x:95:95:radiusd user:/var/lib/radiusd:/sbin/nologin

$ grep radius /etc/group
radiusd:x:95:
```



Ara cal comprovar que tenim els ports que toquen disponibles per ser utilitzats. Tenim dos opcions, una que és desactivar el *Firewall* i l'altre que és permetre els ports 1812, 1813, 1645 i 1646 ( [suport de cisco on explica els ports](https://supportforums.cisco.com/t5/wan-routing-and-switching/which-port-numbers-are-used-for-radius-accounting-and-radius/td-p/2494536 "Suport Cisco") )
En el meu cas ja tinc el *Firewall* desactivat:

```
sudo iptables -L -n

Chain INPUT (policy ACCEPT)
Chain FORWARD (policy ACCEPT)
Chain OUTPUT (policy ACCEPT)
```


A continuació per executar *Freeradius* es recomana fer-ho en mode *debug*, el qual s'indica amb `-X`, per així saber els problemes que puguin succeir. Per encedre, apagar, reiniciar, etc. (en el cas de fedora, *systemd*) és fa amb:

``` 
$ sudo systemc start|stop|restart|enable|disable radiusd
```

Per comprovar que està en funcionament:

```
$ pidof radiusd
3801


$ ps -ax | grep radiusd
 3801 ?        Ssl    0:00 /usr/sbin/radiusd -d /etc/raddb


$ systemctl status radiusd
● radiusd.service - FreeRADIUS high performance RADIUS server.
   Loaded: loaded (/usr/lib/systemd/system/radiusd.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2018-04-23 10:04:06 CEST; 2min 39s ago
  Process: 3798 ExecStart=/usr/sbin/radiusd -d /etc/raddb (code=exited, status=0/SUCCESS)
  Process: 3791 ExecStartPre=/usr/sbin/radiusd -C (code=exited, status=0/SUCCESS)
  Process: 3783 ExecStartPre=/bin/chown -R radiusd.radiusd /var/run/radiusd (code=exited, status=0/SUCCESS)
 Main PID: 3801 (radiusd)
```

i comprovar els ports:
```
$ sudo netstat -putan | grep radiusd
udp        0      0 127.0.0.1:18120         0.0.0.0:*                           3801/radiusd
udp        0      0 0.0.0.0:1812            0.0.0.0:*                           3801/radiusd
udp        0      0 0.0.0.0:1813            0.0.0.0:*                           3801/radiusd
udp        0      0 0.0.0.0:34658           0.0.0.0:*                           3801/radiusd
udp6       0      0 :::34440                :::*                                3801/radiusd
udp6       0      0 :::1812                 :::*                                3801/radiusd
udp6       0      0 :::1813                 :::*                                3801/radiusd
```


##  Creem una configuració inicial molt bàsica per saber si esta tot correcte.
  
  Mirem que el fitxer `/etc/raddb/clients.conf` que ha de tenir aquesta configuracó per defecte:
  
  ```
  client localhost {
     ipaddr = 127.0.0.1
     secret = testing123
     require_message_authenticator = no
     nastype = other
   }
  ```

  Ens inventem un usuari per pràcticar i l'afegim al principi del fitxer `/etc/raddb/users`: 
  
  ```
  pere Cleartext-Password := "kpere"
     Framed-IP-Address = 10.0.0.1,
     Reply-Message = "Bienvenid@, %{User-Name}"
  ```

## Posada en marxa

  Parem el *radius* i l'encenem en mode *debug*, per poder observar si hi ha qualsevol problema o simplement per veure la comunicació.
  
  ```
  $ sudo systemctl stop radiusd.service
  
  $ sudo radiusd -X
  
  ```
  Ara fem login per provar si podem fer *login* com a client, des de la mateixa màquina:
  ```
  $ radtest pere kpere 127.0.0.1 100 testing123
	Sent Access-Request Id 52 from 0.0.0.0:45916 to 127.0.0.1:1812 length 74
	User-Name = "pere"
	User-Password = "kpere"
	NAS-IP-Address = 172.17.0.2
	NAS-Port = 100
	Message-Authenticator = 0x00
	Cleartext-Password = "kpere"
	Received Access-Accept Id 52 from 127.0.0.1:1812 to 0.0.0.0:0 length 44
	Framed-IP-Address = 10.0.0.1
	Reply-Message = "Bienvenid@, pere"
   ```
Com hem vist ens ha fet ens ha connectat perfectament com a pere.

----

# Guia per posar en marxa el projecte

Si el que vols és posar en marxa aquest projecte des de zero, et recomano que segueixis els següents passos.

## 1. Instal·lació

El primer que has de fer és crear el directori i descarregar el repositori.

```
$ mkdir radius
$ cd radius
$ git init
$ git pull https://github.com/isx47590131/radius.git
```
Ara toca comprovar la versió de docker i docker-compose que tenim sigui la correcta. Ha de ser igual o superior (cal comprovar si és compatible) a la següent:

```
$ docker -v
Docker version 17.06.0-ce, build 02c1d87
$ docker-compose -version
docker-compose version 1.21.2, build a133471
```
Si necessites ajuda per instal·lar la teva versió de docker consulta [aquesta documentació.](https://docs.docker.com/compose/install/)

## 2. Configuració prèvia

Hem d'assegurar-nos que tenim el `NetworkManager` parat i les IPs corresponents. Un cop parat encenem el Mikrotik i el connectem per configurar-lo. És probable que mentre fem tota la configuració perdem l'accés a internet, per això és recomanable tenir-ho tot descarregat.

```
$ sudo systemctl stop NetworkManager
$ sudo dhclient -r
$ sudo ip a a 192.168.88.5/24 dev enp5s0 #la interfície que fem 
#servir per configurar el mikrotik 
```

Un cop fet això toca configurar el router. Ens copiem la configuració donada en el fitxer `Mikrotik.conf` en el portapapers i la copiem en el Mikrotik.

```
$ cat Mikrotik.conf | xsel -i -b
$ ssh admin@192.168.88.1
$ # Ctrl + v
$ # provem a fer ping a 8.8.8.8
```

## 3. Arrancada

Ara que tenim el router configurat ens situem en el directori del compose, creem les imatges i posem en marxa els conteiners. L'opció `--build` crea la imatge si no existeix o si detecta que hi ha alguna modificació en els fitxers de construcció de la imatge.

```
$ cd compose
$ docker-compose up --build

  Successfully built 1804a678ab98
  Successfully tagged compose_radiusserver:latest
  Starting radiusserver ... done
  Starting ldapserver   ... done
```
## 4. Comprovacions

Un cop tot està funcionant cal comprovar que el seu funcionament és el correcte, per això cal fer les pertinents comprovacions.

Per comprovar que el servidor ldap està correcte podem fer les següents ordres:

```
$ ldapwhoami -x -h 172.100.0.2 -D "cn=Manager,dc=edt,dc=org" -w jupiter
dn:cn=Manager,dc=edt,dc=org
$ ldapsearch -x -LLL -h 172.100.0.2 -b'dc=edt,dc=org' -s base
dn: dc=edt,dc=org
dc: edt
description: Escola del treball de Barcelona
objectClass: dcObject
objectClass: organization
o: edt.org
```

Amb l'ordre `radtest` podrem provar la configuració de radius. Per provar-la cal fer el següent: 
  
  + arg1 -> usuari
  + arg2 -> contrasenya (usuari)
  + arg3 -> IP client al qual fas la consulta
  + arg4 -> port
  + arg5 -> contrasenya (client)

```
$ radtest pere pere 192.168.2.51 1812 testing123
Sent Access-Request Id 194 from 0.0.0.0:53838 to 192.168.2.51:1812 length 74
	User-Name = "pere"
	User-Password = "pere"
	NAS-IP-Address = 192.168.1.11
	NAS-Port = 1812
	Message-Authenticator = 0x00
	Cleartext-Password = "pere"
Received Access-Accept Id 194 from 192.168.2.51:1812 to 0.0.0.0:0 length 20

```

---

**Si encara teniu algun dubte, podeu consultar alguna de les webs que teniu a continuació. Són algunes de les que he utilitzat jo i considero més útils**

### WEBS

+ Certificats:

    https://justanothersysadminblog.wordpress.com/2014/03/18/crear-una-ca-propia-con-la-que-firmar-certificados-ssl/

+ Docker compose

    https://docs.docker.com/compose/compose-file/

+ docker network

    https://docs.docker.com/network/host/

    https://docs.docker.com/network/network-tutorial-macvlan/

+ mikrotik

    http://opentodo.net/2012/07/configuring-peap-authentication-with-freeradius/

    https://blog.svedr.in/posts/freeradius-peapv0+mschapv2-howto.html

    https://forum.mikrotik.com/viewtopic.php?t=112881

+ mikrotik wireless

    https://wiki.mikrotik.com/wiki/Manual:Interface/Wireless

+ radius eap

    http://lists.freeradius.org/pipermail/freeradius-users/2016-August/084440.html

    https://www.garron.me/en/go2linux/instantiation-failed-module-eap.html

+ radius ssl

    https://paulgporter.net/2013/07/14/freeradius-ldaps/

+ radius - mikrotik setup

    https://wiki.mikrotik.com/wiki/How_to_setup_up_RADIUS_for_use_with_MikroTik_-_By_Ramona

    https://medium.com/@georgijsr/freeradius-2-1-12-ubuntu-14-04-server-with-ldap-authentication-and-ldap-fail-over-6611624ff2c9

+ radius -ldap config

    https://tecadmin.net/freeradius-authentication-with-openldap/

    https://tecadmin.net/step-by-step-installation-and-configuration-openldap-server-and-freeradius/

+ radius config

    http://ng-4.blogspot.com.es/2014/08/instalacion-de-freeradius-en-centos.html

    https://www.otpme.org/redmine/projects/otpme/wiki/Freeradius_Example_Configuration

    https://wiki.freeradius.org/config/Configuration-files

+ radius users

    https://www.ip-sa.pl/doc/dslam/maxtnt/radius/userfile.htm

    https://freeradius.org/radiusd/man/users.txt

    https://wiki.freeradius.org/config/Users

+ radius clients

    https://linux.die.net/man/5/clients.conf

    https://freeradius.org/radiusd/man/clients.txt

+ radius example

    https://github.com/FreeRADIUS/freeradius-server/tree/v3.0.x/raddb

+ miscel·lània

    https://www.redeszone.net/2017/06/02/servidor-radius-funciona/

    https://hub.docker.com/r/tpdock/freeradius/

    https://hub.docker.com/r/marcelmaatkamp/freeradius/~/dockerfile/

    
  