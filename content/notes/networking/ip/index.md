---
title: IP Command
menu:
  notes:
    name: IP Command
    identifier: linux-ip-command-notes
    parent: networking-notes
    weight: 20
---

{{< note title="IP linux command">}}

Understanding ip command OBJECTS syntax
OBJECTS can be any one of the following and may be written in full or abbreviated form:

- Link: Network device (l)
- address: Protocol (IP or IPv6) address on a device (a)
- addrlabel: Label configuration for protocol address selection (addrl)
- neighbour: ARP or NDISC cache entry (neigh)
- route: Routing table entry (r)
- rule: Rule in routing policy database (ru)
- maddress: Multicast address (maddr)
- mroute: Multicast routing cache entry (mr)
- tunnel: Tunnel over IP (t)
- xfrm: Framework for IPsec protocol (x)

```bash
ip OBJECT COMMAND
ip [options] OBJECT COMMAND
ip OBJECT help
```

You can select between IPv4 and IPv6 using the following syntax:

```bash
# Only show TCP/IP IPv4
ip -4 a

# Only show TCP/IP IPv6
ip -6 a
```

It is also possible to specify and list particular interface TCP/IP details:

```bash
# Only show eth0 interface
ip a show eth0
ip a list eth0
ip a show dev eth0

# Only show running interfaces
ip link show up
```

IP route add network command examples

```bash
ip route add {NETWORK/MASK} via {GATEWAYIP}
ip route add {NETWORK/MASK} dev {DEVICE}
ip route add default {NETWORK/MASK} dev {DEVICE}
ip route add default {NETWORK/MASK} via {GATEWAYIP}
```

{{< /note >}}
