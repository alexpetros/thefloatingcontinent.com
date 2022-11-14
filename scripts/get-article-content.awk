# End each print with a space instead of a newline
BEGIN { ORS = " " }

# Include the stylesheets
/<link rel="stylesheet"/ { htmlEncodeAndPrint() }

# Start counting and printing lines when the article starts
articleStart { lines+=1; htmlEncodeAndPrint() }
/<article>/ { articleStart = 1 }

# If the article is done, exit
/<\/article>/ { exit 0 }

# if the lines run out, print a link then exit
lines > 25 {
  $0="<p><a href="url">Continue Reading...</a>"
  htmlEncodeAndPrint()
  exit 0
}

function htmlEncodeAndPrint() {
  gsub("&", "\\&amp;")
  gsub("<", "\\&lt;")
  gsub(">", "\\&gt;")
  gsub("\"", "\\&quot;")
  gsub("'", "\\&#x27;")
  gsub("/", "\\&#x2F;")
  gsub("`", "\\&grave;")
  gsub("=", "\\&#x3D;")

  print $0
}
