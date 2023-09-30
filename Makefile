build: ## Build sphinx html at a certain path
	docker compose run --build --rm -v $(path):/app builder	\
	bash -c 'cd /app && rm -rf _build && make html SPHINXOPTS="-W --keep-going -n"'

serve: ## Serve html at a certain path
	docker compose run --build --rm -it -p $(port):$(port) -v $(path):/app server \
	/bin/sh -c "cd /app/_build/html && serve -n --no-port-switching -p $(port)"

env: ## Set up the .env file, takes "spec" and "handbook" arguments representing the spec path and the handbook path
	echo SPEC_PATH="$(spec)" > .env
	echo HANDBOOK_PATH="$(handbook)" >> .env
