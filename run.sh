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
docker run --name ${name} --detach --restart=always \
	--volume /mnt/storage/docker/torrent:/var/lib/transmission-daemon \
	--env "VIRTUAL_HOST=torrent.servy.brk.one" \
	--env "VIRTUAL_PORT=9091" \
	--publish 9091:9091 \
	--publish 51413:51413 \
	torrent

