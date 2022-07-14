#!/bin/sh

REPOSITORY=git@repository.git
PROJECT_NAME=projectName
DEFAULT_BRANCH=master

echo "Please choose your deploy project:"
select buildBranch in "dev" "test" "release"
do
  echo "You selected $buildBranch branch"
  break
done

readonly CURRENT_SOURCE_BRANCH=$(git symbolic-ref --short -q HEAD)
rm -rf build
git worktree prune
mkdir build
git clone --bare $REPOSITORY build/.bare
echo "gitdir: ./.bare" > build/.git
git worktree add -B $buildBranch build/$buildBranch origin/$buildBranch
rm -rf build/$buildBranch/*

if [ "$buildBranch" == "release" ]
then
  if [ "$CURRENT_SOURCE_BRANCH" == "master" ]
  then
    PROJECT_NAME="$PROJECT_NAME@release"
  else
    echo "Please checkout master for release build"
    exit 1
  fi
elif [ "$buildBranch" == "dev" ]
then
  PROJECT_NAME="$PROJECT_NAME@dev"
else
  PROJECT_NAME="$PROJECT_NAME@test"
fi

npm run $buildBranch:prod
cp -rf dist/* build/$buildBranch
cd build/$buildBranch

readonly CURRENT_TARGET_BRANCH=$(git symbolic-ref --short -q HEAD)
if [ "$CURRENT_TARGET_BRANCH" != "$buildBranch" ]
then
  echo "Expected build folder to be on $buildBranch branch."
  exit 1
fi

LOG_MESSAGE="build $PROJECT_NAME as of $(git log '--format=format:%H' $CURRENT_SOURCE_BRANCH -1)"
git add -A
git commit -m $LOG_MESSAGE
git push -f --set-upstream origin $buildBranch
