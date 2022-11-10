#!/bin/bash

rm -fr Embroidermodder

git clone https://github.com/Embroidermodder/Embroidermodder
cd Embroidermodder
git submodule init
git submodule update

case "$(uname -s)" in
Linux*)
    # Saves us logging in as su if the package is present.
    if [ `dpkg -s libx11-dev | wc` -gt 0 ]; then
        sudo apt-get update
        sudo apt-get install libx11-dev
    fi
    gcc -O2 -g -Wall -std=c99 -Iextern/libembroidery/src extern/libembroidery/src/*.c src/*.c -o embroidermodder -lX11 -lm
    ;;
Darwin*)
    gcc -O2 -g -Wall -std=c99 -Iextern/libembroidery/src extern/libembroidery/src/*.c src/*.c -o embroidermodder -lX11 -lm
    ;;
CYGWIN*)
    gcc -municode -O2 -g -Wall -std=c99 -Iextern/libembroidery/src extern/libembroidery/src/*.c src/*.c -o embroidermodder -lGdi32
    ;;
MINGW*)
    gcc -municode -O2 -g -Wall -std=c99 -Iextern/libembroidery/src extern/libembroidery/src/*.c src/*.c -o embroidermodder -lGdi32
    ;;
*)
    echo "Unrecognised system: building as X11."
    gcc -O2 -g -Wall -std=c99 -Iextern/libembroidery/src extern/libembroidery/src/*.c src/*.c -o embroidermodder -lX11 -lm
esac

timeout 10 ./embroidermodder --test &> test_results.txt
