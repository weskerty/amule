#!/bin/bash

cd repo || exit 1

git fetch origin
git reset --hard origin/master

chmod -r +x Util/aMuleD.AppImage

#detectar por sistema para ejecutar.
amuled-arm64.AppImage &
amuled-armv7.AppImage &
amuled-x64.AppImage &
amuled-x64.exe &
amuled-arm64.exe &


#fail descompress?
mkdir -p ~/home/amuled/
./amuled-arch.ext --appimage-extract
./home/~/amuled/squashfs-root/usr/bin/amuled & 

cd MuLy || exit 1
#volta exist? 
/opt/aMuleD.bin/home/.volta/bin/npm install --force && node server.js

#no exist? 
npm install --force && node server.js