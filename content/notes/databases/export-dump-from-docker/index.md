---
title: Export Dump from docker image
menu:
  notes:
    name: Export Dump from docker image
    identifier: export-dump-from-docker-notes
    parent: databases-notes
    weight: 20
---

{{< note title="Export DB dump of a particular database to your machine">}}
Export DB dump of a particular database to your machine
```bash
$ kubectl exec {{podName}} -n {{namespace}} -- mysqldump -u {{dbUser}} -p{{password}} {{DatabaseName}} > <scriptName>.sql

# Example :
$ kubectl exec mysql-58 -n sql -- mysqldump -u root -proot USERS > dump.sql
```
{{< /note >}}