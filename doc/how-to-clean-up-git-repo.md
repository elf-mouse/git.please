# 如何清洗 Git Repo 代码仓库

## 手动清理

### 大致过程如下：

首先进行 Git 垃圾回收：

```
git gc --auto
```

其次查看 Git 仓库占用空间：

```
du -hs .git/objects
```

### 相关的几个命令：

清理历史中的文件：

```
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch ****/nohup.out' --prune-empty --tag-name-filter cat -- --all
git filter-branch --index-filter 'git rm --cached --ignore-unmatch ****/nohup.out' HEAD
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
```

强制提交覆盖：

```
git reflog expire --expire=now --all
git gc --prune=now
git push --all --force
git push --all --tags --force
```

但是这个方案有 2 个问题：1. 处理速度慢，尝试清理 2G 大小的代码库，用了 1 晚上还没跑完。2. 只能按文件名清理，如果不同的路径有同样的文件名就无法处理了，可能误删文件或者忽略某些文件。当然有个非常好的解决方案完美解决了这个问题。

## 自动清理

答案就是 `bfg-repo-cleaner`，这是一个 Java 写的清理工具，多线程处理清理过程，命令很简单，只需要几分钟就清理了之前 1 晚上都跑不完的任务：

```
java -jar bfg-1.11.7.jar --delete-files *.zip myrepo.git
java -jar bfg-1.11.7.jar --delete-files *.log myrepo.git
java -jar bfg-1.11.7.jar --delete-files *.out myrepo.git
java -jar bfg-1.11.7.jar --strip-blobs-bigger-than 1M myrepo.git
```

## 附上几个常用的但又不常见的 git 小技巧：

复制代码仓库：

```
git clone --bare /var/www/html/myrepo.git
```

Git 后悔药，覆盖最后一次修改：

```
git add .
git commit --amend
git push origin master -f
```

Git 放弃本地修改：

```
git checkout .
```

Git 销毁最后一次提交：

```
git reset --hard HEAD^
git push -f origin HEAD^:master
```

打包时候嵌入版本号：

```
git rev-parse HEAD > version.txt
```
