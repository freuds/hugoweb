---
title: LDAP
weight: 10
menu:
  notes:
    name: LDAP
    identifier: ldap-notes
    parent: databases-notes
    weight: 20
---

{{< note title="LDAP search commands">}}

```bash
# use with klist :
ldapsearch -Y GSSAPI -LLL -H ldap://ad1 -b 'dc=corp,dc=domain,dc=net'

# with password
ldapsearch -LLL -H ldap://ad1 -b "dc=corp,dc=domain,dc=net" -D "cn=administrator,cn=users,dc=corp,dc=domain,dc=net" -w mypassword

ldapsearch -LLL -H ldap://ad1 -b "dc=corp,dc=domain,dc=net" -D "CN=name,OU=users,OU=domain,DC=corp,dc=domain,dc=net" -w xxxxx
```

{{< /note >}}