git branch
==========

* `git branch` 不带参数：列出本地已经存在的分支，并且在当前分支的前面加“*”号标记
* `git branch -r` 列出远程分支
* `git branch -a` 列出本地分支和远程分支
* `git branch <branchname>` 创建一个新的本地分支，需要注意，此处只是创建分支，不进行分支切换
* `git branch -m | -M <oldbranch> <newbranch>` 重命名分支，如果newbranch名字分支已经存在，则需要使用-M强制重命名，否则，使用-m进行重命名
* `git branch -d | -D <branchname>` 删除本地分支
* `git branch -d -r <branchname>` 删除远程分支

```sh
Q: error: unable to delete 'branch-name': remote ref does not exist

A1: git fetch -p

# 清理远程分支，把本地不存在的远程分支删除
A2: git remote prune origin
```
