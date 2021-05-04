FROM juampe/ubuntu:hirsute
ARG DEBIAN_FRONTEND="noninteractive"
ARG CABAL_VERSION=3.4.0.0
ARG GHC_VERSION=8.8.4
ARG JOBS="-j1"
# export DEBIAN_FRONTEND="noninteractive" CABAL_VERSION=3.4.0.0 JOBS="-j1"

RUN sed -i -e "s/^\# deb-src/deb-src/g" /etc/apt/sources.list \
  && apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install --no-install-recommends bash python3 git ca-certificates automake autoconf libtool build-essential \ 
    pkg-config ghc libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev libgmp-dev libncurses-dev libgmp3-dev \ 
  && apt-get -y clean

#Install target cabal

RUN git clone https://github.com/haskell/cabal.git /cabal \
  && cd /cabal \
  && git checkout Cabal-v${CABAL_VERSION}

COPY linux-${GHC_VERSION}.json /cabal/bootstrap/ 

RUN cd /cabal \
  && ./bootstrap/bootstrap.py -d ./bootstrap/linux-${GHC_VERSION}.json


