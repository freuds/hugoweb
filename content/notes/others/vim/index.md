---
title: Vim
weight: 10
menu:
  notes:
    name: Vim
    identifier: vim-notes
    parent: others-notes
    weight: 20
---

{{< note title="Vim Tips">}}

```bash
# Supprimer toutes les lignes vides ou contenant tabulation et/ou espace
:%s/^[\ \t]*\n//g

# Suppression des lignes commençant par un #
:g/^#/d

# Suppression des ^M en milieu de ligne et substitution par un vrai retour à la ligne : Taper sur “Enter” pour obtenir le ^M.
:g/^M/s//^M/g

# Changer de mode DOS / UNIX
:se ff=dos
:se ff=unix

# You can show control characters (including where a line ends)
:set list
:set nolist (to toggle off)

# This replaces the beginning of each line with "//":
:%s!^!//!

# This replaces the beginning of each selected line (use visual mode to select) with "//":
:'<,'>s!^!//!

# Execute external command
:map ,t :!make<cr>

{{< /note >}}
