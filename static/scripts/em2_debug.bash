#!/bin/bash

function detect_missing_library() {
    echo "On Debian detects if a library is missing then requests to install it via sudo."

    # Saves us logging in as su if the package is present.
    if [ `dpkg -s $1 | wc -l` -eq 0 ]; then
        echo "Attempting to install missing library $1."
        sudo apt-get update
        sudo apt-get install $1
    fi
}

rm -fr Embroidermodder

git clone https://github.com/Embroidermodder/Embroidermodder
cd Embroidermodder
git submodule update --init --recursive

case "$(uname -s)" in
Linux*)
    detect_missing_library libfreetype6-dev
    detect_missing_library build-essential
    detect_missing_library cmake
    ;;
Darwin*)
    echo "FIXME: Needs macports line."
    ;;
CYGWIN*)
    echo "FIXME: Needs library install for CYGWIN."
    ;;
MINGW*)
    echo "FIXME: Needs library install for MINGW."
    ;;
*)
    echo "Unrecognised system: building libraries from source."
esac

mkdir build
cd build
cmake ..
cmake --build .

timeout 10 ./embroidermodder --test &> test_results.txt
