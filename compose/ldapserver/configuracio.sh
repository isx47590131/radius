#!/bin/bash
# @edt ASIX-M06 Curs 2017-2018
# ----------------------------
rm -rf /var/lib/ldap/*
rm -rf /etc/openldap/slapd.d/*
cp DB_CONFIG /var/lib/ldap/.
slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d
slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d -u
slapadd -v -F /etc/openldap/slapd.d -l /opt/docker/dataDBuid.ldif
#slapadd -v -F /etc/openldap/slapd.d -l /opt/docker/dataDBcn.ldif
chown -R ldap.ldap /var/lib/ldap
chown -R ldap.ldap /etc/openldap/slapd.d
#/opt/docker/startup.sh
#ldapmodify -a -h localhost -D'cn=Sysadmin,cn=config' -w secret -f /opt/docker/modificacions-ldif

