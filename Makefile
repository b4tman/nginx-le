package_name = nginx-le
repository = toolen/nginx-le
version = 1.0.0
image_tag = ghcr.io/$(repository):$(version)
hadolint_version=2.12.0
trivy_version=0.45.1

image:
	export DOCKER_BUILDKIT=1
	make hadolint
	docker build --pull --no-cache -t $(image_tag) .
	make trivy

push-to-ghcr:
	docker login ghcr.io -u toolen -p $(CR_PAT)
	docker push $(image_tag)

hadolint:
	docker run --rm -i hadolint/hadolint:$(hadolint_version) < Dockerfile

trivy:
	docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ~/.cache/trivy:/root/.cache/ aquasec/trivy:$(trivy_version) image --ignore-unfixed $(image_tag)
