# Sistema radius per autenticació de dispositius de xarxa (wireless, switch, etc.)

**Autor:** Arnau Esteban Contreras

**Id_alumne:** isx47590131

**Descripció:** Projecte que utilitza *radius* per validar usuaris provinents d'un router *Mikrotik* contra un servidor ldap.


-------

## Tecnologies utilitzades
    
    - Radius -> és la pedra angular del projecte, té inifitat d'usos, però els que jo li he donat són: 

        - Comunicació amb un servidor ldap, mitjançant un mòdul radius-ldap que permet generar la configuració 
        - Fitxer de clients, on es defineix, qui utilitzarà aquesta validació, en el meu cas serà el router, el propi host i el servidor ldap. És a dir, en aquest fitxer es defineix des de on es pot accedir al servidor radius.
        - Fitxer de default, que és bàsicament on es defineix una seu (com es fa amb l'apache), la principal. També es poden definir seus virtuals, en cas que sigui necessari
        
    
    - Ldap -> contè les dades dels usuaris creats