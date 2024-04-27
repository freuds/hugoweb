---
title: Git
weight: 10
menu:
  notes:
    name: Git
    identifier: git-notes
    parent: system-notes
    weight: 20
---

{{< note title="Init a git repository">}}

```shell
# Git global setup
git config --global user.name "myname"
git config --global user.email "myemail@domain.local"

#Create a new repository
git clone git@gitlab.domain.net:it/diskusagereports.git
cd diskusagereports
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master

# Push an existing folder
cd existing_folder
git init
git remote add origin git@gitlab.domain.net:it/diskusagereports.git
git add .
git commit -m "Initial commit"
git push -u origin master

# Push an existing Git repository
cd existing_repo
git remote rename origin old-origin
git remote add origin git@gitlab.domain.net:it/diskusagereports.git
git push -u origin --all
git push -u origin --tags
```
{{< /note >}}

{{< note title="Retrieve just one file from a remote repository">}}
```shell
git archive --format=tar --remote=git_url HEAD -- <file> | tar xf -
```
{{< /note >}}

{{< note title="Git: make hotfix">}}
```bash
# display branch info
git branch -v

#go in branch hotfix/xx
git checkout -b hotfix/xx

# commit change
git commit -am "ton message"
git status

# push hotfix
git push origin hotfix/xxx

# MAJ branch master
git pull master

# update submodule
git submodule update --init --remote

# init submodule with branch
git submodule add -b branchname git@bitbucket.org:dir/repo.git path_to_submodule
```
{{< /note >}}

{{< note title="Annuler un commit après un push">}}
```bash
# Annuler un commit, c'est finalement appliquer l'inverse de son diff !
# On peut rediriger le diff des commits à annuler vers la commande patch --reverse :)
git diff HEAD^ | patch --reverse

# Pour faire plus simple, il y a git revert !
# Par exemple pour annuler les trois derniers commits :
git revert HEAD~3..HEAD

# Ou pour annuler un commit en particulier :
git revert 444b1cff
# Il suffit alors de pousser proprement le commit obtenu sur le serveur.
```
{{< /note >}}

{{< note title="Branch manipulation">}}
```bash
# To list all local branches
git branch
# To list all remote branches
git branch -r
# To list all branches (local and remote)
git branch -a

# If you are on the branch you want to rename:
git branch -m new-name

# Delete the old-name remote branch and push the new-name local branch.
git push origin :old-name new-name

# Reset the upstream branch for the new-name local branch.
# Switch to the branch and then:
git push origin -u new-name

# Deleting a single local branch
git branch -d <branchname>
# If you are sure you want to delete an unmerged branch:
git branch -D <branch>

# To delete all merged local branches:
git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d

# DANGER! Only run these if you are sure you want to delete unmerged branches.
# delete all local unmerged branches
git branch --no-merged | egrep -v "(^\*|master|dev)" | xargs git branch -D
# delete all local branches (merged and unmerged).
git branch | egrep -v "(^\*|master|dev)" | xargs git branch -D

# Deleting non-existent tracking branches
git remote prune <remote> --dry-run

# Deleting a single remote branch
git push <remote> --delete <branch>

# To delete all merged remote branches:
git branch -r --merged | egrep -v "(^\*|master|dev)" | sed 's/origin\///' | xargs -n 1 git push origin --delete
```
{{< /note >}}

{{< note title="Init a git repository">}}
{{< /note >}}

{{< note title="Init a git repository">}}
{{< /note >}}