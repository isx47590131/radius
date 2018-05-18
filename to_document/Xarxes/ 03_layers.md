1. ip a

Borra todas las rutas y direcciones ip, para el servicio NetworkManager y asegúrate que no queda ningún demonio de dhclient corriendo. Comprueba que no queda ninguna con "ip a" y "ip r"

	# ip r f all
	# ip a f dev enp2s0
	# ip a 
	# ip r

Ponte las siguientes ips en tu tarjeta ethernet: 2.2.2.2/24, 3.3.3.3/16, 4.4.4.4/25

	# ip a a 2.2.2.2/24 dev enp2s0
	# ip a a 3.3.3.3/16 dev enp2s0
	# ip a a 4.4.4.4/25 dev enp2s0

Consulta la tabla de rutas de tu equipo

	ip r

Haz ping a las siguientes direcciones y justifica por qué en algunas sale el mensaje de "Network is unrecheable", en otras contesta y en otras se queda esperando sin dar mensajes de error:

2.2.2.2 , 2.2.2.254 , 2.2.5.2 , 3.3.3.35 , 3.3.200.45 , 4.4.4.8, 4.4.4.132


	2.2.2.2 	-> correcto
	2.2.2.254 	-> Destination Host Unreachable
	2.2.5.2 	-> Network is unreachable
	3.3.3.35	-> Destination Host Unreachable
	3.3.200.45 	-> Destination Host Unreachable
	4.4.4.8 	-> Destination Host Unreachable
	4.4.4.132 	-> Destination Host Unreachable


2. ip link

Borra todas las rutas y direcciones ip de la tarjeta ethernet

	ip link set enp2s0 down

Conecta una segunda interfaz de red por el puerto usb
Cambiale el nombre a usb0

Modifica la dirección MAC

	ip link set usb0 down
	ip link set usb0 address 00:11:22:33:44:55
	ip link set usb0 name usb3
	ip link set usb3 up

Asígnale la direcció ip 5.5.5.5/24 a usb0 y 7.7.7.7/24 a la tarjeta de la placa base.
	
	
	# ip a a 5.5.5.5/24 dev usb3
	7.7.7.7/24
Observa la tabla de rutas
	ip r



3. iperf

Borra todas las rutas y direcciones ip de la tarjeta ethernet
	
	ip a f dev enp2s0
	ip a
En cada ordenador os ponéis la ip 172.16.99.XX/24 (XX=puesto de trabajo)

Lanzar iperf en modo servidor en cada ordenador

Comprueba con netstat en qué puerto escucha

Conectarse desde otro pc como cliente

Repetir el procedimiento y capturar los 30 primeros paquetes con tshark

Encontrar los 3 paquetes del handshake de tcp

Abrir dos servidores en dos puertos distintos

Observar como quedan esos puertos abiertos con netstat

Conectarse al servidor con dos clientes y que la prueba dure 1 minuto

Mientras tanto con netstat mirar conexiones abiertas
