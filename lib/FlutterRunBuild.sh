#!/bin/bash
flutter clean
flutter build web

cd build/web || exit
git init
git remote add origin https://github.com/vovo-8112/WBTSoulStats.git
git checkout -b gh-pages
git add .
git commit -m "deploy"
git push -f origin gh-pages