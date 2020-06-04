#!/bin/bash

# Example of generated content:
# - [Posts](./posts/index.md)
#   - [2020-06-03](./posts/2020-06-03/index.md)
#     - [Hello, world!](./posts/2020-06-03/hello_world.md)

# Remove all content between "## BEGIN AUTO-ADD" and "## END AUTO-ADD"
cd src
sed -i '/^## BEGIN/,/^## END/{/^## BEGIN/!{/^## END/!d}}' SUMMARY.md

SUMMARYLENGTH="$(cat SUMMARY.md | wc -l)"
head "-n$((SUMMARYLENGTH-1))" SUMMARY.md > SUMMARY.md2
mv -f SUMMARY.md2 SUMMARY.md

# Begin generation
echo "## BEGIN AUTO-ADD" >> SUMMARY.md
echo "- [Posts](./posts/index.md)" >> SUMMARY.md

cd posts
declare -a DIRS=$(find -type d -not -name . -printf "%P\n")
for DIR in $DIRS
do
  # Automatically add src/posts/index.md to directories without it
  find $DIR -type f -name index.md | grep index.md 2>&1 > /dev/null || NOT_FOUND=1
  if [ ! -z $NOT_FOUND ]; then
    touch "$DIR/index.md"
  fi
  echo "  - [$DIR](./posts/$DIR/index.md)" >> ../SUMMARY.md
  # Get files in DIR
  declare -a FILES=$(find "$DIR" -type f -not -name index.md -printf "%P\n")
  for FILE in $FILES
  do
    # Get post name from the first line (e.g. "# Hello, world!" -> "Hello, world!")
    POSTNAME="$(head -n1 "$DIR/$FILE" | awk '{print substr($0,3);}')"
    echo "    - [$POSTNAME](./posts/$DIR/$FILE)" >> ../SUMMARY.md
  done
done

echo "## END AUTO-ADD" >> ../SUMMARY.md

cd ../..