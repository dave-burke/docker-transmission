#!/bin/bash

name="torrent"
cid="$(docker ps -q --filter "name=${name}")"
if [ -n "${cid}" ]; then
	echo "Stopping container..."
	docker stop "${name}" > /dev/null
fi
cid="$(docker ps -a -q --filter "name=${name}")"
if [ -n "${cid}" ]; then
	echo "Removing container..."
	docker rm "${name}" > /dev/null
fi

echo "Running container..."
docker run --name ${name} --detach --restart=always --volume /mnt/media/torrent:/var/lib/transmission-daemon --publish 9091:9091 --publish 51413:51413 torrent

