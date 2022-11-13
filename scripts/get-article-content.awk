# End each print with a space instead of a newline
BEGIN { ORS = " " }

# Include the stylesheets
/<link rel="stylesheet"/ { print $0 }

# Start counting and printing lines when the article starts
/<article>/ { articleStart = 1 }
articleStart { lines+=1; print $0 }

# If the article is done, exit; if the lines run out, print a link then exit
/<\/article>/ { exit 0 }
lines > 25 { print "<a href="url">Continue Reading...</a>"; exit 0 }
