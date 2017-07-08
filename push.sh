#!/bin/bash
cd ./public

echo alvr.me > CNAME
git init
git config user.name "Álvaro S"
git config user.email "alvaro.sg93@gmail.com"
git remote add upstream "https://${GITHUB_TOKEN}@github.com/alvr/alvr.github.io.git"
git fetch upstream
git reset upstream/master

git add -A .
git commit -m "alvr/alvr.github.io-hugo@${CIRCLE_SHA1}"
git remote show upstream
git push -q upstream HEAD:master