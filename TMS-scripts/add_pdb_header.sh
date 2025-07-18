#!/bin/bash

for file in "$@" ; do
  [ -f "$file" ] || continue  # skip if not a file

  name=$(basename "$file" .pdb)
  tmpfile=$(mktemp)

  echo "Processing: $file"
  echo "HEADER   $name" > "$tmpfile"

  # Append file contents, skipping any existing HEADER line
  grep -v '^HEADER' "$file" >> "$tmpfile"

  mv "$tmpfile" "$file"
  echo "→ Updated: HEADER   $name"
done
