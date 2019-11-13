#!/usr/bin/env bash
set -x

mkdir -p build/images build/css

cp source/*.html build
cp source/*.xml build
cp source/.htaccess build
cp source/robots.txt build
cp source/images/*.ico build
cp source/css/* build/css
cp source/images/*.png build/images
cp source/images/*.svg build/images

# optimize png files

for filename in build/images/*.png; do
  if [[ $(basename $filename) == "logo-betacloud-solutions.png" ]]; then
    mogrify \
      -depth 24 \
      -define png:compression-filter=2 \
      -define png:compression-level=9 \
      -define png:compression-strategy=1 \
      $filename
  else
    mogrify \
      -depth 24 \
      -define png:compression-filter=2 \
      -define png:compression-level=9 \
      -define png:compression-strategy=1 \
      -resize 75% \
      $filename
  fi
done

# optimize html files

for filename in build/*.html; do
  html-minifier \
    --collapse-whitespace \
    --remove-comments \
    --remove-redundant-attributes \
    --remove-script-type-attributes \
    --use-short-doctype \
    --minify-css true \
    --minify-js true \
    --output $filename \
    $filename
done

# optimize css files

for filename in build/css/*.css; do
  cleancss -o $filename $filename
done
