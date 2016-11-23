#!/bin/bash

docker build --pull -t torrent $@ $(dirname $0)

