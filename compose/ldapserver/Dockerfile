# @isx47590131 projecte
# isx47590131/radius:ldapserver
# servivor ldap creació deatach
# --------------------------------
FROM fedora:24
MAINTAINER isx47590131 "@isx47590131 projecte"
RUN dnf -y update vi
RUN dnf -y install vim procps iputils iproute tree nmap mlocate man-db \
        openldap openldap-clients openldap-servers freeradius-client \
	freeradius-utils hostname
RUN mkdir -p /opt/docker/certs
ADD . /opt/docker
RUN rm /var/run/nologin
RUN chmod +x /opt/docker/startup.sh /opt/docker/configuracio.sh
RUN /opt/docker/configuracio.sh &> /dev/null
WORKDIR /opt/docker 
CMD ["/opt/docker/startup.sh"]

