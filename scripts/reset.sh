#!/bin/sh

# 1. 创建新分支
git checkout --orphan master

# 2. 添加所有文件
git add -A

# 3. commit代码
git commit -m "init"

# 4. 删除原来的主分支(master)
git branch -D master

# 5. 把当前分支重命名为master
git branch -m master

# 6. 最后把代码推送到远程仓库
git branch --set-upstream-to=origin/master master
git push -f origin master

# 7. 从远程库拉取更新代码(测试)
git pull

# 8. 确定清除历史记录的结果
git log --pretty=oneline

# git branch # 本地
# git branch -r # 远程
git branch -a # 所有

git tag # 本地
git ls-remote --tags # 远程
