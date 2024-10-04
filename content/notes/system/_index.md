---
title: System
weight: 10
menu:
  notes:
    name: System
    identifier: system-notes
    weight: 10
---

{{< note title="Linux rename username">}}
The really right way? Say you want to change user 'peter' to 'paul'.

```shell
groupadd paul usermod -d /home/paul -m -g paul -l paul peter
```

{{< /note >}}

{{< note title="list of file used by PID">}}
list of file used by PID
```shell
lsof -a -p <PID>
# ls - l /proc/<PID>/fd
ps -aeo pid,pcpu,args --sort=-%cpu | head
```

{{< /note >}}

{{< note title="Linux SiG Signal list of file used by PID">}}
list of linux signals
```shell
SIGHUP -HUP gracefully reloads the workers and the application
SIGTERM -TERM "brutally" reloads
SIGINT -INT and SIGQUIT -QUIT kills all the workers immediately
SIGUSR1 -USR1 prints statistics (stdout)
SIGUSR2 -USR2 prints worker status
SIGURG -URG restores a snapshot
SIGTSTP -TSTP pauses, suspends or resumes an instance
SIGWINCH -WINCH wakes up a worker blocked in a syscall
```

{{< /note >}}

{{< note title="Remove all package marked as rc">}}
Now let’s remove all the packages marked as rc.
```shell
$ dpkg --list |grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge
```

{{< /note >}}

