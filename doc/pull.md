Q:

```
[branch "master"]
    remote = <nickname>
    merge = <remote-ref>

[remote "<nickname>"]
    url = <url>
    fetch = <refspec>
```

A:

```
git config branch.master.remote origin
git config branch.master.merge refs/heads/master
```
