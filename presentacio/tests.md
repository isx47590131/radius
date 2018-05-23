# Test a clase

## build

docker-compose up --build

## ldap

ldapwhoami -x -h 172.100.0.2 -D "uid=user01,ou=usuaris,dc=edt,dc=org" -w user01

ldapwhoami -x -h 172.100.0.2 -D "uid=user08,ou=usuaris,dc=edt,dc=org" -w user08

## radius local

radtest user01 user01 localhost 1812 testing123

radtest user08 user08 172.100.0.1 1812 testing123

## radius remot

radtest user01 user01 172.100.0.1 1812 testing123

radtest user08 user08 172.100.0.1 1812 testing123

## telefon 

user01 user01

user08 user08

---

# posibles preguntes:

radiusd.conf -> fitxer de configuració. conte configuració basica l a qual en la majoria de casos n ocal tocar. com per exemple la quantitat de request que li poden arribar o els includes de moduls.

User Datagram Protocol (UDP) és un protocol del nivell de transport