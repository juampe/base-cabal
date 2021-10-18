.PHONY : archs all
DOCKER_TAG := juampe/base-cabal
UBUNTU := ubuntu:impish
CABAL_VERSION := 3.6.0.0
GHC_VERSION := 8.10.4
BUILDAH_CACHE := -v $(HOME)/.cabal:/root/.cabal -v $(PWD)/repo:/repo
JOBS := -j1

all: $(addprefix build-, $(ARCHS))

archs: $(addprefix build-, $(ARCHS))

qemu:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

build-%64:
	$(eval ARCH := $(subst build-,,$@))
	$(eval ARCH_TAG := $(DOCKER_TAG):$(CABAL_VERSION)-$(ARCH))
	buildah bud $(BUILDAH_CACHE) --format docker --layers --platform linux/$(ARCH) --build-arg UBUNTU=$(UBUNTU) --build-arg TARGETARCH=$(ARCH) --build-arg CABAL_VERSION=$(CABAL_VERSION) --build-arg GHC_VERSION=$(GHC_VERSION) -t $(ARCH_TAG) -f Dockerfile .