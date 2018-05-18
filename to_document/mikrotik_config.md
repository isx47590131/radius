#configuracion mikrotik:



/ip pool add name=radius ranges=10.17.0.10-10.117.0.254
/ip address add address=10.17.0.1/24
/ip route add dst-address=0.0.0.0/0 gateway=192.168.0.1
/ip dhcp-server network add dns-server=8.8.8.8 gateway=10.17.0.1 netmask=24 domain=edt.org address=10.17.0.0/24 
/ip dhcp-server add address-pool=radius interface=wlan1 use-radius=yes
/ip firewall nat add chain=srcnat action=masquerade out-interface=wlan1 
/radius add address=192.168.88.5 secret=testing123 service=login 
/ppp aaa set use-radius=yes
/ip hotspot profile set default use-radius=yes


#######################################################################
# 				Configuración funcional								  #
#######################################################################
# may/10/2018 08:37:34 by RouterOS 6.42.1
# software id = IXL6-P765
#
# model = RouterBOARD 941-2nD
# serial number = 705C0665226F
/interface bridge
add admin-mac=6C:3B:6B:BF:11:4A auto-mac=no comment=defconf name=bridge
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-eap management-protection=allowed mode=dynamic-keys name=radius radius-eap-accounting=yes supplicant-identity=Mikrotik \
    tls-mode=dont-verify-certificate
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n channel-width=20/40mhz-Ce disabled=no distance=indoors frequency=auto mode=ap-bridge security-profile=\
    radius ssid=RadiusTest wireless-protocol=802.11
/ip dhcp-server
add disabled=no interface=bridge name=defconf
/interface bridge port
add bridge=bridge comment=defconf interface=ether2
add bridge=bridge comment=defconf interface=ether3
add bridge=bridge comment=defconf interface=ether4
add bridge=bridge comment=defconf interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=LAN
/interface list member
add comment=defconf interface=bridge list=LAN
add comment=defconf interface=ether1 list=WAN
/ip address
add address=192.168.88.1/24 comment=defconf interface=bridge network=192.168.88.0
/ip dhcp-client
add comment=defconf dhcp-options=hostname,clientid disabled=no interface=ether1
/ip dhcp-server network
add address=192.168.88.0/24 comment=defconf gateway=192.168.88.1
/ip dns
set allow-remote-requests=yes
/ip dns static
add address=192.168.88.1 name=router.lan
/ip firewall filter
add action=accept chain=input comment="defconf: accept established,related,untracked" connection-state=established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=drop chain=input comment="defconf: drop all not coming from LAN" in-interface-list=!LAN
add action=accept chain=forward comment="defconf: accept in ipsec policy" ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" connection-state=established,related
add action=accept chain=forward comment="defconf: accept established,related, untracked" connection-state=established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" connection-state=invalid
add action=drop chain=forward comment="defconf:  drop all from WAN not DSTNATed" connection-nat-state=!dstnat connection-state=new in-interface-list=WAN
/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" ipsec-policy=out,none out-interface-list=WAN
/radius
add address=192.168.88.5 secret=testing123 service=login,wireless
/system clock
set time-zone-name=Europe/Madrid
/system routerboard settings
set silent-boot=no
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
/user aaa
set use-radius=yes


#----------------------------------------------------------------------------


