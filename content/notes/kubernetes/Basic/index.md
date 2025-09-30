---
title: Kube basic cmds
menu:
  notes:
    name: Basic
    identifier: kube-basic-notes
    parent: kubernetes-notes
    weight: 20
---

{{< note title="kubectl basic commands">}}

```bash
# connect on Pods
kubectl exec -it --namespace=develop my-pod-id -- /bin/ash
# Show pod network on cluster
kubectl get nodes -o jsonpath='{.items[*].spec.podCIDR}'
# Show Pods by <node>
kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=<node>
# sorting pods
kubectl get pods -o wide --sort-by="{.spec.nodeName}"
```

{{< /note >}}

{{< note title="kubernetes volume protected">}}
This happens when persistent volume is protected. You should be able to cross verify this:

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

{{< /note >}}

{{< note title="Export DB dump of a particular database to your machine">}}

```bash
$ kubectl exec {{podName}} -n {{namespace}} -- mysqldump -u {{dbUser}} -p{{password}} {{DatabaseName}} > <scriptName>.sql

# Example :
$ kubectl exec mysql-58 -n sql -- mysqldump -u root -proot USERS > dump.sql
```



{{< /note >}}