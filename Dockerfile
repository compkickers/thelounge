FROM node:alpine

LABEL sh.demyx.image demyx/thelounge
LABEL sh.demyx.maintainer Demyx <info@demyx.sh>
LABEL sh.demyx.url https://demyx.sh
LABEL sh.demyx.github https://github.com/demyxco
LABEL sh.demyx.registry https://hub.docker.com/u/demyx

# Set default environment variables
ENV TZ=America/Los_Angeles
ENV NODE_ENV=production

# Create demyx user and install tzdata
RUN set -ex; \
    addgroup -g 1001 -S demyx; \
    adduser -u 1001 -D -S -G demyx demyx; \
    apk add --no-cache --update tzdata

# Finalize
RUN set -ex; \
    yarn --non-interactive --frozen-lockfile global add thelounge; \
    yarn --non-interactive cache clean; \
    install -d -m 0755 -o demyx -g demyx /var/opt/thelounge

EXPOSE 9000

USER demyx

ENTRYPOINT ["thelounge", "start"]
