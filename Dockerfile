FROM ubuntu:15.04
MAINTAINER Dave Burke <thoughtcriminall@gmail.com>

RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

# This GID matches the ID of the group on the host system
# that owns the torrent dir.
RUN groupadd -g 1001 debian-transmission
RUN apt-get install -qy --force-yes transmission-daemon

COPY settings.json /etc/transmission-daemon/settings.json
RUN chown debian-transmission:debian-transmission /etc/transmission-daemon/settings.json

# Download directory
RUN chown -R debian-transmission:debian-transmission /var/lib/transmission-daemon
VOLUME /var/lib/transmission-daemon

#Web console
EXPOSE 9091

# Bittorrent
EXPOSE 51413

USER debian-transmission

ENTRYPOINT ["/usr/bin/transmission-daemon", "-f"]
# http://stackoverflow.com/a/29799703
