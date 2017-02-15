#FROM openjdk:8-jre-alpine
FROM alpine:edge

RUN apk add --no-cache openjdk8-jre-base docker openssl openssh tar gzip xz bzip2

ADD container-init.sh /usr/local/bin/init

ENTRYPOINT [ "init" ]
EXPOSE 22

