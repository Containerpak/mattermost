FROM ubuntu:26.04 AS source

ADD --checksum=sha256:7efa135f9e8248aea360c81631fbb13af40c62d4d806fe09edb542f522f25380 https://github.com/mattermost/desktop/releases/download/v6.2.2/mattermost-desktop_6.2.2-1_amd64.deb /tmp/source

RUN dpkg-deb -x /tmp/source /out

FROM ghcr.io/containerpak/gtk3:main

COPY --from=source /out /
COPY icon.png /usr/share/icons/hicolor/128x128/apps/mattermost.png

RUN apt-get update && \
    apt-get install -y --no-install-recommends libasound2t64 libnss3 && \
    ln -s /opt/Mattermost/mattermost-desktop /usr/bin/mattermost-desktop && \
    cpak-clean-junk
