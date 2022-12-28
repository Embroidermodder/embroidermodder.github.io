#!/bin/bash

function build_manual () {
pandoc -o $1 -H content/docs/header.tex $2
}

git clone https://github.com/embroidermodder/embroidermodder
git clone https://github.com/embroidermodder/libembroidery

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

cd ../..

build_manual static/libembroidery_0.1_manual.pdf libembroidery/README.md
build_manual static/embroidermodder_2.0.0-alpha_manual.pdf embroidermodder/README.md
build_manual static/embroiderbot_0.1_manual.pdf libembroidery/EmbroiderBot/README.md

hugo --minify
