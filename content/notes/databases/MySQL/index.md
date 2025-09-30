---
title: MySQL commmands
menu:
  notes:
    name: MySQL
    identifier: mysql-notes
    parent: databases-notes
    weight: 20
---

{{< note title="MySQLdump with nohup">}}
Connect PostgreSQL database

```bash
sh -c 'nohup mysqldump -h mydb.hostname -u admin --triggers --routines --events --compress --all-databases --pXXXXX  > mydatabase.dmp &'
```

{{< /note >}}

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

{{< note title="SQL useful commmands">}}
For schema:

```sql
SELECT default_character_set_name FROM information_schema.SCHEMATA
WHERE schema_name = "schemaname";
```

For tables:

```sql
SELECT CCSA.character_set_name FROM information_schema.`TABLES` T,
       information_schema.`COLLATION_CHARACTER_SET_APPLICABILITY` CCSA
WHERE CCSA.collation_name = T.table_collation
  AND T.table_schema = "schemaname"
  AND T.table_name = "tablename";
```

For Columns:

```sql
SELECT character_set_name FROM information_schema.`COLUMNS`
WHERE table_schema = "schemaname"
  AND table_name = "tablename"
  AND column_name = "columnname";
```

{{< /note >}}

{{< note title="MySQLdump with nohup">}}

```bash
sh -c 'nohup mysqldump -h mydb.hostname -u admin --triggers --routines --events --compress --all-databases --pXXXXX  > mydatabase.dmp &'
```

{{< /note >}}

{{< note title="MySQL Grant">}}

```sql
> create user 'root'@'%' IDENTIFIED BY 'password'
> grant all privileges on *.* to 'root'@'%' with grant option;
> flush privileges;
> show grants for current_user;
```

{{< /note >}}
