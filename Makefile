all:
	docker buildx build --platform linux/arm64/v8,linux/amd64 --build-arg JOBS="-j2" -t juampe/base-cabal --push .