# Instructions from the blog post at http://blog.bittorrent.com/2013/10/22/sync-hacks-deploy-bittorrent-sync-with-docker/
FROM ubuntu:14.04

MAINTAINER Lucas Carlson <lucas@rufy.com>

# Set the reset cache variable
ENV REFRESHED_AT 2015-06-29

RUN apt-get update && \
    apt-get install -y curl && \
    cd /usr/bin && \
    curl http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable | tar xvz

# Create directories required by btsync
RUN mkdir -p /btsync/.sync /var/run/btsync /data

EXPOSE 8888
EXPOSE 55555

# Add configuration file
ADD config/btsync.conf /btsync/btsync.conf
# Add start script
ADD start-btsync /usr/bin/start-btsync
# Make start script executable
RUN chmod +x /usr/bin/start-btsync

VOLUME ["/data"]
ENTRYPOINT ["start-btsync"]