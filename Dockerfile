FROM ubuntu:16.04
MAINTAINER Dave Burke "dburke84@gmail.com"

ENV uid=1000
ENV gid=1000
RUN groupadd -g $gid debian-transmission
RUN useradd -u $uid -g $uid -d /var/lib/transmission-daemon debian-transmission

RUN apt-get --quiet update && apt-get install --quiet --assume-yes --allow-downgrades --allow-remove-essential --allow-change-held-packages transmission-daemon

COPY settings.json /etc/transmission-daemon/settings.json
RUN chown debian-transmission:debian-transmission /etc/transmission-daemon/settings.json

# Download directory
RUN chown -R debian-transmission:debian-transmission /var/lib/transmission-daemon
VOLUME /var/lib/transmission-daemon

# Web console
EXPOSE 9091

# Bittorrent
EXPOSE 51413

USER debian-transmission

CMD ["/usr/bin/transmission-daemon", "-f", "--config-dir", "/etc/transmission-daemon/"]

