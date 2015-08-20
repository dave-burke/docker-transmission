FROM ubuntu:15.04
MAINTAINER Dave Burke <thoughtcriminall@gmail.com>

RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

# These commands should be run on the host as well,
# The uid and gid must be the same, but the names 
# can be different and the user need not have a 
# home directory.
RUN groupadd -g 51413 debian-transmission
RUN useradd -u 51413 -g 51413 -d /var/lib/transmission-daemon debian-transmission

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

CMD ["/usr/bin/transmission-daemon", "-f", "--config-dir", "/etc/transmission-daemon/"]

