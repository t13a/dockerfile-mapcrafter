# Mapcrafter

Dockerfile for [Mapcrafter](https://mapcrafter.org/) a high performance Minecraft map renderer.

## Prerequisites

-  Minecraft world data in `/input`
   -  or backup archives named `[0-9_.]*.tar.gz` in `/backup`

## Usage

Get started with:

    docker \
    run --rm \
    -v $(pwd)/input:/input \
    -v $(pwd)/output:/output \
    t13a/mapcrafter

To use your configurations:

    docker \
    ...
    -v $(pwd)/render.conf:/etc/mapcrafter/render.conf \
    -v $(pwd)/template:/usr/share/mapcrafter/template \
    -v $(pwd)/texture:/usr/share/mapcrafter/texture \
    ...
    t13a/mapcrafter

And specify command line options:

    docker \
    ...
    t13a/mapcrafter \
    -b \
    -c /etc/mapcrafter/render.conf \
    -j 2

### Run in unprivileged user

    docker \
    ...
    -e PUID=1001 \
    -e PGID=1002 \
    ...
    t13a/mapcrafter

### Extract input from last backup

    docker \
    ...
    -e EXTRACT_LAST_BACKUP=yes \
    -v $(pwd)/backup:/backup \
    ...
    t13a/mapcrafter

Note that **all contents of `/input` will be removed**.
