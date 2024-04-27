---
title: Mac OSX
weight: 10
menu:
  notes:
    name: Mac OSX
    identifier: macosx-notes
    parent: system-notes
    weight: 10
---

{{< note title="Flush DNS MacOSx">}}
```shell
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```

{{< /note >}}

{{< note title="Openlens block update">}}
[Openlens github](https://github.com/MuhammedKalkan/OpenLens)
```shell
sudo chmod -R 000 ~/Library/Application\ Support/Caches/open-lens-updater/pending
```

{{< /note >}}