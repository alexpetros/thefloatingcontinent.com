# USAGE: awk -f teams-to-files.awk TEAMS_FP
# It will populate the directory you run it in with files, so make sure you run the program from
# the directory where you want all those files
BEGIN { FS="===" }

/===/ {
  first_slash = match($2, "/")
  name = substr($2, first_slash + 1)
  gsub(/ *$/, "", name)
  path = tolower(name)
  gsub(/ /, "-", path)
  print "<a href=\""path"\">"name"</a>"
}

path {
  print $0 > path
}
