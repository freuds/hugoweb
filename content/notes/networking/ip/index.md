---
title: Linux IP Command
menu:
  notes:
    name: Linux IP Command
    identifier: linux-ip-command-notes
    parent: networking-notes
    weight: 20
---

{{< note title="Syntax of IP linux command">}}
```bash
ip OBJECT COMMAND
ip [options] OBJECT COMMAND
ip OBJECT help
```

Understanding ip command OBJECTS syntax
OBJECTS can be any one of the following and may be written in full or abbreviated form:

(image)[/posts/introduction/hero.svg]

```

You can select between IPv4 and IPv6 using the following syntax:

```shell
### Only show TCP/IP IPv4  ##
ip -4 a

### Only show TCP/IP IPv6  ###
ip -6 a
```

It is also possible to specify and list particular interface TCP/IP details:

```shell
### Only show eth0 interface ###
ip a show eth0
ip a list eth0
ip a show dev eth0

### Only show running interfaces ###
ip link show up
```

{{< /note >}}
