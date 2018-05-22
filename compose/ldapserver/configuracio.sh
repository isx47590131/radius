#!/bin/bash
# @isx47590131 Projecte radius
# ----------------------------
rm -rf /var/lib/ldap/*
rm -rf /etc/openldap/slapd.d/*
cp DB_CONFIG /var/lib/ldap/.
slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d
slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d -u
slapadd -v -F /etc/openldap/slapd.d -l /opt/docker/dataDBuid.ldif
chown -R ldap.ldap /var/lib/ldap
chown -R ldap.ldap /etc/openldap/slapd.d

