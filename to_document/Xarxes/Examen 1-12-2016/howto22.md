#Examen:
todo como root!
dhclient -r
systemctl stop NetworkManager


1) ip a a 10.7.22.100/24 dev enp2s0
ip a a 10.8.8.122/16 dev enp2s0

comprobar: ping 10.8.1.1
ping 10.7.22.0



2)ip a a 10.9.9.222/24 dev enp2s0
ip r a 10.6.6.0/24 via 10.9.9.1

comprobar: ping 10.6.6.2



3)tshark -i enp2s0 -c 2 -w /tmp/ping22.pcap icmp   a la vez que haces el ping para capturar paquetes
comprobar: tshark -r /tmp/ping22.pcap




4)  ip link set usb0 down
ip link set usb0 name usb22
ip link set usb22 address 44:44:44:00:00:22
ip link set usb22 up
ip a a 10.5.5.122/24 dev usb22

comprobar: ping 10.5.5.1





5)ip a f dev enp2s0
ip a f dev usb22
ip a a 172.17.0.1/16 dev usb22
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o enp2s0 -j MASQUERADE





comprobar: ip r s
[root@j22 ~]# iptables -t nat -L
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination         

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination         
MASQUERADE  all  --  anywhere             anywhere            
MASQUERADE  all  --  anywhere             anywhere            
MASQUERADE  all  --  anywhere             anywhere  






6)ping 8.8.8.8
traceroute 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gandhi-vm.informatica.escoladeltreball.org (192.168.0.5)  0.315 ms  0.277 ms  0.257 ms
 2  sw-l3.escoladeltreball.org (10.1.1.199)  12.154 ms  12.209 ms  12.194 ms
 3  10.10.1.4 (10.10.1.4)  0.576 ms  0.538 ms  0.495 ms
 4  115.red-80-58-67.staticip.rima-tde.net (80.58.67.115)  2.248 ms  2.111 ms  2.266 ms
 5  77.red-80-58-80.staticip.rima-tde.net (80.58.80.77)  17.306 ms  17.275 ms  17.206 ms
 6  1.red-80-58-106.staticip.rima-tde.net (80.58.106.1)  12.008 ms  10.570 ms  10.584 ms
 7  * * *
 8  72.14.219.20 (72.14.219.20)  10.608 ms  10.278 ms  10.482 ms
 9  72.14.232.189 (72.14.232.189)  9.797 ms  10.502 ms 72.14.234.233 (72.14.234.233)  11.124 ms
10  216.239.48.243 (216.239.48.243)  11.598 ms 216.239.48.83 (216.239.48.83)  10.444 ms 216.239.48.135 (216.239.48.135)  11.769 ms
11  google-public-dns-a.google.com (8.8.8.8)  10.923 ms  11.333 ms  11.284 ms





7) a- # netstat -utlnp | grep cups
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      1480/cupsd          
tcp6       0      0 ::1:631                 :::*                    LISTEN      1480/cupsd 


por el puerto 1480




b- en un ventana abres el firefox con la pagina wep www.meteo.cat
i en la otra haces un netstat -p | firefox

netstat -p | grep firefox 
tcp        0      0 j22.informatica.e:37608 mad06s09-in-f138.:https ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:41788 93.184.220.70:https     ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:40562 104.244.43.209:https    ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:60964 mad01s25-in-f206.:https ESTABLISHED 1884/firefox        
tcp        0      0 j22.infor:crestron-cips 93.184.220.70:https     ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:41730 93.184.220.70:https     ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:41790 93.184.220.70:https     ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:34736 par10s28-in-f14.1:https ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:60972 mad01s25-in-f206.:https ESTABLISHED 1884/firefox        
tcp        0      0 j22.inform:crestron-cip 93.184.220.70:https     ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:41786 93.184.220.70:https     ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:37006 mad01s24-in-f228.:https ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:60982 mad01s25-in-f206.:https ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:41792 93.184.220.70:https     ESTABLISHED 1884/firefox        
tcp        0      0 j22.informatica.e:58928 199.16.156.120:https    ESTABLISHED 1884/firefox        
unix  3      [ ]         STREAM     CONNECTED     32631    1884/firefox         
unix  3      [ ]         STREAM     CONNECTED     32488    1884/firefox         
unix  3      [ ]         STREAM     CONNECTED     32620    1884/firefox         
unix  3      [ ]         STREAM     CONNECTED     32621    1884/firefox         
unix  3      [ ]         STREAM     CONNECTED     33277    1884/firefox         
unix  3      [ ]         STREAM     CONNECTED     32632    1884/firefox         
unix  3      [ ]         STREAM     CONNECTED     33949    1884/firefox         
unix  3      [ ]         STREAM     CONNECTED     33950    1884/firefox  





