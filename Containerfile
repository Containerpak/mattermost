FROM ubuntu:26.04 AS source

ADD --checksum=sha256:2f8c63566e50259ebf446033471503b62674d99ec6d98b11a205093a5919902c https://github.com/mattermost/desktop/releases/download/v6.3.0/mattermost-desktop_6.3.0-1_amd64.deb /tmp/source

RUN dpkg-deb -x /tmp/source /out

FROM ghcr.io/containerpak/gtk3:main

COPY --from=source /out /
COPY icon.png /usr/share/icons/hicolor/128x128/apps/mattermost.png

RUN apt-get update && \
    apt-get install -y --no-install-recommends libasound2t64 libnss3 && \
    ln -s /opt/Mattermost/mattermost-desktop /usr/bin/mattermost-desktop && \
    cpak-clean-junk
