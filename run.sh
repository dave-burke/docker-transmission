#!/bin/bash

docker run -it -v /mnt/media/torrents:/var/lib/transmission-daemon -p 9091:9091 -p 51413:51413 torrent

