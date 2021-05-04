<!-- markdownlint-configure-file { "MD004": { "style": "consistent" } } -->
<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD033 -->
<p align="center" valign="center">
   <div>
        <img align="center" src="https://github.com/juampe/cardano-docker/blob/1.26.2/img/cardano-logo.png?raw=true" width="200" alt="Heart">
        <img align="center" src="https://github.com/juampe/cardano-docker/blob/1.26.2/img/heart.png?raw=true" width="40" alt="Heart">
        <img align="center" src="https://github.com/juampe/cardano-docker/blob/1.26.2/img/rpi.png?raw=true" width="60" alt="RPi">
        <img align="center" src="https://github.com/juampe/cardano-docker/blob/1.26.2/img/heart.png?raw=true" width="40" alt="Heart">
        <img align="center"  src="https://github.com/juampe/cardano-docker/blob/1.26.2/img/graviton.png?raw=true" width="200" alt="Graviton">
    </div>
    <br>
    <strong>Cardano the decentralized third-generation proof-of-stake blockchain platform.</strong>
</p>
<!-- markdownlint-enable MD033 -->

# Cabal docker container to build cardano. 🐳
Cardano docker is can now be supported as container a in Raspberri Pi or AWS Gravitron container platform.
It is based in ubuntu focal builder in a documented and formal way (supply chain review).

Access to the multi-platform docker [image](https://hub.docker.com/r/juampe/base-cabal).

Access to the Git [repository](https://github.com/juampe/base-cabal)
# Minimize supply chain attack. 🔗
You can supervise all the sources, all the build steps, build yourserlf.
# Multi-platform 64 bit image 👪
Supported platforms:

* linux/amd64
* linux/arm64
* linux/riscv64

# A complex building proccess recipe to build cardano. 🔥
We are working very hard, to bring this container. The building process in quemu arm64 is huge (20 times slower).
Please undestand that this is an "spartan race" building process due to qemu limitations.
We planned to made in 3 phases:
* Phase 1 Build Cabal 3.4.0.0 with qemu of OFD Locking
 * Build with Github action in 12896s
 * Build with amd64 12VCPU 32GMEM 50GSSD in 7045s
* Phase 2 Build ghc 8.10.4 compatible with state-of-the-art qemu for multi architecture CI/CD
 * Unable to use Github action due to service limitations
 * Build with amd64 12VCPU 32GMEM 50GSSD in 26513s
* Phase 3 Bulid Cardano 1.25.1
 * Unable to use Github action due to service limitations
 * Unable to use qemu with amd64 due to ghc-pkg OFD hLock 
 * Build with arm64v8 Gravitron

# Build your own container. 🏗️
From a x64 ubuntu:groovy prepare for docker buildx multiarch environment
```
#Dependencies
apt-get update
apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get -y install qemu binfmt-support qemu-user-static docker-ce byobu make

export DOCKER_CLI_EXPERIMENTAL=enabled

#Make buildx
mkdir -p ~/.docker/cli-plugins/
DOCKER_BUILDKIT=1 docker build --platform=local -o . git://github.com/docker/buildx
mv buildx ~/.docker/cli-plugins/docker-buildx
chmod a+x ~/.docker/cli-plugins/docker-buildx
          
#only work in x64
#docker run --rm --privileged docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3

#make multi-arch builder
docker buildx create --name builder
docker buildx use builder
docker buildx inspect --bootstrap
docker buildx ls

#Build the artifact
git clone https://github.com/juampe/base-cabal.git
cd base-cabal

#Adapt Makefile to DOCKER_TAG to tag and fit your own docker registry
make
#Artifact goes to repo directory
```

# Enjoy!🍿
🙏If you apprecciate the effort, please consider to support us making a Cardano (ADA) donation.
>addr1qys8y92emhj6r5rs7puw6df9ahcvna6gtdm7jlseg8ek7xf46xjc0eelmgtjvmcl9tjgaamz93f4e5nu86dus6grqyrqd28l0r