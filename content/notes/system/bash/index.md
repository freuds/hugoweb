---
title: Bash
weight: 10
menu:
  notes:
    name: Bash
    identifier: bash-notes
    parent: system-notes
    weight: 20
---

{{< note title="Array in Bash">}}
```bash
string="0123456789"                   # create a string of 10 characters
array=(0 1 2 3 4 5 6 7 8 9)           # create an indexed array of 10 elements
```

```bash
declare -A hash
hash=([one]=1 [two]=2 [three]=3)      # create an associative array of 3 elements
echo "string length is: ${#string}"   # length of string
echo "array length is: ${#array[@]}"  # length of array using @ as the index
echo "array length is: ${#array[*]}"  # length of array using * as the index
echo "hash length is: ${#hash[@]}"    # length of array using @ as the index
echo "hash length is: ${#hash[*]}"    # length of array using * as the index
```
{{< /note >}}

{{< note title="Special characters in Bash">}}
 Special Variable	 Variable Details
```bash
- $1 to $n : $1 is the first arguments, $2 is second argument till $n n’th arguments.
 From 10’th argument, you must need to inclose them in braces like ${10}, ${11} and so on
- $0 : The name of script itself
- $$ : Process id of current shell
- $* : Values of all the arguments. All agruments are double quoted
- $# : Total number of arguments passed to script
- $@ : Values of all the arguments
- $? : Exit status id of last command
- $! : Process id of last command
```

{{< /note >}}