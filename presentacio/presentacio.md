% Sistema RADIUS per l'autenticació de dispositius de xarxa <br> ![img](octo-grad.svg)
% Arnau Esteban Contreras - isx47590131
% 23/05/2018 - @edt

---

# ÍNDEX

1. [Les tecnologies que he utilitzat](#1.-Les-tecnologies-que-he-utilitzat)

2. [Què és RADIUS?](#2.-Què-és-RADIUS?)

3. [Quin impacte té ldap?](#3.-Quin-impacte-té-ldap?)

4. [Com configurar Mikrotik?](#4.-Com-configurar-Mikrotik?)

5. [Quin paper juga Docker?](#5.-Quin-paper-juga-Docker?)

6. [Demostracions](#6.-Demostracions)

    + 6.1 [Captures](#6.1-Captures)
    + 6.2 [Pràctica](#6.2-Pràctica)

---

## 1. Les tecnologies que he utilitzat

+ RADIUS -> És tecnologia principal del projecte, que serveix principalment per autenticar i autoritzar els usuaris i a més garantir l'accés restringit a xarxes sense fil.

+ LDAP -> És l'encarregat de contenir totes les dades dels usuaris. Cal destacar que les contrasenyes estan en text pla.

+ MIKROTIK -> Rep les peticions dels usuaris i les envia al servidor radius. Segons la resposta que li retorna radius fa unes accions unes altres.

+ DOCKER I DOCKER-COMPOSE -> Té la funció d'automatitzar el build de les imatges i la posada en marxa dels containers.

+ TLS -> Xifrar la comunicació, ja que les contrasenyes les tinc en text pla.

---

## 2. Què és RADIUS?

Les sigles signifiquen *Remote Authentication Dial In User Service* i és un protocol de xarxa que té com a funció principal controlar l'accés a un recurs de xarxa mitjançant autenticacions. 

Utilitza sistemes d'autenticació externs com pot ser ldap, sql, kerberos, etc. tot hi que s'hi poden configurar usuaris en el propi servidor. Els ports que utilitza són el 1812 per autenticar i autoritzar i el 1813 per al maneig de comptes d'usuari. 

Quins son els fitxers més importants quan instal·les radius?

```
certs
clients.conf
dictionary
mods-available
mods-enabled
radiusd.conf
README.rst
sites-available
sites-enabled
users
```

---

## 2. Què és RADIUS?

Aquesta és una entrada d'un client del fitxer `clients.conf`. 

```
client mikrotik {
        ipaddr = 192.168.88.0
        netmask = 24
        secret = testing123
        shortname = mikrotik         
        require_message_authenticator = no
        nas_type = other
}
```

nas_types: <code> cisco &#124; computone &#124; livingston &#124; max40xx &#124; multitech &#124; 

netserver &#124; pathras &#124; patton &#124; 
portslave &#124; 
tc &#124; usrhiper &#124; other </code> 

---

## 2. Què és RADIUS?

<img src="server_radius.jpg">

---

## 3. Quin impacte té ldap?

Ldap és un protocol en l'àmbit d'aplicació que permet l'accés a un servei. Ldap també és considerat una base de dades a la qual poder realitzar consultes.

He reaprofitat la configuració feta a classe de sistemes, per així dedicar-li més temps a indagar sobre radius.

<img src="ldap.png" style="display: block;
    margin-left: auto;
    margin-right: auto;
    width: 40%;">

---

## 4. Com configurar Mikrotik?

A l'hora de configurar Mikrotik em va resultar una tasca complicada, perquè no hi havia gaire informació de com fer que és comuniques amb el servidor de radius. Finalment vaig trobar les directives clau per completar ña configuració:

```
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-eap management-protection=allowed 
mode=dynamic-keys name=radius radius-eap-accounting=yes 
supplicant-identity=Mikrotik tls-mode=dont-verify-certificate
/radius
add address=192.168.88.5 secret=testing123 
service=login,wireless
/user aaa
set use-radius=yes
```

---

## 5. Quin paper juga Docker?

Permet no només automatitzar tota la part de les imatges, sinó, que també t'assegures que si hi ha alguna configuració mal feta, no repercutirà en el host amfitrió.

Un altre avantatge és que si fas alguna modificació en els fitxers de configuració i has de restaurar la imatge, no comença des de zero, sinó que crea una imatge intermèdia per cada pas.

<img src="docker.png" style="display: block;
    margin-left: auto;
    margin-right: auto;
    width: 70%;">

---

## 5. Quin paper juga Docker?

El docker compose que he creat:
```
version: "3.3"
services:
        #Build para el sevidor ldap
        ldapserver:
                build: ldapserver/.
                container_name: ldapserver
                hostname: ldapserver

                ports:
                    - "389"
                    - "636"
                networks:
                    rad_net:
                        ipv4_address: 172.100.0.2
```

---

```        
        #Build para el servidor radius
        radiusserver:
                build: radiusserver/.
                container_name: radiusserver
                hostname: radiusserver
                privileged: true
                ports:
                        - "1812"
                        - "1813"
                        - "1645"
                        - "1646"
                network_mode: "host"

        #Xarxa i device
networks:
    rad_net:
        driver: bridge #enp5s0
        ipam:
            config:
                - subnet: 172.100.0.0/16
```

---

## 6. Demostracions

### 6.1 Captures

Captura sense tls.

<img src="captura-no-tls.png" style="display: block;
    margin-left: auto;
    margin-right: auto;
    width: 100%;">


---

## 6. Demostracions

### 6.1 Captures

Captura amb tls.

<img src="captura-tls.png" style="display: block;
    margin-left: auto;
    margin-right: auto;
    width: 100%;">

---

## 6. Demostracions

### 6.2 Pràctica

Usuaris de prova: user01 i user08

+ Test del build

+ Test ldap

+ Test radius local

+ Test radius remot

+ Test radius dispositiu (funciona/no funciona)

---

## Conclusions

+ La idea d'utilitzar radius per autenticar dispositius és atractiva, però és molt laboriosa i la documentació és escassa i poc descriptiva.

+ Crec que és més interessant dur a terme aquest projecte en un entorn laboral, que no pas en un entorn amb usuaris públics (com pot ser un restaurant o un centre comercial) a causa de la complicitat que comporta.

---

## Alguna petició o pregunta?

<img src="ddubtes.jpg" style="display: block;
    margin-left: auto;
    margin-right: auto;
    width: 50%;">