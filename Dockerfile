# syntax=docker/dockerfile:1.2
ARG UBUNTU="ubuntu:hirsute"
FROM ${UBUNTU}

ARG TARGETARCH
ARG DEBIAN_FRONTEND="noninteractive"
ARG CABAL_VERSION=3.6.0.0
ARG GHC_VERSION=8.10.4
ARG JOBS="-j1"
# export DEBIAN_FRONTEND="noninteractive" TARGETARCH=riscv64 CABAL_VERSION="3.6.0.0" GHC_VERSION="8.10.4" JOBS="-j1"

COPY util/ /util/

RUN /util/install-deb.sh ${TARGETARCH}
RUN /util/install-ghc.sh ${TARGETARCH} ${GHC_VERSION}
RUN /util/install-cabal.sh ${TARGETARCH} 3.4.0.0

#Install target cabal
RUN git clone https://github.com/haskell/cabal.git /cabal \
  && cd /cabal \
  && git checkout Cabal-v${CABAL_VERSION}

RUN /util/build-cabal.sh ${TARGETARCH} ${GHC_VERSION}
#--ghc-options='-latomic'
#RUN cd /cabal && cabal install -j1 --ghc-options='-latomic' --project-file=cabal.project.release cabal-install
#RUN cd /cabal \
#  && sed -i  "s/ghc-options:      -Wall/ghc-options: -Wall -latomic/" /cabal/bootstrap/cabal-bootstrap-gen.cabal \
#  && ./bootstrap/bootstrap.py -d ./bootstrap/linux-${CABAL_VERSION}-${GHC_VERSION}.json
# && /bin/echo -ne  "\npackage entropy\n  flags: -latomic\n  ghc-options: -latomic\n" >>  cabal.project.local \
#   bck/Dockerfile:  && /usr/local/bin/cabal build --ghc-options='-latomic' ${JOBS} cardano-cli cardano-node

#RUN . /etc/os-release && cp /cabal/_build/artifacts/cabal-install*.tar.xz /repo/cabal-install-${CABAL_VERSION}-${TARGETARCH}-ubuntu-${VERSION_ID}-bootstrapped.tar.xz
RUN . /etc/os-release && cp /cabal-install.tar.xz /repo/cabal-install-${CABAL_VERSION}-${TARGETARCH}-ubuntu-${VERSION_ID}-bootstrapped.tar.xz