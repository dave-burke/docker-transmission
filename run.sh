#!/bin/bash

docker run --name torrent -d -v /mnt/media/torrent:/var/lib/transmission-daemon -p 9091:9091 -p 51413:51413 torrent

