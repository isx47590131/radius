nombre: Arnau Esteban
num puesto: 22
version: A

# La orden netstat permite:

*Conocer dispositivos del equipo
*Capturar las tramas de un ping
*[ok]Conocer que servicio ha abierto un puerto UDP
*Conocer las estadísticas de paquetes transmitidos y recibidos en una interface

# A partir de la salida de la orden ip r:

*Puede hacer ping a 192.168.1.1 y a 8.8.8.8
*Puede hacer ping a 192.168.1.1 y no a 8.8.8.8
*No puede hacer ping a 192.168.1.1 ni a 8.8.8.8
*[ok]No puede hacer ping a 192.168.1.1 y sí a 8.8.8.8

# A partir de la salida del comando ethtool

	# ethtool eth0 |grep Speed
	Speed: 1000Mb/s

Con una prueba de iperf es coherente que la velocidad sea de:

*1Gbps
*[ok]700 MBps
*120 Mbps
*0,002 Tbps

# A partir de la salida de los comandos ip r y ip a
	# ip a s dev eth0
	2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
		link/ether 94:de:80:49:7d:fd brd ff:ff:ff:ff:ff:ff
		inet 192.168.0.19/16 brd 192.168.255.255 scope global dynamic eth0
		   valid_lft 17835sec preferred_lft 17835sec
		inet 10.8.1.1/16 scope global eth0
		   valid_lft forever preferred_lft forever
	# ip r s
	default via 192.168.0.5 dev eth0 
	10.2.3.0 via 10.7.4.1
	10.8.0.0/16 dev eth0  proto kernel  scope link  src 10.8.1.1 
	192.168.0.0/16 dev eth0  proto kernel  scope link  src 192.168.0.19 

# Hacemos un ping a 10.2.3.1 y falla, la causa de que falle es:

*[ok]Falta una ruta local que diga como llegar a 10.7.4.1
*Default gateway inaccesible
*Cable desconectado
*La máscara de la ip 192.168.0.19/16 debería ser /24

# Si hacemos wget http://google.com La capa de red es responsable:

*[ok]De que los paquetes lleguen a su destino
*De la resolución del nombre google.com
*Ninguna de las anteriores es cierta

# A partir de la orden ip a y ip r
	[admin@localhost ~]$ ip a 
	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default 
		link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00 
		inet 127.0.0.1/8 scope host lo 
		   valid_lft forever preferred_lft forever 
		inet6 ::1/128 scope host 
		   valid_lft forever preferred_lft forever 
	2: enp0s25: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast state DOWN group default qlen 1000 
		link/ether 0a:23:18:3a:9b:8a brd ff:ff:ff:ff:ff:ff 
		inet 192.168.2.55/24 scope global enp0s25 
		   valid_lft forever preferred_lft forever 
	3: wlp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000 
		link/ether 0a:26:b6:f4:52:d6 brd ff:ff:ff:ff:ff:ff 
		inet 192.168.1.131/24 brd 192.168.1.255 scope global dynamic wlp2s0 
		   valid_lft 258761sec preferred_lft 258761sec 
		inet 192.168.1.55/24 scope global secondary wlp2s0 
		   valid_lft forever preferred_lft forever 
		inet6 fe80::226:b6ff:fef4:52d6/64 scope link 
		   valid_lft forever preferred_lft forever 
	[admin@localhost ~]$ ip r s 
	default via 192.168.1.1 dev wlp2s0  proto static  metric 1024 
	192.168.1.0/24 dev wlp2s0  proto kernel  scope link  src 192.168.1.131 
	192.168.2.0/24 dev enp0s25  proto kernel  scope link  src 192.168.2.55 

 Cuando intentemos hacer un ping a 8.8.8.8:
 
*lo hará a través del router 192.168.2.55
*lo hará a través de la tarjeta enp0s25 pero como está desconectada devolverá el mensaje de Destination Host Unreachable
*[ok]lo hará saliendo por la tarjeta wlp2s0
*lo hará a través de un router en 192.168.1.0
 
# No puedo hacer pings y realizo las siguientes operaciones, donde está el fallo?
	$ ip a
	[...]
	2: p4p1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast state DOWN qlen 1000 
		link/ether 50:e5:49:cc:7d:f1 brd ff:ff:ff:ff:ff:ff 
		inet 10.4.5.6/24 scope global p4p1 
		valid_lft forever preferred_lft forever 

	$ ip r s 
	default via 10.4.5.1 dev p4p1  proto static 
	10.4.5.0/24 dev p4p1  proto kernel  scope link  src 10.4.5.6 

	$ cat /etc/resolv.conf 
	nameserver 8.8.8.8
	
*El gateway está mal definido
*El cable está desconectado
*[ok]La interfície está deshabilitada
*Máscara incorrecta

# El protocol udp es un protocolo de la capa de:

*Xarxa
*Enllaç
*[ok]Transport
*Física

# Si montamos un bridge entre dos intefaces de red, la dirección ip es mejor que la tenga:

*la primera interfaz del bridge
*la segunda interfaz del bridge
*el bridge
*[ok]cualquier interfaz menos el bridge
 
# Con un sniffer de red como wireshark no podemos:

*Detectar que hay un ataque de man in the midle en la red
*Filtrar el tráfico asociado a un puerto tcp y una ip concreta para analizarlo
*[ok]Modificar la ip de otro equipo
*Observar las peticiones de ips por dhcp en una red
