#!/bin/bash
ARCH=$1
GHC_VERSION=$2
CABAL_VERSION=$3

echo "Build cabal for $ARCH"

case $ARCH in
        amd64|arm64)
                cd /cabal
                #./bootstrap/bootstrap.py -d ./bootstrap/linux-${GHC_VERSION}.json
                cabal install -j1 --project-file=cabal.project.release --overwrite-policy=always cabal-install
                
                #mkdir -p /cabal/_build/artifacts/
                #cd /usr/local/bin/
                #tar -cJf /cabal/_build/artifacts/cabal-install.tar.xz ./cabal
        ;;
        riscv64)
                cd /cabal
                cabal install -j1 --ghc-options='-latomic' --project-file=cabal.project.release --overwrite-policy=always cabal-install
        ;;
esac

cat ~/.cabal/bin/cabal > /tmp/cabal
chmod 755 /tmp/cabal
cd /tmp
tar -cJf /cabal-install.tar.xz ./cabal