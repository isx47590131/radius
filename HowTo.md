# Guia bàsica per posar en marxa radius

## 1. Instal·lació
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



Ara cal comprovar que tenim els ports que toquen disponibles per ser utilitzats. Tenim dos opcions, una que és desactivar el *Firewall* i l'altre que és permetre els ports 1812, 1813, 1645 i 1646 ([suport de cisco on explica els ports](https://supportforums.cisco.com/t5/wan-routing-and-switching/which-port-numbers-are-used-for-radius-accounting-and-radius/td-p/2494536 "Suport Cisco"))
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


### 1.1 Creem una configuració inicial molt bàsica per saber si esta tot correcte.
  
  Mirem que el fitcher `/etc/raddb/clients.conf` que ha de tenir aquesta configuracó per defecte:
  
  ```
  client localhost {
     ipaddr = 127.0.0.1
     secret = testing123
     require_message_authenticator = no
     nastype = other
   }
  ```
  
  Ens inventem un usuari per pràcticar i l'afegim al principi del fitcher `/etc/raddb/users`: 
  
  ```
  pere Cleartext-Password := "kpere"
     Framed-IP-Address = 10.0.0.1,
     Reply-Message = "Bienvenid@, %{User-Name}"
  ```
  
  Parem el *radius* i l'encenem en mode *debug*
  
  ```
  $ sudo systemctl stop radiusd.service
  
  $ sudo radiusd -X
  
  ```
  Ara fem login per provar si podem fer *login* com a client, però des de la mateixa màquina:
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
   
  Com hem vist ens ha fet ens ha connectat perfectament com a pere







## 2. Configuració
