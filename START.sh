#!/bin/bash

cd repo || exit 1

git fetch origin
git reset --hard origin/master

cd MuLy || exit 1
/opt/aMuleD.bin/home/.volta/bin/node server.js