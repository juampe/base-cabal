DOCKER_TAG := juampe/base-cabal
CABAL_VERSION := 3.4.0.0
BUILDX_CACHE := --cache-from type=local,mode=max,src=$(HOME)/buildx-cache --cache-to type=local,mode=max,dest=$(HOME)/buildx-cache
BUILDX_CACHE := ""

all: archs
	
archs: amd64 arm64 riscv64

amd64:
	$(eval CNAME := $(DOCKER_TAG):$(CABAL_VERSION)-$@)
	docker buildx build $(BUILDX_CACHE) --platform linux/$@ --build-arg CABAL_VERSION=$(CABAL_VERSION) -t $(CNAME) --push .
	docker run --rm $(CNAME) cat /cabal/_build/artifacts/cabal-install-$(CABAL_VERSION)-x86_64-ubuntu-21.04-bootstrapped.tar.xz > repo/cabal-install-$(CABAL_VERSION)-$@-ubuntu-21.04-bootstrapped.tar.xz

arm64:
	$(eval CNAME := $(DOCKER_TAG):$(CABAL_VERSION)-$@)
	docker buildx build $(BUILDX_CACHE) --platform linux/$@ --build-arg CABAL_VERSION=$(CABAL_VERSION) -t $(CNAME) .
	docker run --rm $(CNAME) cat /cabal/_build/artifacts/cabal-install-$(CABAL_VERSION)-$@-ubuntu-21.04-bootstrapped.tar.xz > repo/cabal-install-$(CABAL_VERSION)-$@-ubuntu-21.04-bootstrapped.tar.xz

riscv64:
	$(eval CNAME := $(DOCKER_TAG):$(CABAL_VERSION)-$@)
	docker buildx build $(BUILDX_CACHE) --platform linux/$@ --build-arg CABAL_VERSION=$(CABAL_VERSION) -t $(CNAME) .
	docker run --rm $(CNAME) cat /cabal/_build/artifacts/cabal-install-$(CABAL_VERSION)-$@-ubuntu-21.04-bootstrapped.tar.xz > repo/cabal-install-$(CABAL_VERSION)-$@-ubuntu-21.04-bootstrapped.tar.xz




