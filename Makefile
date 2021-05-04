DOCKER_TAG := juampe/base-cabal
CABAL_VERSION := 3.4.0.0
BUILDX_CACHE := --cache-from type=local,mode=max,src=$(HOME)/buildx-cache --cache-to type=local,mode=max,dest=$(HOME)/buildx-cache

all: archs
	mkdir -p $(HOME)/buildx-cache
# docker buildx build $(BUILDX_CACHE) --platform linux/arm64/v8 --build-arg JOBS="-j12" --build-arg CABAL_VERSION=$(CABAL_VERSION) -t $(DOCKER_TAG) -t $(DOCKER_TAG):$(CABAL_VERSION) --push .

archs: arm64 amd64 riscv64
	$(eval CNAME := $(DOCKER_TAG):$(CABAL_VERSION)-$?)
	docker buildx build $(BUILDX_CACHE) --platform linux/$? --build-arg CABAL_VERSION=$(CABAL_VERSION) -t $(DOCKER_TAG):$(CABAL_VERSION)-$? .
	docker run --rm $(CNAME) cat /cabal/_build/artifacts/cabal-install-$(CABAL_VERSION)-$?-ubuntu-21.04-bootstrapped.tar.xz > repo/cabal-install-$(CABAL_VERSION)-$?-ubuntu-21.04-bootstrapped.tar.xz

riscv64:
	$(eval CNAME := $(DOCKER_TAG):$(CABAL_VERSION)-$@)
	echo docker buildx build $(BUILDX_CACHE) --platform linux/$@ --build-arg CABAL_VERSION=$(CABAL_VERSION) -t $(CNAME) .
	docker run --rm $(CNAME) cat /cabal/_build/artifacts/cabal-install-$(CABAL_VERSION)-$@-ubuntu-21.04-bootstrapped.tar.xz > repo/cabal-install-$(CABAL_VERSION)-$@-ubuntu-21.04-bootstrapped.tar.xz




