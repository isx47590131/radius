# Dietari radius

Explicació del dia a dia del que he anat fent

### Dia 0 (20/04/2018)
Planificació del que es farà en les pròximes setmanes.
Buscar informació sobre [Radius](https://freeradius.org/documentation/ "Radius").

### Dia 1 (23/04/2018)
Buscar la informació sobre la instal·lació de freeradius en fedora24 i compatibilitat amb ldap i dockers.

### Dia 2 (25/04/2018)
Instal·lació de radius a un PC, provar l'accés des del mateix ordinador i des d'un altre amb una configuració bàsica. (Ok)

Instal·lació de radius a un docker, provar l'acces des de el Docker i des del PC host amb una configuració bàsica. (Ok)

He arribat a la conclusió que es necessita un router de proves per continuar, també és probable que calgui instal·lar un fedora posterior, perquè la versió actual (Fedora:24) no és compatible radius-ldap.

### Dia 3 (26/04/2018)
Configuració de router bàsica per sortir a internet. (OK)
Configuració del router amb radius. (no ok)

### Dia 4 (27/04/2018)
Continuar amb la configuració i connexió de mikrotik amb radius. (no ok)

### Dia 5 (02/05/2018)
Deixo aparcat el tema de mikrotik-radius fins demà, perquè he quedat amb l'Alberto Larraz per veure si em pot donar un cop de mà.
Configuració i posada en marxa del servidor ldap en docker juntament amb radius amb i sense docker.
Descartada la idea que fedora:24 no és compatible amb el mòdul de radius-ldap, tot funciona correctament.

### Dia 6 (03/05/2018)
Amb l'ajuda de l'Alberto Larraz he connectat el router mikrotik amb el servidor (local) de radius.
No valida usuaris des de ldap.

### Dia 7 (04/05/2018)
Realitzada la validació d'usuaris des del servidor docker ldap, amb l'inconvenient que s'han de guardar les passwords en text pla.

### Dia 8 (08/05/2018)
A causa de problemes amb la memòria del Mikrotik es va perdre part de la configuració, he estat arreglant-ho

### Dia 9 (09/05/2018)
Dockeritzar els servidors (ldap i radius) (no ok)

### Dia 10 (10/05/2018)
Dockeritzar els servidors (ldap i radius) i connectar-los entre si. (ok)

### Dia 11 (11/05/2018)
Connectar els servidors Dockeritzats amb el router Mikrotik. (ok)

### Dia 12 (14/05/2018)
