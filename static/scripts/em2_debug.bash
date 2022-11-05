#!/bin/bash

git clone https://github.com/Embroidermodder/Embroidermodder
cd Embroidermodder
git submodule init
git submodule update

case "$(uname -s)" in
Linux*)
    sudo apt-get update
    sudo apt-get install libx11-6
    gcc -O2 -g -Wall -std=c99 -Iextern/libembroidery/src extern/libembroidery/src/*.c em2.c -o embroidermodder -lX11 -lm
    ;;
Darwin*)
    gcc -O2 -g -Wall -std=c99 -Iextern/libembroidery/src extern/libembroidery/src/*.c em2.c -o embroidermodder -lX11 -lm
    ;;
CYGWIN*)
    gcc -municode -O2 -g -Wall -std=c99 -Iextern/libembroidery/src extern/libembroidery/src/*.c em2.c -o embroidermodder -lGdi32
    ;;
MINGW*)
    gcc -municode -O2 -g -Wall -std=c99 -Iextern/libembroidery/src extern/libembroidery/src/*.c em2.c -o embroidermodder -lGdi32
    ;;
*)
    echo "Unrecognised system: failed to build."
esac

timeout 10 ./embroidermodder --test &> test_results.txt
