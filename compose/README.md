# Explicació del compose

## Què conté?

+ Docker-compose.yml

    És el fitxer on s'indica la construcció dels *containers*, explicaré el significat de les directives i els valors utilitzats en el meu. Cal destacar que el sistema de diferenciar directives és la identació, és a dir, una mateixa variable pot estar declarant coses diferents segons el "nivell" d'identació  que estigui. Si necessites mes ajuda consulta [aqui.](https://docs.docker.com/compose/gettingstarted/)

    | Directives    | Significat      | Valors  |
    |------------- |-------------  | ----- |
    | `version`    | Versió de docker-compose utilitzada | `int` |
    | `services`    | Comença la declaració dels serveis  | `str` |
    | <code>ldapserver &#124; radiusserver <code> | Comença la declaració de què conté cada servei |definicions d'altres directives |
    | `build`    | Indica on es troba el *Dockerfile*, que és el fixer per la creació del container | És troben a un subdirectori |
    | `container_name`    | Nom del *container* | `str` |
    | `hostname`    | Nom que se li atorga per comunicar-se en xarxa|  `str` |
    | `ports`    | Ports que seran utilitzats en el servei | `int` |
    | `networks`    | Opcions de xarxa  | `str` o definicions d'altres directives |
    | `rad_net`    | Nom que li atorgo a la xarxa i opcions que he creat | definicions d'altres directives |
    | `ipv4_address`    | Direcció IPv4 fixe | `int` |
    | `driver`    | Dispositiu de xarxa del host que utilitzarà | `str` |
    | `ipam`    | Tipus de configuració de xarxa | definicions d'altres directives de xarxa |
    | `config`    | Configuració de xarxa |  definicions d'altres directives de xarxa|
    | `subnet`    | Subxarxa la qual pertany la xarxa definida | `int` |
    |`network_mode` | Xarxa/dispositiu que utilitzarà | <code> bridge &#124; host &#124; none &#124; service:[service name] &#124; container:[container name/id] <code> |


+ Directoris

    En els directoris pots trobar tot el contingut necessari per construir cada imatge, juntament amb el Dockerfile, que indica els passos a seguir. També trobaràs un README.md on s'explica cada imatge i per a què serveix.

<br>

## Com funciona?

El Docker-compose s'encarrega de fer les imatges, els contenidors i posar-los en funcionament. En ell s'indica la construcció dels contenidors amb les opcions que siguin necessàries, tant si la imatge existeix o si la crea al moment (en aquest cas caldrà que hi hagi un Dockerfile per cada imatge/contenidor que es vulgui crear). Has de tenir cura que les opcions que posis estiguin disponibles per la versió de compose que estiguis utilitzant, perquè si no és molt probable que et sorgeixin errors.

Amb l'ordre `docker-compose up --build` et crea els contenidors si no existeixen o si hi ha hagut alguna modificació en la imatge o en els directoris de construcció. Per contra si no indiques `--build` utilitzarà els contenidors ja creats.

## Quina utilitat té?

En el cas que vulguis tenir diversos contenidors funcionant alhora, la millor opció que tens és utilitzar el compose, perquè et permet automatitzar la creació de les imatges, la creació dels contenidors i la posada en marxa dels mateixos.

## Repositori de *DOCKERHUB*

Si voleu utilitzar les imatges ja creades al repositori de DockerHub només heu de fer un `docker pull isx47590131/radius:ldapserver` per al servidor ldap o `docker pull isx47590131/radius:radiusserver` per al servidor de radius.