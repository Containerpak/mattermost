FROM ghcr.io/containerpak/gtk:main

ADD --checksum=sha256:7efa135f9e8248aea360c81631fbb13af40c62d4d806fe09edb542f522f25380 https://github.com/mattermost/desktop/releases/download/v6.2.2/mattermost-desktop_6.2.2-1_amd64.deb /tmp/source
COPY icon.png /usr/share/icons/hicolor/128x128/apps/mattermost.png

RUN apt-get update && \
    apt-get install -y --no-install-recommends libasound2t64 libgtk-3-0 libnss3 && \
    dpkg-deb -x /tmp/source / && \
    cpak-clean-junk
