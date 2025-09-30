---
title: Sed TIps
weight: 10
menu:
  notes:
    name: Sed
    identifier: sed-notes
    parent: others-notes
    weight: 20
---

{{< note title="Sed Expressions">}}

```bash
# Viewing a Range of Lines of a File
sed -n '5,10p' file.txt

# Viewing the Entire File Except a Given Range
sed '20,35d' file.txt

# Viewing Non-Consecutive Lines and Ranges
sed -n -e '5,7p' -e '10,13p' file.txt

# Replacing Words or Strings in a File
sed 's/version/story/g' file.txt
sed 's/version/story/gi' file.txt # ignore character case

# Replate multiple blank spaces with a single space
cat file.txt | sed 's/  */ /g'

# Replacing Words or Strings Inside a Range
sed '30,40 s/version/story/g' file.txt

# Remove Comments From a File
sed '/^#\|^$\| *#/d' file.txt

# Replace a Case-insensitive Word in a File
sed 's/[Zz]ip/rar/g' file.txt

# Finding a Specific Events in a Log File
sed -n '/^Jan  1/ p' /var/log/syslog

# Inserting Spaces or Blank Lines in a File
sed G file.txt
sed 'G;G' file.txt # 2 blank lines

# Removing ^M in a File
sed -i 's/\r//' file.txt

# Create a Backup File with Sed Command
sed -i'.orig' 's/this/there/gi' file.txt

# Switching Pairs of Words in a File
sed 's/^\(.*\),\(.*\)$/\2\, /g' names.txt
```

{{< /note >}}
