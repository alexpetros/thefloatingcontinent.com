#!/bin/bash
set -eu

DOMAIN="https://thefloatingcontinent.com"
BUILDATE=$(date -I date)

# Build the top-level XML elements
cat <<EOF
<?xml version="1.0" encoding="utf-8"?>

<rss version="2.0">
  <channel>
    <title>The Floating Continent</title>
    <link>https://thefloatingcontinent.com</link>
    <description>The personal website and blog of Alexander Petros</description>
    <lastBuildDate>$BUILDATE</lastBuildDate>
    <language>en-us</language>
EOF

# Sort the filenames based on the post's publication date element
filenames=""
for post in ./html/blog/*.html; do
  date=$(grep pubdate "$post" | sed -E 's/.*datetime="([^"]*)".*/\1/')
  printf -v filenames "$filenames\n$date $post"
done
sortedFilenames=$(echo "$filenames" | sort -nr | cut -d ' ' -f 2)

# For each file (now sorted reverse chronologically), build the item element
for post in $sortedFilenames; do
  filename=$(basename $post)
  slug=${filename%.html}
  url="$DOMAIN/blog/$slug"
  date=$(grep pubdate "$post" | sed -E 's/.*datetime="([^"]*)".*/\1/')
  cat <<EOF
    <item>
      <title>$filename</title>
      <link>$url</link>
      <guid>$url</guid>
      <pubdate>$date</pubdate>
    </item>
EOF
done

# Close off the rest of the document
cat <<EOF
  </channel>
</rss>
EOF


