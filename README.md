# Sistema radius per autenticació de dispositius de xarxa

**Autor:** Arnau Esteban Contreras

**Id_alumne:** isx47590131

**Descripció:** Projecte que utilitza *radius* per validar usuaris provinents d'un router *Mikrotik* contra un servidor ldap.

-------

## Tecnologies utilitzades

- Radius -> és la pedra angular del projecte, té inifitat d'usos, però els que jo li he donat són:

    - Comunicació amb un servidor ldap, mitjançant un mòdul radius-ldap que permet generar la configuració.
    - Fitxer de clients, on es defineix, qui utilitzarà aquesta validació, en el meu cas serà el router, el propi host i el servidor ldap. És a dir, en aquest fitxer es defineix des de on es pot accedir al servidor radius.
    - Fitxer de default, que és bàsicament on es defineix una seu (com es fa amb l'apache), la principal. També es poden definir seus virtuals, en cas que sigui necessari.

- Ldap -> conté les dades dels usuaris creats (uid, gid, passwd, etc.)

- Mikrotik -> rep les peticions dels clients i les envia al servidor radius. Retorna la resposta al client, i en cas que sigui `Access-Accept` li atorga una IP connexió a internet.

- Docker -> automatitzar la construcció  i posada en marxa dels servidors radius i ldap. També serveix per aïllar-los de l'exterior i diferenciar-los tant entre ells com de l'ordinador amfitrió.

- TLS (seguretat de la capa de transport) -> mitjançant certificats, signats per una *CA* creada per mi, seguritzar la comunicació entre servidors.