# The Floating Continent
My website. You can find it at https://thefloatingcontinent.com.

## Philosophy
This website does not have a build step and I write all the HTML by hand.
This is often annoying (I would prefer to inline my stylesheets, I have to copy and paste headers, etc.) but I think it's the right move for me for the foreseeable future, for a few reasons.

HTML is designed to be written by hand.
Tools that compile to HTML will probably go out of date, but HTML shows no signs of doing the same, therefore reading documentation about HTML is likely a good investment of my time, while reading documentation about Jekyll or Hugo is not.
I'm reasonably confident that this makes up for the time lost copying and pasting headers.

Writing HTML by hand requires you to write _good_ HTML, in order to make the copying and pasting less onerous.
It requires more thought about the proper use of sematics, stylesheets, and so on.
This is probably not how I would build a website for a company, but it does teach good habits for using more powerful tools.
Markdown is fine, but the better you get at HTML, the more you appreciate the flexibility it affords.
You almost don't miss Markdown.
Almost.

There might come a time when I implement a templating mechanism of some sort, but it will still adhere to this philosophy: leverage as much of power of the base web stack as possible.
Writing an RSS generator in bash/awk is fun!

## Development
I serve the website locally with `serve`, which is part of the NodeJS toolchain.
It's just static files, but your server has to be willing to serve `/example.html` files at `/example`, which a surprising number of servers are reluctant to do!
You can install serve with `npm install -g serve`, and then the `make` command will serve the website.

`make validate` runs the HTML validator `vnu` against the `html` directory.
This requires `vnu` to be installed.

## Deployment
Link any static file server to the `html` directory to deploy the website.
I use nginx, which requires a tiny config change to serve `.html` files without the file extension.

## RSS
Running `make rss` will build the RSS feed from the `*.html` files in the blog directory.
This command is mostly indempotent (i.e. you can run it multiple times and it will just overwrite the existing `rss.xml` with the exact same file) except that the `lastBuildDate` element will change based on when you ran the script.

To "publish", just commit the new version of the RSS feed.
