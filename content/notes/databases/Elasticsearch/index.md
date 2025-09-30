---
title: ElasticSearch
weight: 10
menu:
  notes:
    name: ElasticSearch
    identifier: elasticsearch-notes
    parent: databases-notes
    weight: 20
---

{{< note title="Get cluster allocation">}}

```bash
GET _cluster/allocation/explain\?pretty
````

{{< /note >}}

{{< note title="Get shards status">}}

```bash
GET _cat/shards?v=true&h=index,shard,prirep,state,node,unassigned.reason&s=state
````

{{< /note >}}

{{< note title="Get category health">}}

```bash
GET _cat/health?v
````

{{< /note >}}

{{< note title="Get indices">}}

```bash
GET _cat/indices?v
````

{{< /note >}}

{{< note title="ElasticSearch Backup/Restore">}}

Create or update snapshot repository API
> PUT /_snapshot/my_repository

```json
{
  "type": "fs",
  "settings": {
    "location": "my_backup_location"
  }
}
```

{{< /note >}}

{{< note title="Verify snapshot repository">}}

```bash
POST /_snapshot/my_repository/_verify
````

{{< /note >}}

{{< note title="Repository analysis">}}

```bash
POST /_snapshot/my_repository/_analyze?blob_count=10&max_blob_size=1mb&timeout=120s
```

{{< /note >}}

{{< note title="Get snapshot repository">}}

```bash
GET /_snapshot/my_repository
```

{{< /note >}}

{{< note title="Delete snapshot repo">}}

```bash
DELETE /_snapshot/my_repository
```

{{< /note >}}

{{< note title="Cleanup snapshot repo">}}

```bash
POST /_snapshot/my_repository/_cleanup
```

{{< /note >}}

{{< note title="Clone snapshot">}}
PUT /_snapshot/my_repository/source_snapshot/_clone/target_snapshot

```json
{
  "indices": "index_a,index_b"
}
```

{{< /note >}}

{{< note title="Create snapshot">}}

```bash
PUT /_snapshot/my_repository/my_snapshot
```

{{< /note >}}

{{< note title="Get snapshot">}}

```bash
GET /_snapshot/my_repository/my_snapshot
```

{{< /note >}}

{{< note title="Restore snapshot">}}

```bash
POST /_snapshot/my_repository/my_snapshot/_restore
```

{{< /note >}}

{{< note title="Delete snapshot">}}

```bash
DELETE /_snapshot/my_repository/my_snapshot
```

{{< /note >}}

{{< note title="List snapshots for one repo">}}

```bash
GET /_cat/snapshots/repo1?v=true&s=id
```

{{< /note >}}
