FROM ubuntu:14.04

RUN apt-get update && apt-get install -y curl

RUN curl -o /usr/bin/btsync.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable

RUN cd /usr/bin && tar -xzvf btsync.tar.gz && rm btsync.tar.gz
RUN mkdir -p /btsync/.sync
RUN mkdir -p /var/run/btsync
RUN mkdir -p /data

# reduce btsync log level
RUN echo '00000000' > /btsync/.sync/debug.txt

EXPOSE 3000
EXPOSE 8888
EXPOSE 55555

ADD start-btsync /usr/bin/start-btsync
RUN chmod +x /usr/bin/start-btsync

VOLUME ["/data"]

ENTRYPOINT ["start-btsync"]
