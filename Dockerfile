FROM juampe/ubuntu:hirsute
ARG DEBIAN_FRONTEND="noninteractive"
ARG CABAL_VERSION=3.4.0.0
ARG JOBS="-j1"
# export DEBIAN_FRONTEND="noninteractive" CABAL_VERSION=3.4.0.0 JOBS="-j1"

RUN sed -i -e "s/^\# deb-src/deb-src/g" /etc/apt/sources.list \
  && apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install --no-install-recommends apt-utils bash curl wget ca-certificates automake build-essential pkg-config \
    libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget libncursesw5 libtool \
    autoconf cabal-install cabal-debian ghc llvm-11-dev clang-11 python3 libgmp-dev libncurses-dev libgmp3-dev happy alex \
    python3-sphinx texlive-xetex texlive-fonts-recommended fonts-lmodern texlive-latex-recommended texlive-latex-extra \
    linux-tools-generic xutils-dev \
  && apt-get -y clean

#Install target cabal
# RUN cabal update \
#   && cabal v2-install ${JOBS} cabal-install-${CABAL_VERSION} --overwrite-policy=always -v3 \
#   && dpkg --purge cabal-install

RUN git clone https://github.com/haskell/cabal.git /cabal 
COPY linux-8.8.4.json /cabal/bootstrap/
  && cd /cabal \
  && git checkout Cabal-v3.4.0.0 \
  && cp bootstrap/linux-8.8.3.json bootstrap/linux-8.8.4.json \
  && sed -i -e "s/0.10.10.0/0.10.10.1/" bootstrap/linux-8.8.4.json \
  && sed -i -e "s/8.8.3/8.8.4/" bootstrap/linux-8.8.4.json \
  && sed -i -e "s/1.6.8.0/1.6.9.0/" bootstrap/linux-8.8.4.json \
  && ./bootstrap/bootstrap.py -d ./bootstrap/linux-8.8.4.json


