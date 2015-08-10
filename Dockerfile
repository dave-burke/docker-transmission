FROM ubuntu:15.04

MAINTAINER Dave Burke <thoughtcriminall@gmail.com>
RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

RUN apt-get install -qy --force-yes transmission-daemon

COPY settings.json /etc/transmission-daemon/settings.json
RUN chown debian-transmission:debian-transmission /etc/transmission-daemon/settings.json

# Download directory
VOLUME /var/lib/transmission-daemon

#Web console
EXPOSE 9091

# Bittorrent
EXPOSE 51413

USER debian-transmission

#ENTRYPOINT ["/usr/bin/transmission-daemon", "-f"]

