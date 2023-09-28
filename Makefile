ifneq (,$(wildcard ./.env))
    include .env
    export
endif

build = docker run --rm -it -v $(1):/app sphinxdoc/sphinx:7.1.2 bash -c "cd /app && rm -rf _build && make html"
serve = docker-compose run --build --rm -it -p $(2):$(2) -v $(1):/app server\
/bin/sh -c "cd /app/_build/html && serve -n --no-port-switching -p $(2)"

handbook:
	$(call build,${HANDBOOK_PATH})

spec:
	$(call build,${SPEC_PATH})

serve-handbook:
	$(call serve,${HANDBOOK_PATH},3000)

serve-spec:
	$(call serve,${SPEC_PATH},4000)

env: ## Set up the .env file, takes "spec" and "handbook" arguments representing the spec path and the handbook path
	echo SPEC_PATH="$(spec)" > .env
	echo HANDBOOK_PATH="$(handbook)" >> .env
