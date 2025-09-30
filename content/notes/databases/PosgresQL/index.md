---
title: pgSQL commmands
menu:
  notes:
    name: pgSQL
    identifier: pgsql-notes
    parent: databases-notes
    weight: 20
---

{{< note title="pgSQL useful commmands">}}
Connect PostgreSQL database

```bash
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

{{< note title="Create user pgSQL">}}

```bash
# See ROLES
psql -U postgres -c "SELECT * FROM pg_roles;"
```

```bash
postgres=# create database mydb;
postgres=# create user myuser with encrypted password 'mypass';
postgres=# grant all privileges on database mydb to myuser;
```

{{< /note >}}

{{< note title="Check Database Size in PostgreSQL">}}

```bash
postgres=# connect mydb;
postgres=# SELECT pg_size_pretty(pg_database_size('mydb'));
```

{{< /note >}}

{{< note title="Check Tables Size in PostgreSQL">}}

```bash
postgres=# connect mydb;
mydb=# SELECT pg_size_pretty( pg_total_relation_size('mytbl'));
```

{{< /note >}}

{{< note title="PostgeSQL locks errors">}}

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

{{< note title="Backup/Restore for PostgreSQL">}}

```bash
# Backup single database
pg_dump my_database > my_database.sql
# Restore single database
psql my_database < my_database.sql

# Backup All databases
pg_dumpall > alldb.sql
# Restore All databases
psql < alldb.sql

# Backup Compressed database
pg_dump mydb | gzip > mydb.sql.gz
# Restore compressed database
gunzip -c mydb.sql.gz | psql mydb
```

{{< /note >}}
