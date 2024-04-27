---
title: SQL useful commmands
menu:
  notes:
    name: SQL useful commmands
    identifier: sql-useful-commands-notes
    parent: databases-notes
    weight: 20
---

{{< note title="SQL useful commmands">}}
SQL useful commmands (schema)

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


{{< note title="pgSQL useful commmands">}}
Connect PostgreSQL database

```shell
psql -d database -U yser -W
psql -U user -h host "dbname=db sslmode=require"
```

Switch connection database
```text
\c dbname username
\l : list all databases
\dx : liste des extensions installées
\dt : list all tables
\d table_name : describe a table
\dn : list available schema
\dv : list available functions
\dv : list available views
\du : list all users and their assign roles

\g : execute previous command
\s <filename> : command history (save into filename)
\i filename : execute command from filename

\timing : turn on / off execution time
\e : launch EDITOR defined in your ENV
\ef <function_name> : execute a function named from editor

\a : command switches from aligned to non-aligned column output.
\H : command formats the output to HTML format.

SELECT version();
```
{{< /note >}}


{{< note title="MySQLdump with nohup">}}
Connect PostgreSQL database

```shell
sh -c 'nohup mysqldump -h mydb.hostname -u admin --triggers --routines --events --compress --all-databases --pXXXXX  > mydatabase.dmp &'
```
{{< /note >}}

{{< note title="Create user pgSQL">}}
See ROLES:
```shell
psql -U postgres -c "SELECT * FROM pg_roles;"
```

```shell
postgres=# create database mydb;
postgres=# create user myuser with encrypted password 'mypass';
postgres=# grant all privileges on database mydb to myuser;
```
{{< /note >}}

{{< note title="PostgesQL locks errors">}}
```sql
SELECT
    nom_base,
    schema_objet_locke,
    nom_objet_locke,
    type_objet_locke,
    duree_bloquage,
    pid_session_bloquante,
    user_session_bloquante,
    client_session_bloquante,
    derniere_requete_session_bloquante,
    heure_debut_session_bloquante,
    heure_debut_requete_bloquante,
    pid_session_bloquee,
    user_session_bloquee,
    client_session_bloquee,
    derniere_requete_session_bloquee,
    heure_debut_requete_bloquee,
    heure_debut_session_bloquee
FROM
(
SELECT distinct
    RANK() OVER (PARTITION BY c.pid ORDER BY g.query_start DESC) as rang,
    c.datname AS nom_base,
    e.nspname AS schema_objet_locke,
    d.relname AS nom_objet_locke,
CASE
    WHEN d.relkind IN ('t','r') THEN 'table'
    WHEN d.relkind = 'i' THEN 'index'
    WHEN d.relkind = 's' THEN 'sequence'
    WHEN d.relkind = 'v' THEN 'vue'
ELSE d.relkind::text
END AS type_objet_locke,
    TO_CHAR(now()-c.query_start,'DD')||'j '||TO_CHAR(now()-c.query_start,'HH24:MI:SS') AS duree_bloquage,
    g.pid AS pid_session_bloquante,
    g.usename AS user_session_bloquante,
    g.client_addr AS client_session_bloquante,
    g.query AS derniere_requete_session_bloquante,
    TO_CHAR(g.backend_start,'YYYYMMDD HH24:MI:SS') AS heure_debut_session_bloquante,
    TO_CHAR(g.query_start,'YYYYMMDD HH24:MI:SS') AS heure_debut_requete_bloquante,
    c.pid AS pid_session_bloquee,
    c.usename AS user_session_bloquee,
    c.client_addr AS client_session_bloquee,
    c.query AS derniere_requete_session_bloquee,
    TO_CHAR(c.query_start,'YYYYMMDD HH24:MI:SS') AS heure_debut_requete_bloquee,
    TO_CHAR(c.backend_start,'YYYYMMDD HH24:MI:SS') AS heure_debut_session_bloquee
FROM
    pg_locks AS a,
    pg_locks AS b,
    pg_stat_activity AS c,
    pg_class AS d,
    pg_namespace AS e,
    pg_locks AS f,
    pg_stat_activity AS g
WHERE a.pid = b.pid
    AND a.pid = c.pid
    AND b.relation = d.oid
    AND d.relnamespace = e.oid
    AND b.relation = f.relation
    AND b.pid <> f.pid
    AND f.pid = g.pid
    AND c.query_start >= g.query_start
    AND a.granted IS FALSE
    AND b.relation::regclass IS NOT NULL
    AND e.nspname NOT IN ('pg_catalog','pg_toast','information_schema')
    AND e.nspname NOT LIKE 'pg_temp_%'
    AND f.granted is true
) AS resultat
WHERE rang = 1
ORDER BY resultat.heure_debut_requete_bloquee,resultat.heure_debut_requete_bloquante ;
```
{{< /note >}}