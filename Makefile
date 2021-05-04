DOCKER_TAG := juampe/base-cabal
CABAL_VERSION := 3.4.0.0
BUILDX_CACHE := --cache-from type=local,mode=max,src=$(HOME)/buildx-cache --cache-to type=local,mode=max,dest=$(HOME)/buildx-cache

all: archs
	
archs: amd64 arm64 riscv64

cache:
	mkdir -p $(HOME)/buildx-cache 2>/dev/null

%64: cache
	$(eval CNAME := $(DOCKER_TAG):$(CABAL_VERSION)-$@)
	docker buildx build $(BUILDX_CACHE) --platform linux/$@ --build-arg CABAL_VERSION=$(CABAL_VERSION) -t $(CNAME) --push .
	docker run --rm $(CNAME) bash -c 'cat /cabal/_build/artifacts/cabal-install*.tar.xz' > repo/cabal-install-$(CABAL_VERSION)-$@-ubuntu-21.04-bootstrapped.tar.xz





