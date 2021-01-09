#!/bin/bash

# Example of generated content:
# - [Posts](./posts/index.md)
#   - [2020-06-03](./posts/2020-06-03/index.md)
#     - [Hello, world!](./posts/2020-06-03/hello_world.md)

# Remove all content between "<!--BEGIN AUTO-ADD-->" and "<!--END AUTO-ADD-->"
cd src
sed -i '/^<!--BEGIN/,/^<!--END/{/^<!--BEGIN/!{/^<!--END/!d}}' SUMMARY.md

SUMMARYLENGTH="$(cat SUMMARY.md | wc -l)"
head "-n$((SUMMARYLENGTH-1))" SUMMARY.md > SUMMARY.md2
mv -f SUMMARY.md2 SUMMARY.md

# Begin generation
echo "- [Posts](./posts/index.md)" >> SUMMARY.md

cd posts
# We're using reverse sort here as we want series folders to be sorted before date folders
# and that also helps with dates, as they will be (mostly) sorted by newest to oldest
find -type d -not -name . -printf "%P\0" | sort -zr |
while IFS= read -r -d '' DIR
do
  DIR_NORMALIZED=$(echo "$DIR" | tr '_' ' ')
  # Automatically add src/posts/index.md to directories without it
  find "$DIR" -type f -name index.md | grep index.md 2>&1 > /dev/null || NOT_FOUND=1
  if [ ! -z $NOT_FOUND ]; then
    touch "$DIR/index.md"
  fi
  echo "  - [$DIR_NORMALIZED](./posts/$DIR/index.md)" >> ../SUMMARY.md
  # Get files in DIR
  find -L "$DIR" -type f -not -name index.md -printf "%P\0" | sort -z |
  while IFS= read -r -d '' FILE
  do
    # Get post name from the first line (e.g. "# Hello, world!" -> "Hello, world!")
    POSTNAME="$(head -n1 "$DIR/$FILE" | awk '{print substr($0,3);}')"
    echo "    - [$POSTNAME](./posts/$DIR/$FILE)" >> ../SUMMARY.md
    cat "$DIR/$FILE" | grep '##' | tr '\n' '\0' |
    while IFS= read -r -d '' SECTION_RAW
    do
      SECTION="$(echo "$SECTION_RAW" | awk '{print substr($0, 4);}')"
      SECTION_NORMALIZED="$(echo "$SECTION" | sed 's/[A-Z]/\L&/g' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')"
      echo "      - [$SECTION](./posts/$DIR/$FILE)" >> ../SUMMARY.md
    done
  done
done

echo "<!--END AUTO-ADD-->" >> ../SUMMARY.md

cd ../..
