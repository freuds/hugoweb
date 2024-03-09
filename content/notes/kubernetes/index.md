---
title: Kubernetes Notes
menu:
  notes:
    name: Kubernetes
    identifier: notes-kubernetes
    weight: 10
---

{{< note title="Find all images inside containers">}}
Find all images inside containers
```bash
kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" |\
tr -s '[[:space:]]' '\n' |\
sort |\
uniq -c
```
{{< /note >}}

{{< note title="">}}
Get Limit Requests for all containers
```bash
kubectl get pod --all-namespaces --sort-by='.metadata.name' -o json | \
jq -r '[.items[] | {pod_name: .metadata.name, containers: .spec.containers[] | \
[ {container_name: .name, memory_requested: .resources.requests.memory, cpu_requested: .resources.requests.cpu} ] }]' | \
jq  'sort_by(.containers[0].cpu_requested)'
```
{{< /note >}}