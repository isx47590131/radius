# FreeRadius

## Què és?

## Què conté?

Aquest directori conté els fitxers de configuració per la posada en marxa del servidor radius en un container en mode debbug, és a dir, que en posar-lo en funcionament consumeix el terminal per transmetre la informació del que està passant.

+ clients.conf

    Fitxer de configuració designat per gestionar els clients del servidor radius, és a dir, qui el farà servir per autenticar usuaris. El format que s'utilitza per definir clients és el següent:
    ```
    client  <nom> {
            <atribut> = <valor>
            <atribut> = <valor>
            ...
    }
    ```
  + Possibles atributs:

    | Atribut | significat | Valor   |
    |---|---------|---|
    | `ipaddr` (Obligatori) | IPv4 que utilitza el client | `int`   |
    | `netmask` | Si es vol definir un conjunt de clients d'una mateixa, xarxa cal utilitzar aquest atribut | `int`   |
    | `secret` (Obligatori)  | Contrasenya utilitzada per la comunicació entre el client i el servidor radius | `str`   |
    | `shortname`  | Nom que se li atorga al client per fer servir en comptes de la IP o el hostname | `str`   |
    | `nastype` | Tipus de tecnologia utilitzada | <code> cisco &#124; computone &#124; livingston &#124; max40xx &#124; multitech &#124; netserver &#124; pathras &#124; patton &#124; portslave &#124; tc &#124; usrhiper &#124; other <code> |
    | `require_message_authenticator` | Permet al servidor requerir un `Message-Authenticator`. Si el client està obligat a enviar-lo i no ho fa, aleshores el paquet serà silenciat.  | <code>yes &#124; no <code>   |
