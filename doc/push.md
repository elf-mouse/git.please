Q: __non-fast-forward__

A1: git push -f 强推，即利用强覆盖方式用你本地的代码替代git仓库内的内容

A2:
git fetch + git merge = git pull
git config branch.master.remote origin
git config branch.master.merge refs/heads/master
