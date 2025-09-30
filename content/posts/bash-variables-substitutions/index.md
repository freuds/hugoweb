---
title: "Bash Variables Substitutions"
date: 2020-06-08T08:06:25+06:00
hero: bash.png
description: Introduction to Sample Post
menu:
  sidebar:
    name: Bash Variables
    identifier: bash-variable-substitutions
    weight: 10
---

This table summarizes Bash parameter expansions, providing a quick reference for manipulating shell variables. It covers operations like default value assignment, substring extraction, pattern removal, case conversion, and string length calculation.

| Parameter Expansion             | Description                                      |
| :------------------------------ | :----------------------------------------------- |
| `${parameter:-defaultValue}`    | Get default shell variables value                |
| `${parameter:=defaultValue}`    | Set default shell variables value                |
| `${parameter:?"Error Message"}` | Display an error message if parameter is not set |
| `${#var}`                       | Find the length of the string                    |
| `${var%pattern}`                | Remove from shortest rear (end) pattern          |
| `${var%%pattern}`               | Remove from longest rear (end) pattern           |
| `${var:num1:num2}`              | Substring                                        |
| `${var#pattern}`                | Remove from shortest front pattern               |
| `${var##pattern}`               | Remove from longest front pattern                |
| `${var/pattern/string}`         | Find and replace (only replace first occurrence) |
| `${var//pattern/string}`        | Find and replace all occurrences                 |
| `${!prefix*}`                   | Expands to the names of variables whose names begin with prefix. |
| `${var,}`                       | Convert first character to lowercase.            |
| `${var,pattern}`                | Convert first character to lowercase.            |
| `${var,,}`                      | Convert all characters to lowercase.             |
| `${var,,pattern}`               | Convert all characters to lowercase.             |
| `${var^}`                       | Convert first character to uppercase.            |
| `${var^pattern}`                | Convert first character to uppercase.            |
| `${var^^}`                      | Convert all character to uppercase.              |
| `${var^^pattern}`               | Convert all character to uppercase.              |
