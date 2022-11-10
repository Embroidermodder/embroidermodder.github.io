#!/bin/bash

function detect_missing_library() {
    echo "On Debian detects if a library is missing then requests to install it via sudo."

    # Saves us logging in as su if the package is present.
    if [ `dpkg -s $1 | wc -l` -eq 0 ]; then
        echo "Attempting to install missing library $1."
        sudo apt-get update
        sudo apt-get install libx11-dev
    fi
}

rm -fr Embroidermodder

git clone https://github.com/Embroidermodder/Embroidermodder
cd Embroidermodder
git submodule init
git submodule update

CC=gcc
CFLAGS="-O2 -g -Wall -std=c99 -Isrc/libembroidery/src"
SRC=src/libembroidery/src/*.c src/*.c

case "$(uname -s)" in
Linux*)
    detect_missing_library libx11-dev
    detect_missing_library build-essential
    detect_missing_library make
    make
    ;;
Darwin*)
    make
    ;;
CYGWIN*)
    $CC $CFLAGS -municode $SRC -o embroidermodder -lGdi32
    ;;
MINGW*)
    $CC $CFLAGS -municode $SRC -o embroidermodder -lGdi32
    ;;
*)
    echo "Unrecognised system: building as X11."
    $CC $CFLAGS $SRC -o embroidermodder -lX11 -lm
esac

timeout 10 ./embroidermodder --test &> test_results.txt

