# Test a clase

## build

docker-compose up --build

## ldap

ldapwhoami -x -h 172.100.0.2 -D "uid=user01,ou=usuaris,dc=edt,dc=org" -w user01

ldapwhoami -x -h 172.100.0.2 -D "uid=user08,ou=usuaris,dc=edt,dc=org" -w user08

## radius local

radtest user01 user01 localhost 1812 testing123

radtest user08 user08 localhost 1812 testing123

## radius remot

radtest user01 user01 172.100.0.1 1812 testing123

radtest user08 user08 172.100.0.1 1812 testing123

## telefon 

user01 user01

user08 user08

---

# posibles preguntes:

radiusd.conf -> fitxer de configuració. conte configuració basica l a qual en la majoria de casos n ocal tocar. com per exemple la quantitat de request que li poden arribar o els includes de moduls.

tipus de nas -> eap

que és autenticar -> és el fet de demostrar que algu és qui diu ser.

que és autoritzar -> és el procés de decidir si aquesta persona té permis per accedir al servei.

User Datagram Protocol (UDP) és un protocol del nivell de transport

localhost Cleartext-Password := testing123
     Reply-Message = "Bienvenid@, %{User-Name}"
        #portslave

| Atribut | Significat | Valor   |
|---|---------|---|
| `ipaddr` (Obligatori) | IPv4 que utilitza el client | `int`   |
| `netmask` | Si es vol definir un conjunt de clients d'una mateixa, xarxa cal utilitzar aquest atribut | `int`   |
| `secret` (Obligatori)  | Contrasenya utilitzada per la comunicació entre el client i el servidor radius | `str`   |
| `shortname`  | Nom que se li atorga al client per fer servir en comptes de la IP o el hostname | `str`   |
| `nastype` | Tipus de tecnologia utilitzada | <code> cisco &#124; computone &#124; livingston &#124; max40xx &#124; multitech &#124; netserver &#124; pathras &#124; patton &#124; portslave &#124; tc &#124; usrhiper &#124; other </code> |
| `require_message_authenticator` | Permet al servidor requerir un `Message-Authenticator`. Si el client està obligat a enviar-lo i no ho fa, aleshores el paquet serà silenciat.  | <code>yes &#124; no </code>   |

openssl x509 -issuer -in cert