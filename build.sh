#!/bin/bash

git submodule init
git submodule update

cd embroidermodder
git pull origin main
cd ..

cd libembroidery
git pull origin main
cd ..

cd content/docs

mkdir embroidermodder_manual
mkdir libembroidery_manual
mkdir embroiderbot_manual

cat <<EOF >embroidermodder_manual/_index.md
+++
title = "Embroidermodder 2.0.0-alpha"
author = "The Embroidermodder Team"
abbrev = "embroiderbot"
date = "2022-09-19"
weight = 11
+++
EOF

cat <<EOF >libembroidery_manual/_index.md
+++
title = "Libembroidery 1.0-alpha"
author = "The Embroidermodder Team"
abbrev = "libembroidery"
date = "2022-09-19"
weight = 12
+++
EOF

cat <<EOF >embroiderbot_manual/_index.md
+++
title = "EmbroiderBot 1.0-alpha"
author = "The Embroidermodder Team"
abbrev = "embroiderbot"
date = "2022-09-19"
weight = 13
+++
EOF

cat ../../libembroidery/README.md >> libembroidery_manual/_index.md
cat ../../libembroidery/EmbroiderBot/README.md >> embroiderbot_manual/_index.md
cat ../../embroidermodder/README.md >> embroidermodder_manual/_index.md

cp -R ../../libembroidery/images libembroidery_manual
cp -R ../../libembroidery/EmbroiderBot/images embroiderbot_manual
cp -R ../../embroidermodder/images embroidermodder_manual

pandoc -o libembroidery_0.1_manual.pdf \
    libembroidery_manual/_index.md
pandoc -o embroidermodder_2.0.0-alpha_manual.pdf \
    embroidermodder_manual/_index.md
pandoc -o embroiderbot_0.1_manual.pdf \
    embroiderbot_manual/_index.md

cd ../..

hugo --minify
