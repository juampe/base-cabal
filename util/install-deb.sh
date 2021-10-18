#!/bin/bash
ARCH=$1

echo "Download Debs for $ARCH"
#cat /etc/apt/sources.list|sed -e 's/^deb /deb-src /' >> /etc/apt/sources.list
#echo "nameserver 1.1.1.1" > /etc/resolv.conf
apt-get -y update 
apt-get -y upgrade

# case $ARCH in
#         amd64)
#         apt-get -y install debian-archive-keyring gnupg1
#         /bin/echo -ne "deb http://deb.debian.org/debian experimental main\ndeb-src http://deb.debian.org/debian experimental main\n"> /etc/apt/sources.list.d/experimental.list
#         /bin/echo -ne "Package: ghc*\nPin: release a=experimental\nPin-Priority: 600" > /etc/apt/preferences.d/ghc.pref
#         apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC
#         apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138
#         ;;
#         riscv64|arm64)
#         apt-get -y install debian-ports-archive-keyring
#         /bin/echo -ne "deb http://ftp.ports.debian.org/debian-ports experimental main\ndeb-src http://ftp.ports.debian.org/debian-ports experimental main\n"> /etc/apt/sources.list.d/experimental.list
#         /bin/echo -ne "Package: ghc*\nPin: release a=experimental\nPin-Priority: 600" > /etc/apt/preferences.d/ghc.pref
# 	    ;;
# esac

# apt-get -y update

case $ARCH in
	amd64|arm64)
        apt-get -y install --no-install-recommends bash python3 git ca-certificates automake autoconf libtool build-essential \
        pkg-config wget libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev libgmp-dev libncurses-dev libgmp3-dev \
        libnuma1 libnuma-dev llvm-9 llvm-9-dev llvm-13 llvm-13-dev
        ;;
        riscv64)
        apt-get -y install --no-install-recommends bash python3 git ca-certificates automake autoconf libtool build-essential \
        pkg-config wget libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev libgmp-dev libncurses-dev libgmp3-dev \
        libnuma1 libnuma-dev llvm-9 llvm-9-dev llvm-13 llvm-13-dev libatomic1 libatomic-ops-dev
        ;;
esac
