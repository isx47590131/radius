# Directori radiusserver

## Què és Radius?

RADIUS significa *Remote Authentication Dial In User Service* o *Marcatge d'autenticació al servei d'usuaris*, és un protocol de xarxa que la funció principal que té és el control d'accés a la xarxa dels usuaris mitjançant l'autenticació. Les funcions principals són:

+ Autenticar usuaris o dispositius abans de permetre l'accés a la xarxa.
+ Autoritzar a usuaris o dispositius a recursos de xarxa específics.
+ Comptes per a l'ús d'aquests recosos

## Què conté el directori?

Aquest directori conté els fitxers de configuració per la posada en marxa del servidor radius en un *container* en mode debbug, és a dir, que en posar-lo en funcionament consumeix el terminal per transmetre la informació del que està passant.

+ clients.conf

    Fitxer de configuració de radius designat a gestionar els clients del servidor radius, és a dir, qui el farà servir per autenticar usuaris. El format que s'utilitza per definir clients és el següent:
    ```
    client  <nom> {
            <atribut> = <valor>
            <atribut> = <valor>
            ...
    }
    ```
  + Possibles atributs:

    | Atribut | Significat | Valor   |
    |---|---------|---|
    | `ipaddr` (Obligatori) | IPv4 que utilitza el client | `int`   |
    | `netmask` | Si es vol definir un conjunt de clients d'una mateixa, xarxa cal utilitzar aquest atribut | `int`   |
    | `secret` (Obligatori)  | Contrasenya utilitzada per la comunicació entre el client i el servidor radius | `str`   |
    | `shortname`  | Nom que se li atorga al client per fer servir en comptes de la IP o el hostname | `str`   |
    | `nastype` | Tipus de tecnologia utilitzada | <code> cisco &#124; computone &#124; livingston &#124; max40xx &#124; multitech &#124; netserver &#124; pathras &#124; patton &#124; portslave &#124; tc &#124; usrhiper &#124; other </code> |
    | `require_message_authenticator` | Permet al servidor requerir un `Message-Authenticator`. Si el client està obligat a enviar-lo i no ho fa, aleshores el paquet serà silenciat.  | <code>yes &#124; no </code>   |

+ ldap

  Fitxer de configuració radius, la seva funció és gestionar les connexions amb ldap mitjançant els paràmetres que s'indiquin. Cal destacar que s'ha d'instal·lar a part, amb l'ordre `sudo dnf -y install freeradius-ldap`. Un cop fet això tindrem el fitxer `ldap` al directori `/etc/raddb/sites-aviable/` i només caldrà configurar-lo segons el que necessitem i fer un enllaç simbòlic del fitxer al directori `/etc/raddb/sites-enabled/`.

  Les parts de codi que he modificat són les següents:

  Indico la IP que tindrà el servidor. Important si poses el *hostname* asegurar-te que esta a `/etc/hosts` del servidor radius.

 ```
 server = ldapserver
 server = '172.100.0.2'

 port = 389

 identity = 'cn=Manager,dc=edt,dc=org'
 password = jupiter

 base_dn = 'dc=edt,dc=org'
```

Per introduir tls cal crear primer una CA, i despres els cetificats (la parella key-cert) signats per aquesta CA. És important que el servidor ldap també tingui el certificat de la CA.

```
tls {
  start_tls = yes
  ca_file	= /opt/docker/certs/CAcert.pem
  certificate_file = /opt/docker/certs/radiusservercert.pem
  private_key_file = /opt/docker/certs/radiusserverkey.pem
  require_cert	= 'demand'
```