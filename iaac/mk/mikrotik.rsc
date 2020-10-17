#!/bin/bash

# https://wiki.mikrotik.com/wiki/Manual:Configuration_Management#Automatic_Import
# curl -T name.auto.rsc ftp://192.168.1.136 --user admin:
# /export compact file=configuracion.rsc
# import file-name=name.auto.rsc

# Establecemos el hostname
/system identity set name="MikroTik Proxmox"

#system package enable ipv6
#:execute {/system reboot;}

# Vemos las interfaces disponibles
#/interface print


# PRECAUCION, SI NO HAY OTRO MODO DE ACCESO SE PIERDE LA CONEXION
/ip dhcp-client remove numbers=0
/ip address add address=192.168.1.253/24 interface=ether1 comment="WAN"
/interface ethernet set ether1 auto-negotiation=no full-duplex=yes speed=100Mbps
# Routa estatica de salia a internet
/ip route add dst-address=0.0.0.0/0 gateway=192.168.1.1 comment="Default gateway"


/interface vlan add vlan-id=10 interface=ether2 name=vlan10 comment="VLAN LAN"
/ip address add address=10.10.0.1/24 interface=vlan10 comment="LAN"
/ip address add address=10.10.10.1/30 interface=ether2 comment="LAN Proxy"
/ip address add address=10.10.11.1/24 interface=ether2 comment="LAN PC"
/interface ethernet set ether2 auto-negotiation=no full-duplex=yes speed=100Mbps


/interface vlan add vlan-id=20 interface=ether3 name=vlan20 comment="VLAN DMZ"
/ip address add address=10.20.0.1/24 interface=vlan20 comment="DMZ"
/interface ethernet set ether3 auto-negotiation=no full-duplex=yes speed=100Mbps


/interface vlan add vlan-id=30 interface=ether4 name=vlan30 comment="VLAN IPS"
/ip address add address=10.30.0.1/30 interface=vlan30 comment="IPS Port Mirroning"
/interface ethernet set ether4 auto-negotiation=no full-duplex=yes speed=100Mbps
#### no funciona con la nueva version
/interface ethernet switch set numbers=0 mirror-source=ether2 mirror-target=ether4

/ipv6 address add address=3fb7::1/64 interface=vlan10 comment="LAN IPv6" advertise=yes 


/ip firewall nat add chain=srcnat src-address=10.10.0.0/24 out-interface=ether1 action=masquerade comment="NAT LAN"
/ip firewall nat add chain=srcnat src-address=10.10.10.0/24 out-interface=ether1 action=masquerade comment="NAT Proxy"
#/ip firewall nat add chain=srcnat src-address=10.10.11.0/24 out-interface=ether1 action=masquerade comment="NAT PCs"
/ip firewall nat add chain=srcnat src-address=10.20.0.0/24 out-interface=ether1 action=masquerade comment="NAT DMZ"
/ip firewall nat add chain=srcnat src-address=10.30.0.0/30 out-interface=ether1 action=masquerade comment="NAT IPS"
/ip firewall nat add chain=srcnat src-address=10.40.0.0/24 out-interface=ether1 action=masquerade comment="NAT LAB"



/ip dhcp-server network add address=10.10.11.0/24 gateway=10.10.11.1 dns-server=1.1.1.1,9.9.9.9 comment="Network LAN"
/ip pool add ranges=10.10.11.100-10.10.11.200 name=pool_lan comment="Pool LAN"
/ip dhcp-server add interface=ether2 address-pool=pool_lan name="dhcp_lan" authoritative=yes
/ip dhcp-server enable "dhcp_lan"


/ip dhcp-server network add address=10.40.0.0/24 dns-server=1.1.1.1,9.9.9.9 comment="Network LAB"
/ip pool add ranges=10.40.0.100-10.40.0.200 name=pool_lab comment="Pool LAB"
/ip dhcp-server add interface=ether5 address-pool=pool_lab name="dhcp_lab" authoritative=yes
/ip dhcp-server enable "dhcp_lab"



/ipv6 pool add prefix=3fb7::/64 prefix-length=68 name="pool_lan" comment="Pool Lan IPv6"
/ipv6 dhcp-server add interface=vlan10 address-pool=pool_lan name="dhcp_lan_ipv6" comment="DHCP Lan IPV6"
# Configuracion de los RA
/ipv6 nd prefix add prefix=::/64 interface=vlan10 on-link=yes autonomous=no
/ipv6 nd add interface=vlan10 managed-address-configuration=yes other-configuration=yes advertise-dns=yes retransmit-interval=15 
