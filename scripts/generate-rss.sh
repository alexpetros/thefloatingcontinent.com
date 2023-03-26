#!/bin/bash
#
# Name: generate-rss.sh
# Author: Alexander Petros
# Description: Output an RSS feed based on the HTML files in the blog directory
#
# This will create a valid RSS feed by parsing the HTML files that comprise the
# blog. Obvious there is some stuff specific to my directory structure that is
# baked in here, but the main assumptions are:
#   a) It uses the MacOS flavor of the `date` command
#   b) The post contains a `time` element with the "pubdate" class in format "YYYY-MM-DD"
# Everything else is pretty standard. RSS is... really simple!

set -eu

DOMAIN="https://thefloatingcontinent.com"
BUILDATE=$(date -R)

# Build the top-level XML elements
cat <<EOF
<?xml version="1.0" encoding="utf-8"?>

<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/">
  <channel>
    <title>The Floating Continent</title>
    <link>$DOMAIN</link>
    <atom:link href="$DOMAIN/rss.xml" rel="self" type="application/rss+xml" />
    <description>The personal website and blog of Alexander Petros</description>
    <lastBuildDate>$BUILDATE</lastBuildDate>
    <language>en-us</language>
EOF

# Sort the filenames based on the post's publication date element
filenames=""
for post in ./html/blog/*.html; do
  pubdate=$(grep pubdate "$post" | sed -E 's/.*datetime="([^"]*)".*/\1/')
  printf -v filenames "%s\n%s %s" "$filenames" "$pubdate" "$post"
done
sortedFilenames=$(echo "$filenames" | sort -nr | cut -d ' ' -f 2)

# For each file (now sorted reverse chronologically), build the item element
for post in $sortedFilenames; do
  title=$(grep 'title' "$post" | head -1 | sed -E 's/<\/?title>//g')
  filename=$(basename "$post")
  slug=${filename%.html}
  url="$DOMAIN/blog/$slug"
  content=$(awk -f ./scripts/get-article-content.awk -v url="$url" "$post")
  pubdate=$(grep pubdate "$post" | sed -E 's/.*datetime="([^"]*)".*/\1/')
  fulldate="$(date -jf "%Y-%m-%d" "$pubdate" "+%a, %d %b %Y") 10:00:00 -0500"

  cat <<EOF
    <item>
      <title>$title</title>
      <link>$url</link>
      <guid>$url</guid>
      <pubDate>$fulldate</pubDate>
      <content:encoded>$content</content:encoded>
    </item>
EOF
done

# Close off the rest of the document
cat <<EOF
  </channel>
</rss>
EOF


