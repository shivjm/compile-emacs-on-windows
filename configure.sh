#!/usr/bin/env bash

set -euxo pipefail

CFLAGS="-O2 -march=native -pipe -fomit-frame-pointer"

pushd /d/Media/src/emacs; ./configure --without-pop --with-imagemagick --with-json --with-w32 --without-dbus --without-gconf --with-native-compilation --with-cairo --without-x-toolkit --with-xml2 --with-modules; popd
