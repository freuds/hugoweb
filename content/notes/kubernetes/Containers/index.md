---
title: Containers Notes
menu:
  notes:
    name: Containers
    identifier: containers-notes
    parent: kubernetes-notes
    weight: 20
---

{{< note title="Find all images inside containers">}}

```bash
kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" |\
tr -s '[[:space:]]' '\n' |\
sort |\
uniq -c
```

{{< /note >}}

{{< note title="Get Limit Requests for all containers">}}

```bash
kubectl get pod --all-namespaces --sort-by='.metadata.name' -o json | \
jq -r '[.items[] | {pod_name: .metadata.name, containers: .spec.containers[] | \
[ {container_name: .name, memory_requested: .resources.requests.memory, cpu_requested: .resources.requests.cpu} ] }]' | \
jq  'sort_by(.containers[0].cpu_requested)'
```

{{< /note >}}

{{< note title="K8S list all container's image from a cluster">}}

```bash
kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" |\
tr -s '[[:space:]]' '\n' |\
sort |\
uniq -c
```

{{< /note >}}

{{< note title="kubectl check secrets certificates">}}

```bash
kubectl get secret CERTNAME -o "jsonpath={.data['tls\.crt']}" | base64 -D | openssl x509 -enddate -noout
```

{{< /note >}}

{{< note title="kubernetes volume protected">}}
kubernetes volume protected

This happens when persistent volume is protected. You should be able to cross verify this:

Command:
```bash
kubectl describe pvc PVC_NAME | grep Finalizers

Output:
Finalizers:    [kubernetes.io/pvc-protection]
```

You can fix this by setting finalizers to null using kubectl patch:
```bash
kubectl patch pvc PVC_NAME -p '{"metadata":{"finalizers": []}}' --type=merge
```
{{< /note >}}

{{< note title="EKS CPUthrotting">}}
```bash
docker run --cpus CPUS -it python python -m timeit -s 'import hashlib' -n 10000 -v 'haslib.sha512().update(b"foo")'
```

{{< note title="Export DB dump of a particular database to your machine">}}
Export DB dump of a particular database to your machine

```bash
$ kubectl exec {{podName}} -n {{namespace}} -- mysqldump -u {{dbUser}} -p{{password}} {{DatabaseName}} > <scriptName>.sql

# Example :
$ kubectl exec mysql-58 -n sql -- mysqldump -u root -proot USERS > dump.sql
```

{{< /note >}}

{{< /note >}}