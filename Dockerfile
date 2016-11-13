FROM resin/rpi-raspbian:jessie-20160831

ENV BOT_VERSION="0.99.10"

# Preparing environment
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" | tee /etc/apt/sources.list.d/debian-backports.list &&\
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF &&\
 echo "deb http://download.mono-project.com/repo/debian wheezy/snapshots/4.2 main" | tee /etc/apt/sources.list.d/mono-xamarin.list &&\
 apt-get update && apt-get -y install libraspberrypi0 libopus0 opus-tools libopus-dev ffmpeg mono-devel ca-certificates-mono && apt-get autoremove && apt-get clean &&\
 mozroots --import --ask-remove --machine &&\
 printf "y\ny\ny\n" | certmgr -ssl https://discordapp.com &&\
 printf "y\ny\n" | certmgr -ssl https://gateway.discordapp.gg &&\
 mkdir /opt/nadekobot /botfiles

WORKDIR /opt/nadekobot

# Installing bot
RUN apt-get update && apt-get -y install curl unzip &&\
 curl -LOk https://github.com/Kwoth/NadekoBot/releases/download/v${BOT_VERSION}/NadekoBot.${BOT_VERSION}.zip &&\
 unzip Nadeko*.zip && rm -f Nadeko*.zip &&\
 apt-get -y purge curl unzip && apt-get -y autoremove && apt-get clean

CMD ["mono", "NadekoBot.exe"]
