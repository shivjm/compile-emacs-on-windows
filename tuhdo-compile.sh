#!/usr/bin/env bash

OUTPUT_DIRECTORY="$PWD/output"
SOURCE_DIRECTORY="$PWD/source"

set -euxo pipefail

pacman -Sy --needed --noconfirm filesystem msys2-runtime bash libreadline libiconv libarchive libgpgme libcurl pacman ncurses libintl

pacman -Su --noconfirm

# https://www.reddit.com/r/emacs/comments/131354i/guide_compile_your_own_emacs_to_make_it_really/
pacman -S --noconfirm autoconf autogen automake automake-wrapper diffutils git guile libgc libguile libltdl libunistring make mingw-w64-x86_64-binutils mingw-w64-x86_64-bzip2 mingw-w64-x86_64-cairo mingw-w64-x86_64-crt-git mingw-w64-x86_64-dbus mingw-w64-x86_64-expat mingw-w64-x86_64-glib2 mingw-w64-x86_64-gmp mingw-w64-x86_64-gnutls mingw-w64-x86_64-harfbuzz mingw-w64-x86_64-headers-git mingw-w64-x86_64-imagemagick mingw-w64-x86_64-isl mingw-w64-x86_64-libffi mingw-w64-x86_64-libgccjit mingw-w64-x86_64-libiconv mingw-w64-x86_64-libjpeg-turbo mingw-w64-x86_64-libpng mingw-w64-x86_64-librsvg mingw-w64-x86_64-libtiff mingw-w64-x86_64-libwinpthread-git mingw-w64-x86_64-libxml2 mingw-w64-x86_64-mpc mingw-w64-x86_64-mpfr mingw-w64-x86_64-pango mingw-w64-x86_64-pixman mingw-w64-x86_64-winpthreads mingw-w64-x86_64-xpm-nox mingw-w64-x86_64-lcms2 mingw-w64-x86_64-xz mingw-w64-x86_64-zlib tar wget texinfo pkg-config mingw-w64-x86_64-jansson mingw-w64-x86_64-tree-sitter

[[ -d "$SOURCE_DIRECTORY" ]] || git clone http://git.savannah.gnu.org/r/emacs.git "$SOURCE_DIRECTORY"

pushd "$SOURCE_DIRECTORY"
git config core.autocrlf false
./autogen.sh

mkdir -p "$OUTPUT_DIRECTORY"

# Some values adapted to my case.
./configure --prefix="$OUTPUT_DIRECTORY" --without-pop --with-imagemagick --without-compress-install -without-dbus --with-gnutls --with-json --with-tree-sitter \
            --without-gconf --with-rsvg --without-gsettings --with-mailutils \
            --with-native-compilation --with-modules  --with-xml2 --with-wide-int \
            --with-w32 --without-x-toolkit --with-cairo \
            CFLAGS="-O3 -fno-math-errno -funsafe-math-optimizations -fno-finite-math-only -fno-trapping-math \
                  -freciprocal-math -fno-rounding-math -fno-signaling-nans \
                  -fassociative-math -fno-signed-zeros -frename-registers -funroll-loops \
                  -mtune=native -march=native -fomit-frame-pointer \
                  -fallow-store-data-races -fno-semantic-interposition -floop-parallelize-all -ftree-parallelize-loops=4"

make install NATIVE_FULL_AOT=1
