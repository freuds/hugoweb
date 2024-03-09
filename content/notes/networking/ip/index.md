---
title: Linux IP Command
menu:
  notes:
    name: Linux IP Command
    identifier: notes-linux-ip-command
    parent: notes-networking
    weight: 20
---

{{< note title="Syntax of IP linux command">}}
```bash
ip OBJECT COMMAND
ip [options] OBJECT COMMAND
ip OBJECT help
```

{{< /note >}}
Understanding ip command OBJECTS syntax
OBJECTS can be any one of the following and may be written in full or abbreviated form:

| Object    | Abbreviated form | Purpose                                            |
|-----------|------------------|----------------------------------------------------|
| Link      |         l        | Network device                                     |
| address   |     a<br>addr    | Protocol (IP or IPv6) address on a device          |
| addrlabel |       addrl      | Label configuration for protocol address selection |
| neighbour |    n<br>neigh    | ARP or NDISC cache entry.                          |
| route     |         r        | Routing table entry.                               |
| rule      |        ru        | Rule in routing policy database.                   |
| maddress  |    m<br>maddr    | Multicast address.                                 |
| mroute    |        mr        | Multicast routing cache entry.                     |
| tunnel    |         t        | Tunnel over IP.                                    |
| xfrm      |         x        | Framework for IPsec protocol.                      |

