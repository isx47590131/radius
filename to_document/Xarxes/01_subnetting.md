 Exercicis de Subxarxes
 
 ##### Instruccions generals:
 1. Alerta, feu tots els càlculs sense calculadora!
 2. Si necessiteu fer càlculs en un full apart, si us plau, indiqueu-m'ho en cada exercici i entregueu-me aquest full.
 3. En total hi ha 5 exercicis (reviseu totes les pàgines)
 
 ##### 1. Donades les següents adreces IP, completa la següent taula (indica les adreces de xarxa i de broadcast tant en format decimal com en binari).
 
 
 IP 				| Adreça de Xarxa | Adreça de Broadcast Extern | Rang IPs per a Dispositius 
 ---|---|---|---
 172.16.4.23/25 | 172.16.4.0	 |172.16.4.127		|		 .1 a .126
 174.187.55.6/23 |174.187.54.0  |		174.187.55.255 	|	 .1	a .254
 10.0.25.253/18 | 10.0.0.0	|	10.0.63.255		|	 .1 a .254	
 209.165.201.30/27 | 209.165.201.0	| 209.165.201.31	| .1	a .30
 
 
 ##### 2. Donada la xarxa 172.28.0.0/16, calcula la màscara de xarxa que necessites per poder fer 80 subxarxes. Tingues en compte que cada subxarxa ha de tenir capacitat per a 400 dispositius. Indica la màscara de xarxa calculada tant en format decimal com en binari.
 
 - Necessitem /23 perque tindrem 510 hosts:
 - 32 - 9 = 510 hosts
 - 2 ** 9 = 512 combinacions
 - de /16 a /23 
 - 23 - 16 = 7 bits
 - 2 ** 7= 128 subxarxes de 512 combinacions disponibles.
 - La màscara CIDR /23 en decimal = 255.255.254.0
 - La màscara CIDR /23 en binari és = 11111111.11111111.11111110.00000000
 
 
 ##### 3. Donada la xarxa 10.192.0.0
 a) Calcula la màscara de xarxa que necessites per poder adreçar 1500 dispositius. Indica-la tant en format decimal com en binari.
 
 - Per obtenir 1500 dispositius, necessitem una /21:
 - La màscara de Xarxa /21 permet tenir fins a 2046 hosts
 - 2 ** 11 = 2048 Combinacions
 - Per tant tenim hosts de sobres per adreçar 1500 dispositius
 - La màscara CIDR /21 eb decimal = 255.255.248.0
 - La màscara CIDR /21 en bonari = 11111111.11111111.11111000.00000000
 
 
 b) Si fixem l'adreça de la xarxa mare a la 10.192.0.0/10, quantes subxarxes de 1500 dispositius podrem fer?
 
 - 21 - 10 = 11 bits
 - 2 ** 11 = 2048 combinacions
 - 2 ** 11 = 2048 subxarxes de 2048 combinacions disponibles
 
 c) Si ara considerem que l'adreça de xarxa mare és la 10.192.0.0 amb la màscara de xarxa calculada a l'apartat (a), calcula la nova màscara de xarxa que permeti fer 3 subxarxes de 500 dispositius cadascuna. Indica-la tant en format decimal com en binari.
 
 - La nova màscara de xarxa és /23
 - 23 -21 = 2 bits
 - 2 ** 2 = 4 combinacions
 - 32 - 23 = 9
 - 2 ** 9 = 512 Dispositius
 - Per tant la màscara /23 permet tenir 4 subxarxes de 512 combonacions cadascuna.
 
 
 ##### 4. Donada la xarxa 10.128.0.0 i sabent que s'ha d'adreçar un total de 3250 dispositius
 a) Calcula la màscara de xarxa per crear una adreça de xarxa mare que permeti adreçar tots els dispositius indicats. Indica-la tant en format decimal com en binari.
 
 - La  màscara de la xarxa mare que permetrà adreçar tots els dispositius és la /20
 - 32 - 20 = 12 bits
 - 2 ** 12 = 4096 Dispositius
 - La màscara CIDR /20 en decimal = 255.255.240.0
 - La màscara CIDR /20 en binari = 11111111.11111111.11110000.00000000
 
 b) Calcula la nova màscara de xarxa que permeti fer 5 subxarxes amb 650 dispositius cadascuna d'elles. Indica-la tant en format decimal com en binari.
 
 - No es pot calcular, no es pot dividir prou
 
 c) Comprova que, realment, cada subxarxa pot adreçar els 650 dispositius demanats. En cas que no sigui així, quina és la capacitat màxima de dispositius de cadascuna d'aquestes xarxes? Indica la fórmula que fas anar per calcular aquesta dada.
 
 - Com que no es pot adreçcar tants dispositius a cada subxarxa.
 - Podem crear 8 subxarxes de 510 cada subxarxa.
 - Per calcular aquestes dades:
 - 32 - 23 = 9 hosts
 - 2 ** 9 = 512 dispostius
 - 23 - 20 = 3 bits
 - 2 ** 3 = 8 subxarxes
 
 d) A partir de la xarxa mare que has obtingut amb la màscara de xarxa calculada a l'apartat (a), podem fer dues subxarxes amb 1625 dispositius cadascuna d'elles? Indica els càlculs que necessites fer per raonar la teva resposta.
 
 
 
 ##### 5. Donada l'adreça de xarxa mare (AX mare) 172.16.0.0/12, s'han de calcular 6 subxarxes.
 a) Quants bits necessites per ampliar la Màscara de Xarxa (MX) per tal de poder fer aquestes 6 subxarxes?
 
 - Per fer aquestes 6 subxarxes necessitem 3 bits.
 - 15 - 12 = 3 bits
 - 2 ** 3 = 8 subxarxes
 
 b) Dóna la nova MX, tant en format decimal com en binari.
 
 - La màscara CIDR en decimal es = 255.254.0.0
 - La màscara CIDR en binari es = 11111111.11111110.00000000.00000000
 
 c) Per cada subxarxa nova que has de crear, indica
 i. L'adreça de xarxa, en format decimal i en binari
 ii. L'adreça de broadcast extern, en format decimal i en binari
 iii. El rang d'IPs per a dispositius
 
 Nom| Adreça de Xarxa | Adreça de Broadcast Extern | Rang IPs per a Dispositius
 ---|---|---|---
 Xarxa 1 | 172.16.0.0 | 172.17.255.255 | .1 a .254
 Xarxa 2 | 172.18.0.0 | 172.19.255.255 | .1 a .254
 Xarxa 3 | 172.20.0.0 | 172.21.255.255 | .1 a .254
 Xarxa 4 | 172.22.0.0 | 172.23.255.255 | .1 a .254
 Xarxa 5 | 172.24.0.0 | 172.25.255.255 | .1 a .254
 Xarxa 6 | 172.26.0.0 | 172.27.255.255 | .1 a .254
 
 
 d) Tenint en compte el número de bits que has indicat en l'apartat a), quantes subxarxes podríem fer, realment? Dóna'n la fórmula que s'utilitza per calcular aquesta dada.
 
 - 15 - 12 = 3 bits
 - 2 ** 3 = 8 subxarxes
 
 e) Segons la MX que has calculat als apartats a) i b), quants dispositius pot tenir cada subxarxa? Dóna'n la fórmula que s'utilitza per calcular aquesta dada.
 
 - 32 - 15 = 17 bits
 - 2 ** 17 = 131068 Dispositius
 
 ##### 6. Donada l'adreça de xarxa mare (AX mare) 192.168.1.0/24, s'han de calcular 4 subxarxes.
 
 a) Quants bits necessites per ampliar la Màscara de Xarxa (MX) per tal de poder fer aquestes 6 subxarxes?
 
 - Necessitem 3 bits
 
 b) Dóna la nova MX, tant en format decimal com en binari.
 
 - La màscara CIDR /27 en decimal es: 255.255.255.224
 - La màscara CIDR /27 en binari es: 11111111.11111111.11111111.11100000
 
 c) Per cada subxarxa nova que has de crear, indica
 i. L'adreça de xarxa, en format decimal i en binari
 ii. L'adreça de broadcast extern, en format decimal i en binari
 iii. El rang d'IPs per a dispositius
 
 Nom| Adreça de Xarxa | Adreça de Broadcast Extern | Rang IPs per a Dispositius
 ---|---|---|---
 Xarxa 1 | 192.168.0.0 | 192.168.0.31 | .1 a .30 
 Xarxa 2 | 192.168.0.32 | 192.168.0.63 | .33 a .62
 Xarxa 3 | 192.168.0.64 | 192.168.0.95 | .65 a .94
 Xarxa 4 | 192.168.0.96 | 192.168.0.127| .97 a .126 
 
 
 d) Tenint en compte el número de bits que has indicat en l'apartat a), podríem fer més de 4 subxarxes? Dóna'n la fórmula que has utilitzat per respondre a la pregunta.
 
 - Si podriem fer fins a 8 subxarxes
 
 
 e) Segons la MX que has calculat als apartats a) i b), quants dispositius pot tenir cada subxarxa? Dóna'n la fórmula que s'utilitza per calcular aquesta dada.
 
 - Com que per cada subxarxa restem 2 bits per rangs ip, al final tenim 240 hosts útils.

    @isx47590131
