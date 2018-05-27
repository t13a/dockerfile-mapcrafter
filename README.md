# Mapcrafter

Dockerfile for [Mapcrafter](https://mapcrafter.org/) a high
performance Minecraft map renderer.

## Prerequisites

-  Minecraft world data in `/input`
-  or backup archives named with `[0-9_.]*.tar.gz` in `/backup`

## Usage

Get started with.

    docker \
    run --rm \
    -v $(pwd)/input:/input \
    -v $(pwd)/output:/output \
    t13a/mapcrafter

Use custom configurations and command line options:

    docker \
    ...
    -v $(pwd)/render.conf:/render.conf \
    -v $(pwd)/template:/usr/share/mapcrafter/template \
    -v $(pwd)/texture:/usr/share/mapcrafter/texture \
    ...
    t13a/mapcrafter \
    -c /render.conf \
    -j 2

Run in unprivileged user:

    docker \
    ...
    -e PUID=1001 \
    -e PGID=1002 \
    ...
    t13a/mapcrafter

Extract input from last backup:

    docker \
    ...
    -e EXTRACT_LAST_BACKUP=yes \
    -v $(pwd)/backup:/backup \
    ...
    t13a/mapcrafter

For use this feature, please note that **all contents of `/input/*`
will be removed**. If there are no backups or no changes then do
nothing.
