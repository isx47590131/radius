# Explicació del compose

## Què conté?

+ Docker-compose.yml

    És el fitxer on s'indica la construcció dels containers, explicaré el significat de les directives i els valors utilitzades en el meu. Cal destacar que el sistema de diferenciar directives és la identació, és a dir, una mateixa variable pot estar declarant coses diferents segons el "nivell" d'identació  que estigui. Si necessites mes ajuda consulta [aqui.](https://docs.docker.com/compose/gettingstarted/)

    | Directives    | Significat      | Valors  |
    |------------- |-------------  | ----- |
    | `version`    | Versió de docker-compose utilitzada | `int` |
    | `services`    | Comença la declaració dels serveis  | `str` |
    | <code>ldapserver &#124; radiusserver <code> | Comença la declaració de què conté cada servei |definicions d'altres directives |
    | `build`    | Indica on es troba el *Dockerfile* o la imatge en el repositori d'imatges de *DockerHub* | És troben a un subdirectori |
    | `container_name`    | Nom del container | `str` |
    | `hostname`    | Nom que se li atorga per comunicar-se en xarxa|  `str` |
    | `ports`    | Ports que seran utilitzats en el servei | `int` |
    | `networks`    | Opcions de xarxa  | `str` o definicions d'altres directives |
    | `rad_net`    | Nom que li atorgo a la xarxa i opcions que he creat | definicions d'altres directives |
    | `ipv4_address`    | Direcció IPv4 fixe | `int` |
    | `driver`    | Dispositiu de xarxa del host que utilitzarà | `str` |
    | `ipam`    | Tipus de configuració de xarxa | definicions d'altres directives de xarxa |
    | `config`    | Configuració de xarxa |  definicions d'altres directives de xarxa|
    | `subnet`    | Subxarxa la qual pertany la xarxa definida | `int` |
    |`network_mode` | Xarxa/dispositiu que utilitzarà | `bridge | host | none | service:[service name] | container:[container name/id]` |
<br>

+ Directoris

    En els directoris pots trobar tot el contingut necessari per construir cada imatge, juntament amb el Dockerfile, que indica els passos a seguir. També trobaràs un README.md on s'explica cada imatge i per a què serveix.

## Com funciona?