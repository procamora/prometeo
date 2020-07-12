#!/bin/bash


# Establecemos el hostname
system identity set name="MikroTik Proxmox"


# Vemos las interfaces disponibles
interface print


# PRECAUCION, SI NO HAY OTRO MODO DE ACCESO SE PIERDE LA CONEXION
ip dhcp-client remove numbers=0
ip address add address=192.168.1.253/24 interface=ether0 comment="WAN"
interface ethernet set ether0 auto-negotiation=no  full-duplex=yes speed=100Mbps
ip route add dst-address=0.0.0.0/0 gateway=192.168.1.1 comment="Default gateway"   # Routa estatica de salia a internet



ip address add address=10.1.1.1/24 interface=ether1 comment="LAN"
interface ethernet set ether1 auto-negotiation=no  full-duplex=yes speed=100Mbps


ip address add address=10.2.1.1/24 interface=ether2 comment="DMZ"
interface ethernet set ether2 auto-negotiation=no  full-duplex=yes speed=100Mbps


interface vlan add vlan-id=5 interface=ether3 name="vlan5" comment="IPS"
ip address add address=10.3.1.1/30 interface=vlan5 comment="IPS Port Mirroning"
interface ethernet set ether3 auto-negotiation=no  full-duplex=yes speed=100Mbps
interface ethernet switch set numbers=0 mirror-source=ether1 mirror-target=ether3


ipv6 address add address=3fb7::1/64 interface=ether1 comment="LAN IPv6" advertise=yes 


ip firewall nat add chain=srcnat  src-address=10.1.1.0/24  out-interface=ether0 action=masquerade comment="NAT LAN"
ip firewall nat add chain=srcnat  src-address=10.1.2.0/24  out-interface=ether0 action=masquerade comment="NAT DMZ"
ip firewall nat add chain=srcnat  src-address=10.1.3.0/30  out-interface=ether0 action=masquerade comment="NAT IPS"



ip dhcp-server network add address=10.1.1.0/24 gateway=10.1.1.1 dns-server=1.1.1.1,9.9.9.9 comment="Network LAN"
ip pool add ranges=10.1.1.100-10.1.1.200 name=pool_lan comment="Pool LAN"
ip dhcp-server add interface=ether1 address-pool=pool_lan name="dhcp_lan" authoritative=yes
ip dhcp-server enable "dhcp_lan"


ipv6 pool add prefix=3fb7::/64 prefix-length=68 name="pool_lan" comment="Pool Lan IPv6"
ipv6 dhcp-server add interface=ether1 address-pool=pool_lan name="dhcp_lan_ipv6" comment="DHCP Lan IPV6"
# Configuracion de los RA
ipv6 nd prefix add prefix=::/64 interface=ether1 on-link=yes autonomous=no
ipv6 nd add interface=ether1 managed-address-configuration=yes other-configuration=yes advertise-dns=yes retransmit-interval=15 
