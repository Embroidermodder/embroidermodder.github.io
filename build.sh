#!/bin/bash

DOCS_=content/docs

git submodule init
git submodule update

cd embroidermodder
git pull origin main
cd ..

cd libembroidery
git pull origin main
cd ..

rm $DOCS_/libembroidery.md
rm $DOCS_/embroiderbot.md

touch $DOCS_/libembroidery.md
touch $DOCS_/embroiderbot.md

cat <<EOF >>$DOCS_/libembroidery.md
+++
title = "The Libembroidery 1.0-alpha Manual"
author = "The Embroidermodder Team"
abbrev = "libembroidery"
date = "2022-09-19"
weight = 11
+++
EOF

cat <<EOF >>$DOCS_/embroiderbot.md
+++
title = "The EmbroiderBot 1.0-alpha Manual"
author = "The Embroidermodder Team"
abbrev = "embroiderbot"
date = "2022-09-19"
weight = 12
+++
EOF

cat libembroidery/README.md >> $DOCS_/libembroidery.md
cat libembroidery/EmbroiderBot/README.md >> $DOCS_/embroiderbot.md
cat embroidermodder/README.md >> $DOCS_/embroidermodder.md

pandoc -o $DOCS_/libembroidery_0.1_manual.pdf $DOCS_/libembroidery.md
pandoc -o $DOCS_/embroidermodder_2.0.0-alpha_manual.pdf $DOCS_/manual.md
pandoc -o $DOCS_/embroiderbot_0.1_manual.pdf $DOCS_/embroiderbot.md

hugo --minify --baseURL "www.libembroidery.org/"
