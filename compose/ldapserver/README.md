# Directori ldapserver

## Què és ldap?

LDAP significa *Lightweight Directory Access Protocol* és un protocol en l'àmbit d'aplicació que permet l'accés a un servei de directori ordenat i distribuït per a cercar diversa informació en un entorn de xarxa. LDAP també és considerat una base de dades al que poden realitzar-se consultes, com és en el meu cas, en el que només es consulten les dades dels usuaris.

LDAP no descriu ​ com​ es desen les dades i es poden fer servir diversos backends diferents, com per exemple radius.

## Què conté el directori?

Aquest directori conté els fitxers de configuració per la posada en marxa del servidor ldap en un *container* en mode *detached*, és a dir, que en posar-lo en funcionament es queda funcionant en segon pla sense dependre de cap cosa.

+ dataDBuid.ldif

  Fitxer de configuració del ldap designat a contenir tot el que respecte als usuaris i als grups. Conté noms, contrasenyes, descripcions, correus, etc. Respecte a les contrasenyes han de ser-hi en text pla, ja que radius no té la capacitat per autenticar usuaris si estan encriptades.

+ DB_CONFIG

  Fitxer de configuració ldap que serveix per a la construcció de la base de dades. S'afegeix al directori `/var/lib/ldap/`.

+ slapd.conf 

  Un altre fitxer de configuració ldap que crea la base de dades corresponent a l'organització ​“edt.org”​. S'indica quins *schemas* (que són les definicions d'objectes) seran necessaris; les rutes dels certificats, per habilitar el tràfic segur; i els usuaris de monitoratge i administració ldap.

+ configuracio.sh

  Aquest script serveix per configurar tot el servidor ldap, el que fa és esborrar la configuració que ve per defecte, incorpora la creada prèviament, comprova que tot estigui correcte i genera la base de dades. També canvia el propietari perquè sigui ldap i no hi hagi possibles errors.

 + startup.sh

  Aquest fitxer serveix per a la posada en marxa del servidor en mode detached.

+ Dockerfile

  És l'encarregat d'ajuntar tots els fitxers del directori per formar una imatge, configurar-la i arrencar el servei.

  | Ordre | Utilitat | 
  |-------|----------|
  | `FROM` | Imatge original, d'un partirà la nova imatge  |
  |`MAINTAINER`| Descripció de l'encarregat de mantenir la imatge|
  | `RUN`| Executa ordres a dins del container |
  |`ADD` | Afegeix fitxers i directoris de local al container |
  | `COPY` | Copia un fitxer de local al container |
  | `CMD ` | Ordre que s'executa quan es posa en marxa el container |