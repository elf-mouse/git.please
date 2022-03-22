REPOSITORY=git@repository.git
NEW_BRANCH=projectName

cd dist

git init
git add -A
git ci -m "init"

git remote add origin $REPOSITORY
git branch -m $NEW_BRANCH
git push origin $NEW_BRANCH
