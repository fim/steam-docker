FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Serafeim Mellos <fim@mellos.io>

# Set wine prefix
ENV WINEPREFIX /wine

# Setting up the wineprefix to force 32 bit architecture.
ENV WINEARCH win32

# Disabling warning messages from wine, comment for debug purpose.
ENV WINEDEBUG -all

# Install requirements
RUN dpkg --add-architecture i386
RUN apt-get update -y && apt-get install -y software-properties-common && add-apt-repository -y ppa:ubuntu-wine/ppa
RUN apt-get update -y && apt-get install -y wine1.8 winetricks xvfb xauth

ADD http://repo.steampowered.com/steam/archive/precise/steam_latest.deb /tmp/steam.deb
RUN apt-get install -y /tmp/steam.deb
ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
