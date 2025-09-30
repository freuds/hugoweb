---
title: PromQL
weight: 10
menu:
  notes:
    name: PromQL
    identifier: promql-notes
    parent: others-notes
    weight: 20
---

{{< note title="PromQL Expressions">}}

List of operations and functions to your PromQL expressions.

Arithmetic binary operators:

```txt
\+ (addition)
\- (subtraction)
\* (multiplication)
/ (division)
% (modulo)
^ (power/exponentiation)
```

Comparison binary operators:

```txt
== (equal)
!= (not-equal)
\> (greater-than)
< (less-than)
\>= (greater-or-equal)
<= (less-or-equal)
```

Logical/set binary operators:

```txt
and (intersection)
or (union)
unless (complement)
Aggregation operators:

sum (calculate sum over dimensions)
min (select minimum over dimensions)
max (select maximum over dimensions)
avg (calculate the average over dimensions)
stddev (calculate population standard deviation over dimensions)
stdvar (calculate population standard variance over dimensions)
count (count number of elements in the vector)
count_values (count number of elements with the same value)
bottomk (smallest k elements by sample value)
topk (largest k elements by sample value)
quantile (calculate ?-quantile (0 ? ? ? 1) over dimensions)
```

Get the total memory in bytes:

```txt
node_memory_MemTotal_bytes
```

Get a sum of the total memory in bytes:

```txt
sum(node_memory_MemTotal_bytes)
```

Get a percentage of total memory used:

```txt
((sum(node_memory_MemTotal_bytes) - sum(node_memory_MemFree_bytes) - sum(node_memory_Buffers_bytes) - sum(node_memory_Cached_bytes)) / sum(node_memory_MemTotal_bytes)) * 100
```

Using a function with your query:

```txt
irate(node_cpu_seconds_total{job="node-exporter", mode="idle"}[5m])
```

Using an operation and a function with your query:

```txt
avg(irate(node_cpu_seconds_total{job="node-exporter", mode="idle"}[5m]))
```

Grouping your queries:

```txt
avg(irate(node_cpu_seconds_total{job="node-exporter", mode="idle"}[5m])) by (instance)
```

{{< /note >}}
