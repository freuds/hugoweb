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

```bash
groupadd paul usermod -d /home/paul -m -g paul -l paul peter
```

{{< /note >}}

{{< note title="list of file used by PID">}}

```bash
lsof -a -p <PID>
# ls - l /proc/<PID>/fd
ps -aeo pid,pcpu,args --sort=-%cpu | head
```

{{< /note >}}

{{< note title="Linux SiG Signal list of file used by PID">}}

```bash
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

```bash
dpkg --list |grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge
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
env bashOPTS=verbose ./test
```

{{< /note >}}

{{< note title="mount RAID LVM disk recovery">}}

1. Boot avec un USB linux live
2. Install mdadm

```bash
apt install mdadm
```

Build : RAID1 + LVM

```bash
mdadm --detail --scan
cat /proc/mdstat
mdadm -A -R /dev/md/8 /dev/sdc8
mdadm -S /dev/vg/lv
lvdisplay
mount /dev/lg/lv
```

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
swapon --show

NAME      TYPE      SIZE USED PRIO
/dev/sda2 partition   4G   0B   -1

fallocate -l 1G /swapfile
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
nano /etc/fstab

# Edit : /etc/fstab
/swapfile swap swap defaults 0 0

swapon --show

NAME      TYPE  SIZE   USED PRIO
/swapfile file 1024M 507.4M   -1
```

{{< /note >}}

{{< note title="Get detailled disk partitions">}}

```bash
findmnt -Do TARGET,SOURCE,USED,SIZE,OPTIONS
```

{{< /note >}}

{{< note title="Umask Linux">}}

```bash
Umask   Created Files       Created Directories
_______________________________________________
000     666 (rw_rw_rw_)     777     (rwxrwxrwx)
002     664 (rw_rw_r__)     775     (rwxrwxr_x)
022     644 (rw_r__r__)     755     (rwxr_xr_x)
027     640 (rw_r_____)     750     (rwxr_x___)
077     600 (rw_______)     700     (rwx______)
277     400 (r________)     500     (r_x______)
```

{{< /note >}}

{{< note title="NFS Server show clients">}}

```bash
# show clients connected
netstat | grep :nfs
# list all connected clients
showmount -a
# Discover/view NFS shares from the client
showmount -e
# list active share on client
showmount -e <ip_adress>
# Exports all file system paths specified in the /etc/exports file
exportfs -r
```

{{< /note >}}

{{< note title="Disable Bell on linux">}}

```bash
rmmod pcspkr
# Blacklisting the pcspkr module will prevent udev from loading it at boot:
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
```

{{< /note >}}

{{< note title="Delete full disk on Linux">}}

```bash
shred --verbose --random-source=/dev/urandom -n1 /dev/sda1
```

{{< /note >}}

{{< note title="Compiling a linux Kernel">}}

```bash
# Download the source code and pgp signature from https://www.kernel.org/ to a directory of your choice
mkdir -p /usr/src/
cd /usr/src/
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.1.16.tar.xz
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.1.16.tar.sign

# Uncompress the source code and check the signature
xz -d -v linux-5.1.16.tar.xz
gpg --verify linux-5.1.16.tar.sign

# Untar the source code and cd into the directory
tar xf linux-5.1.16.tar
cd linux-5.1.16/

# Copy over actual kernel config file and run 'make menuconfig'
cp -v /boot/config-$(uname -r) .config

# Install necessary packages
apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev bc

make menuconfig
# Go to Cryptographic API  --> Certificates for signature checking -->
# and leave 'File name or PKCS#11 URI of module signing key' and
# 'Additional X.509 keys for default system keyring' blank if not
# already blank
# Compile using make or make -j n where n is the number of processors to use
make # or
make -j 4

# Install kernel modules
make modules_install

# Optimize and compile new kernel
cd /lib/modules/5.1.16/
find . -name *.ko -exec strip --strip-unneeded {} +
cd /usr/src/linux-5.1.16/
make install
```

{{< /note >}}
