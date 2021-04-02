FROM ubuntu:groovy
ARG TARGETARCH
ARG DEBIAN_FRONTEND="noninteractive"
ARG CABAL_VERSION=3.2.0.0
ARG GHC_VERSION=8.10.2
ARG NODE_VERSION=1.25.1
ARG JOBS="-j1"
# export TARGETARCH=arm64 DEBIAN_FRONTEND="noninteractive" CABAL_VERSION=3.2.0.0 GHC_VERSION=8.10.2 NODE_VERSION=1.25.1 JOBS="-j2"

RUN sed -i -e "s/^\# deb-src/deb-src/g" /etc/apt/sources.list \
  && apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install --no-install-recommends apt-utils bash curl wget ca-certificates automake build-essential pkg-config \
    libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget libncursesw5 libtool \
    autoconf cabal-install cabal-debian ghc llvm-11-dev clang-11 python3 libgmp-dev libncurses-dev libgmp3-dev happy alex \
    python3-sphinx texlive-xetex texlive-fonts-recommended fonts-lmodern texlive-latex-recommended texlive-latex-extra \
    linux-tools-generic xutils-dev

#Install target cabal
# RUN cabal update \
#   && cabal install ${JOBS} cabal-install-${CABAL_VERSION} --constraint="lukko -ofd-locking" \
#   && dpkg --purge cabal-install

