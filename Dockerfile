FROM ubuntu:16.04
LABEL maintainer="Coindroid42 <support@coindroid.org>"
ARG HASH_MODULE
ARG DAEMON_BIN_URL
ARG DAEMON_URL
RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository --yes ppa:bitcoin/bitcoin && \
  add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update

RUN apt-get install -y build-essential python3.6 python3.6-dev python3-pip python3.6-venv
RUN apt-get install -y git

RUN python3.6 -m pip install pip --upgrade
RUN python3.6 -m pip install wheel


RUN apt -y install gcc g++ libleveldb-dev  build-essential libtool autotools-dev autoconf pkg-config libssl-dev git libminiupnpc-dev libdb4.8-dev libdb4.8++-dev build-essential libtool automake autotools-dev autoconf pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils libqrencode-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libboost-all-dev python3-pip zip rar wget curl gnupg libzmq5

RUN curl -sL https://deb.nodesource.com/setup_12.x  | bash -
RUN apt -y install nodejs net-tools
RUN pip3 install aiohttp pylru leveldb plyvel aiorpcx==0.10.5 ;
RUN pip3 install $HASH_MODULE
RUN npm install pm2 -g

VOLUME ["/data"]

ENV HOME /data
ENV ALLOW_ROOT 1
ENV DAEMON_URL http://%user%:%password%@localhost:35001/
ENV DAEMON_BIN ${HOME}/daemon/scribed
ENV DAEMON_BIN_URL $DAEMON_BIN_URL
ENV DB_DIRECTORY $HOME/electrum_db
ENV SSL_CERTFILE ${HOME}/electrumx.crt
ENV SSL_KEYFILE ${HOME}/electrumx.key
ENV HOST ""


RUN mkdir /electrumx
COPY . /electrumx 
EXPOSE 33001 34001 35001
WORKDIR /electrumx
RUN chmod +x bin/*
CMD ["bin/init"]
