git push
========

* `git push <repository> <refspec>` <repository>是远程仓库，是push操作的目的地，<repository>可以是一个URL，也可以是远程仓库的名字。

`<refspec>`的格式是：+src：dst，其中“+”是可选的，src是想要push的分支的名字，dst是用push更新的远程端的ref的名字。使用空的`<src>`进行更新会删除远程仓库中的内容。
