# 1 Instalar wireshark

*Ejecuta*:
	
	sudo dnf -y install wireshark-gnome wireshark-cli
	
*Arranca wireshark y realiza 3 capturas que se guardarán en 3 ficheros con 
extensión .pcap y nombres:*

- 00_ping.pcap
- 00_http.pcap
- 00_https.pcap

*Las 3 capturas han de recoger el tráfico mientras:*

#### a. Ping a la ip del ordenador de profe

*Preparar el firefox para que cuando arranque vaya a una página en blanco:*

-  *Ir a: preferences -> general -> When Firefox starts: -> Show a blank page*
-  *Cerrar el firefox*

#### b. Arrancar el firefox y escribir la dirección http://netfilter.org


#### c. Arrancar el firefox y escribir la dirección https://kernel.org


# 2 Analiza con wireshark el tráfico

*Responde a las siguientes preguntas.*

### Abre **00_ping.pcap** y contesta:

#### a. Que pila de protocolos se usa para hacer un ping
Ethernet, Ip, ICPM

#### b. Cual es el tamaño de un paquete de ping
98 bytes

#### c. Cuantos bytes se dedican a la cabecera ethernet
Ethernet II, Src: Giga-Byt_49:7d:fd (14)

#### d. Cuantos bytes se dedican a la cabecera IP
14 bytes
#### e. Cual es la dirección mac del equipo del profe
Address: Giga-Byt_49:7e:7c (94:de:80:49:7e:7c)
#### f. Hay alguna trama de broadcast?? que protocolos usa??

#### g. Escribe en binario y hexadecimal la dirección IP
192.168.0.19
11000000.10101000.00000000. 0010011 binari
### Abre **00_http.pcap** y contesta:

#### h. Que pila de protocolos se usa en un paquete con http
#### i. Cual es la dirección ip del servidor web
#### j. Cual es la dirección mac destino de un paquete que va hacia una ip pública
#### k. ¿Puedes encontrar en un paquete de respuesta del servidor web cual es el título de la página web? Explica que has hecho para encontrarlo
#### l. ¿Cúantos paquetes se han recibido desde la ip del servidor?

### Abre **00_https.pcap** y contesta:

#### m. Que pila de protocolos se usa en un paquete con http
#### n. Cual es la dirección ip del servidor web
#### o. Cual es la dirección mac destino de un paquete que va hacia una ip pública
#### p. En este caso no se puede encontrar en un paquete de respuesta del servidor web cual es el título de la página web. Explica por qué crees que no se encuentra.
#### q. ¿Cúantos paquetes se han recibido desde la ip del servidor?

# 3 Realizar una captura con tshark

*Podemos realizar una captura desde línea de comandos usando tshark. 
Para conocer un poco mejor su funcionamiento podemos buscar ayuda de este
comando. En linux es habitual que haya un manual asociado que se consulta 
con la orden **man**:*

	man tshark
	
*Pero también es habitual que haya una ayuda más breve si le pasamos 
como parámetro al comando ** --help ** o la versión reducida **-h***

*La salida del comando tshark --help nos da un listado de opciones que
podemos usar:*

