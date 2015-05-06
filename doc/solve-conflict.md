# 代码冲突解决方法

如果系统中有一些配置文件在服务器上做了配置修改，然后后续开发又新添加一些配置项的时候，

在发布这个配置文件的时候，会发生代码冲突:

error: Your local changes to the following files would be overwritten by merge:
  _path/to/filename_
Please, commit your changes or stash them before you can merge.

* 如果希望保留生产服务器上所做的改动,仅仅并入新配置项，处理方法如下:

```
git stash
git pull
git stash pop
```

然后可以使用 `git diff -w +文件名` 来确认代码自动合并的情况


* 如果希望用代码库中的文件完全覆盖本地工作版本。方法如下:

```
git reset --hard
git pull
```

* 其中`git reset`是针对版本，如果想针对文件回退本地修改，使用

```
git checkout HEAD file/to/restore
```

* 手动解决冲突

```
git checkout --ours xxx // 使用本地的文件
git checkout --theirs xxx // 使用版本库中的文件

git add <file>...
git commit
:wq
```

* rebase的冲突解决

rebase的冲突解决过程，就是解决每个应用补丁冲突的过程。

解决完一个补丁应用的冲突后，执行下面命令标记冲突已解决（也就是把修改内容加入缓存）：

```
git add -u
// 注：-u 表示把所有已track的文件的新的修改加入缓存，但不加入新的文件。
```

然后执行下面命令继续rebase：

```
git rebase --continue
// 有冲突继续解决，重复这这些步骤，直到rebase完成。
```

如果中间遇到某个补丁不需要应用，可以用下面命令忽略：

```
git rebase --skip
```

如果想回到rebase执行之前的状态，可以执行：

```
git rebase --abort
// 注：rebase之后，不需要执行commit，也不存在新的修改需要提交，都是git自动完成。
```
