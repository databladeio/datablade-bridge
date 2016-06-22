FROM alpine:3.4

# Add testing repo until autossh is added to the main repo
RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update && apk upgrade && apk add ca-certificates

RUN apk add autossh@testing && apk add sshpass

# Cleanup
RUN rm -rf /var/cache/apk/*

CMD sshpass -p ${PASSWORD} autossh -M 0 -N -R ${BRIDGE_PORT}:${DEST}:${DEST_PORT} bridgeuser${BRIDGE_PORT}:@bridge.datablade.io -o ServerAliveInterval=10 -o ServerAliveCountMax=1 -o ExitOnForwardFailure=yes
