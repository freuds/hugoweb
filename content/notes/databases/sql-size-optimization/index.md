---
title: MySQL size optimization
menu:
  notes:
    name:  MySQL size optimization
    identifier: mysql-size-optimization-notes
    parent: databases-notes
    weight: 20
---

{{< note title="MySQL Size optimisation">}}
Get table size order

```sql
SELECT
  TABLE_NAME AS `Table`,
  ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024) AS `Size (MB)`
FROM
  information_schema.TABLES
WHERE
  TABLE_SCHEMA = "bookstore"
ORDER BY
  (DATA_LENGTH + INDEX_LENGTH)
DESC;
```

View optimized size by tables
```sql
SELECT table_name, data_free/1024/1024 AS data_free_MB, table_rows FROM information_schema.tables
  WHERE engine LIKE 'InnoDB';

SELECT table_schema AS "Database",
ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "Size (MB)"
FROM information_schema.TABLES
GROUP BY table_schema;
```
{{< /note >}}