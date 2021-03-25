FROM alpine:latest

RUN apk add --no-cache snapcast-server

COPY ./run.sh /usr/local/bin/run.sh
COPY snapserver.conf /etc/snapserver.conf

RUN chmod +x /usr/local/bin/run.sh

EXPOSE 1704 1705 1780
ENTRYPOINT ["/usr/local/bin/run.sh"]