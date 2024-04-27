---
title: Linux
weight: 10
menu:
  notes:
    name: Linux
    identifier: linux-notes
    parent: system-notes
    weight: 10
---

{{< note title="Linux rename username">}}
The really right way? Say you want to change user 'peter' to 'paul'.

```shell
groupadd paul usermod -d /home/paul -m -g paul -l paul peter
```

{{< /note >}}

{{< note title="list of file used by PID">}}
```shell
lsof -a -p <PID>
# ls - l /proc/<PID>/fd
ps -aeo pid,pcpu,args --sort=-%cpu | head
```

{{< /note >}}

{{< note title="Linux SiG Signal list of file used by PID">}}
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
```shell
$ dpkg --list |grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge
```

{{< /note >}}

{{< note title="how-to-loop-through-file-names-returned-by-find">}}

Execute `process` once for each file

```bash
find . -name '*.txt' -exec process {} \;
```
If you have time, read through the rest to see several different ways and the problems with most of them.

The full answer:

The best way depends on what you want to do, but here are a few options. As long as no file or folder in the subtree has whitespace in its name, you can just loop over the files:

```bash
for i in $x; do # Not recommended, will break on whitespace
    process "$i"
done

# Marginally better, cut out the temporary variable x:

for i in $(find -name \*.txt); do # Not recommended, will break on whitespace
    process "$i"
done

#It is much better to glob when you can. White-space safe, for files in the current directory:

for i in *.txt; do # Whitespace-safe but not recursive.
    process "$i"
done
# By enabling the globstar option, you can glob all matching files in this directory and all subdirectories:

# Make sure globstar is enabled
shopt -s globstar
for i in **/*.txt; do # Whitespace-safe and recursive
    process "$i"
done

# IFS= makes sure it doesn't trim leading and trailing whitespace
# -r prevents interpretation of \ escapes.
while IFS= read -r line; do # Whitespace-safe EXCEPT newlines
    process "$line"
done < filename
# read can be used safely in combination with find by setting the delimiter appropriately:

find . -name '*.txt' -print0 |
    while IFS= read -r -d '' line; do
        process "$line"
    done
# For more complex searches, you will probably want to use find,
# either with its -exec option or with -print0 | xargs -0:

# execute `process` once for each file
find . -name \*.txt -exec process {} \;

# execute `process` once with all the files as arguments*:
find . -name \*.txt -exec process {} +

# using xargs*
find . -name \*.txt -print0 | xargs -0 process

# using xargs with arguments after each filename
# (implies one run per filename)
find . -name \*.txt -print0 | xargs -0 -I{} process {} argument

{{< /note >}}

{{< note title="Rsync ssh script">}}

```bash
#!/usr/bin/env bash

checkBinary() {
  command -v "$1" >/dev/null 2>&1 || { echo >&2 "please install binary : $1. Aborting."; exit 1; }
}
checkBinary "rsync"

clear

STIME=$(date +"%X")
SOURCE_USER="appREMOTE"
SOURCE_HOST="app.mydomain.com"
SOURCE_DIR="/mnt/production/web/uploads/media/*"
DEST_DIR="/efs/media/"

rsync -avz \
      --chown=1000:1000 \
      -e "ssh -o StrictHostKeyChecking=no \
      -o UserKnownHostsFile=/dev/null \
      -i /home/ubuntu/.ssh/id_rsa" \
      ${SOURCE_USER}@"${SOURCE_HOST}":"${SOURCE_DIR}" \
      "${DEST_DIR1}"

printf "### Initiated at : %s\n" ${STIME}
printf "### Terminated at : %s\n" $(date +"%X")

exit 0
```
{{< /note >}}

{{< note title="Benchmark script with strace">}}
Now let’s remove all the packages marked as rc.
```bash
strace -o trace -c -Ttt ./scrip
# where:
# -c is to trace the time spent by cpu on specific call.
# -Ttt will tell you time in microseconds at time of each system call running.
# -o will save output in file "trace".
```
{{< /note >}}

{{< note title="Compile script and crypt">}}
[Lien github](https://github.com/neurobin/shc)
```bash
apt install shc

# to see content of encrypt script :
env SHELLOPTS=verbose ./test
```
{{< /note >}}

{{< note title="mount RAID LVM disk recovery">}}
* boot sous linux live
* install mdadm : apt install mdadm
* RAID1 + LVM
* mdadm --detail --scan
* cat /proc/mdstat
* mdadm -A -R /dev/md/8 /dev/sdc8
* mdadm -S /dev/vg/lv
* lvdisplay
* mount /dev/lg/lv
{{< /note >}}

{{< note title="HTTP load generator">}}
[HTTP load generator, ApacheBench (ab) replacement](https://github.com/rakyll/hey)
{{< /note >}}

{{< note title="Make ISO command line linux">}}
```bash
# Install package
apt install genisoimage
mkisofs -allow-limited-size -l -J -r -iso-level 3 -o
# this command will generate bigger then 4GB ISO
```
{{< /note >}}

{{< note title="Disabled SWAP on linux">}}
```bash
> swapon --show

NAME      TYPE      SIZE USED PRIO
/dev/sda2 partition   4G   0B   -1

> fallocate -l 1G /swapfile
> dd if=/dev/zero of=/swapfile bs=1024 count=1048576
> chmod 600 /swapfile
> mkswap /swapfile
> swapon /swapfile
> nano /etc/fstab

# Edit : /etc/fstab
/swapfile swap swap defaults 0 0

> swapon --show

NAME      TYPE  SIZE   USED PRIO
/swapfile file 1024M 507.4M   -1
```
{{< /note >}}

{{< note title="Get detailled disk partitions">}}
```bash
> findmnt -Do TARGET,SOURCE,USED,SIZE,OPTIONS
```
{{< /note >}}