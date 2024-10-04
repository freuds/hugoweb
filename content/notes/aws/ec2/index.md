---
title: AWS Tips
menu:
  notes:
    name: AWS Tips
    identifier: aws-tips-notes
    parent: aws-notes
    weight: 20
---

{{< note title="List of assigned IPs in subnet">}}
EC2: List of assigned IPs in subnet

```shell
aws ec2 describe-network-interfaces
    --filters "Name=subnet-id,Values=<subnet-id>"
    --query 'NetworkInterfaces[*].PrivateIpAddress'
```
{{< /note >}}

{{< note title="How to make EC2 user data script run again on startup?">}}
How to make EC2 user data script run again on startup?
```shell
rm /var/lib/cloud/instances/*/sem/config_scripts_user
rm /var/lib/cloud/instance/sem/config_scripts_user
```
{{< /note >}}