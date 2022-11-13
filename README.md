# The Floating Continent
My website. You can find it at https://thefloatingcontinent.com.

## Deployment
At the moment, there isn't anything to deploy! I serve the website locally with `npx serve`, which is part of the NodeJS toolchain. It's just static files, but your server has to be willing to serve `/example.html` files at `/example`, which a surprising number of servers are reluctant to do!

## RSS
Running `make rss` will build the RSS feed from the `*.html` files in the blog directory. This command is mostly indempotent (i.e. you can run it multiple times and it will just overwrite the existing `rss.xml` with the exact same file) except that the `lastBuildDate` element will change based on when you ran the script.

To "publish", just commit the new version of the RSS feed.
