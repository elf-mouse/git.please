#!/bin/sh

REPOSITORY=git@repository.git
PROJECT_NAME=projectName
DEFAULT_BRANCH=master
TARGET_BRANCH=(dev test release)

rm -rf build
git worktree prune

mkdir build
git clone --bare $REPOSITORY build/.bare
echo "gitdir: ./.bare" > build/.git

echo "Please choose your deploy project:"
select buildBranch in "${TARGET_BRANCH[0]}" "${TARGET_BRANCH[1]}" "${TARGET_BRANCH[2]}"
do
echo "You selected $buildBranch branch"
break
done

git worktree add -B $buildBranch build/$buildBranch origin/$buildBranch

rm -rf build/$buildBranch/*

npm run $buildBranch:prod
cp -rf dist/* build/$buildBranch
cd build/$buildBranch

readonly CURRENT_BRANCH=$(git symbolic-ref --short -q HEAD)
if [ "$CURRENT_BRANCH" != "$buildBranch" ]
then
  echo "Expected build folder to be on $buildBranch branch."
fi

git add -A
git commit -m "build $PROJECT_NAME $buildBranch as of $(git log '--format=format:%H' $DEFAULT_BRANCH -1)"
git push -f --set-upstream origin $buildBranch
