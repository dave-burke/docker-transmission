#!/bin/bash

docker build --rm=true -t torrent $@ $(dirname $0)