```
[beto@localhost exercises]$ tshark --help
TShark (Wireshark) 2.1.1 (Git Rev Unknown from unknown)
Dump and analyze network traffic.
See https://www.wireshark.org for more information.

Usage: tshark [options] ...

Capture interface:
  -i <interface>           name or idx of interface (def: first non-loopback)
  -f <capture filter>      packet filter in libpcap filter syntax
  -s <snaplen>             packet snapshot length (def: 65535)
  -p                       don't capture in promiscuous mode
  -I                       capture in monitor mode, if available
  -B <buffer size>         size of kernel buffer (def: 2MB)
  -y <link type>           link layer type (def: first appropriate)
  -D                       print list of interfaces and exit
  -L                       print list of link-layer types of iface and exit

Capture stop conditions:
  -c <packet count>        stop after n packets (def: infinite)
  -a <autostop cond.> ...  duration:NUM - stop after NUM seconds
                           filesize:NUM - stop this file after NUM KB
                              files:NUM - stop after NUM files
Capture output:
  -b <ringbuffer opt.> ... duration:NUM - switch to next file after NUM secs
                           filesize:NUM - switch to next file after NUM KB
                              files:NUM - ringbuffer: replace after NUM files
Input file:
  -r <infile>              set the filename to read from (- to read from stdin)

Processing:
  -2                       perform a two-pass analysis
  -R <read filter>         packet Read filter in Wireshark display filter syntax
  -Y <display filter>      packet displaY filter in Wireshark display filter
                           syntax
  -n                       disable all name resolutions (def: all enabled)
  -N <name resolve flags>  enable specific name resolution(s): "mnNtCd"
  -d <layer_type>==<selector>,<decode_as_protocol> ...
                           "Decode As", see the man page for details
                           Example: tcp.port==8888,http
  -H <hosts file>          read a list of entries from a hosts file, which will
                           then be written to a capture file. (Implies -W n)
  --disable-protocol <proto_name>
                           disable dissection of proto_name
  --enable-heuristic <short_name>
                           enable dissection of heuristic protocol
  --disable-heuristic <short_name>
                           disable dissection of heuristic protocol
Output:
  -w <outfile|->           write packets to a pcap-format file named "outfile"
                           (or to the standard output for "-")
  -C <config profile>      start with specified configuration profile
  -F <output file type>    set the output file type, default is pcapng
                           an empty "-F" option will list the file types
  -V                       add output of packet tree        (Packet Details)
  -O <protocols>           Only show packet details of these protocols, comma
                           separated
  -P                       print packet summary even when writing to a file
  -S <separator>           the line separator to print between packets
  -x                       add output of hex and ASCII dump (Packet Bytes)
  -T pdml|ps|psml|json|ek|text|fields
                           format of text output (def: text)
  -j <protocolfilter>      protocols layers filter if -T ek|pdml|json selected,
                           (e.g. "http tcp ip",
  -e <field>               field to print if -Tfields selected (e.g. tcp.port,
                           _ws.col.Info)
                           this option can be repeated to print multiple fields
  -E<fieldsoption>=<value> set options for output when -Tfields selected:
     bom=y|n               print a UTF-8 BOM
     header=y|n            switch headers on and off
     separator=/t|/s|<char> select tab, space, printable character as separator
     occurrence=f|l|a      print first, last or all occurrences of each field
     aggregator=,|/s|<char> select comma, space, printable character as
                           aggregator
     quote=d|s|n           select double, single, no quotes for values
  -t a|ad|d|dd|e|r|u|ud    output format of time stamps (def: r: rel. to first)
  -u s|hms                 output format of seconds (def: s: seconds)
  -l                       flush standard output after each packet
  -q                       be more quiet on stdout (e.g. when using statistics)
  -Q                       only log true errors to stderr (quieter than -q)
  -g                       enable group read access on the output file(s)
  -W n                     Save extra information in the file, if supported.
                           n = write network address resolution information
  -X <key>:<value>         eXtension options, see the man page for details
  -U tap_name              PDUs export mode, see the man page for details
  -z <statistics>          various statistics, see the man page for details
  --capture-comment <comment>
                           add a capture comment to the newly created
                           output file (only for pcapng)

```

*Implementa las órdenes que se pueden usar para los siguientes casos:*
#### a. Capturar el tráfico entrante por la interfaz de red que usamos para 
*conectarnos a internet y que lo guarde en un fichero /tmp/out1.pcap hasta
que decidamos interrumpir la captura con Ctrl + C*

#### b. Capturar el tráfico entrante durante 10 segundos

#### c. Capturar el tráfico entrante hasta llegar a 100 paquetes


# 4 Construye filtros:

### *Abre **00_http.pcap** y escribe el filtro que has de utilizar para seleccionar:*

#### a. Encontrar sólo los paquetes que lleven el protocolo HTTP
#### b. Encontrar sólo los paquetes que tienen como ip origen una dirección de la familia 192.168.0.0/16
#### c. Combinar los dos filtros anteriores para que sólo busque los paquetes que llevan cabeceras del protocolo HTTP y que tengan como ip origen una dirección de la familia 192.168.0.0/16. Guarda sólo estos paquetes filtrados en un nuevo fichero que se llame 00_http_get.pcap




### *Abre **00_ping.pcap** y aplica un filtro para :*

#### d. Buscar las tramas broadcast ethernet


#### e. Aplica un filtro al realizar la captura
*Hay que conseguir que tshark sólo capture las tramas ethernet broadcast y guarde el fichero como **00_broadcast.pcap***



