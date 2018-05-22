# Problemas con la configuración radius y ldap

## Me una vez configurado el radius con el servidor ldap (docker) me aparece
el siguiente error:

```
(0) mschap: WARNING: No Cleartext-Password configured.  Cannot create NT-Password
(0) mschap: WARNING: No Cleartext-Password configured.  Cannot create LM-Password
(0) mschap: Client is using MS-CHAPv1 with NT-Password
(0) mschap: ERROR: FAILED: No NT/LM-Password.  Cannot perform authentication
(0) mschap: ERROR: MS-CHAP2-Response is incorrect
```

el qual esta composat de varies coses, per començar les passwords que tinc posades a ldap
estan encriptades amb SHA, i es queixa perque vol que li arribin en text pla.
Cal modificar el fitxer d'usuaris i possar les contrasenyes en text pla per que 
funcioni.



funciona
```
pradtest radius radius localhost 100 testing123
```


# Actualizar la versión de docker

>[isx47590131@i21 ~]$ sudo dnf remove docker \
>                   docker-client \
>                   docker-client-latest \
>                   docker-common \
>                   docker-latest \
>                   docker-latest-logrotate \
>                   docker-logrotate \
>                   docker-selinux \
>                   docker-engine-selinux \
>                   docker-engine
 

[isx47590131@i21 ~]$ wget https://download.docker.com/linux/fedora/24/x86_64/stable/Packages/docker-ce-17.06.0.ce-1.fc24.x86_64.rpm  

[isx47590131@i21 ~]$ sudo dnf -y install Downloads/docker-ce-17.06.0.ce-1.fc24.x86_64.rpm

https://docs.docker.com/compose/

se necessita la ip 192.168.88.5 para que se comunique el router con los servers
