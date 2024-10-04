---
title: Docker Notes
menu:
  notes:
    name: Docker
    identifier: docker-notes
    weight: 10
---

{{< note title="Docker clean up">}}
```bash
docker system prune --all --volumes --force

docker volume rm $(docker volume ls -qf dangling=true)

docker rm -vf $(docker ps -aq)
docker rmi -f $(docker images -aq)
docker volume prune -f
```
{{< /note >}}

{{< note title="Stop all containers">}}
```bash
docker stop $(docker ps -qa)
```
{{< /note >}}

{{< note title="Remove containers">}}
```bash
docker rm $(docker ps -qa)
```
{{< /note >}}

{{< note title="Remove all images">}}
```bash
docker images -q  |xargs docker rmi
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
```
{{< /note >}}


{{< note title="Docker network change default">}}
```bash
systemctl stop docker
iptables -t nat -F POSTROUTING
ip link set dev docker0 down
ip addr del 172.17.0.1/16 dev docker0 # delete old route
ip addr add 172.18.32.1/24 dev docker0 # add new one
ip link set dev docker0 up

```
Permanent options : **/etc/default/docker**

DOCKER_OPTS : **/etc/docker/daemon.json**

```--bip=172.18.32.1/24 --default-gateway=172.18.32.1```

```json
{
 "default-address-pools": [
   {"base":"172.80.0.0/16","size":24},
   {"base":"172.90.0.0/16","size":24}
  ]
}
```

{{< /note >}}
