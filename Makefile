build: ## Build sphinx html at a certain path
	docker compose -f docker-compose-builder.yaml run --build --rm -v $(path):/app docs-builder \
	bash -c 'rm -rf _build && make html SPHINXOPTS="-W --keep-going -n"'

serve: ## Serve html at a certain path
	docker compose -f docker-compose-server.yaml run --build --rm -p $(port):$(port) -v $(path):/app docs-server \
	/bin/sh -c "serve -n --no-port-switching -p $(port)"

pdf:
	docker compose -f docker-compose-pdf.yaml run --build --rm -v $(path):/app docs-pdf	\
	bash -c 'rm -rf _build && make latexpdf SPHINXOPTS="-W --keep-going -n"'

env: ## Set up the .env file, takes "spec" and "handbook" arguments representing the spec path and the handbook path
	echo SPEC_PATH="$(spec)" > .env
	echo HANDBOOK_PATH="$(handbook)" >> .env
	echo MIDYEAR_PATH="$(midyear)" >> .env
	echo FINAL_PATH="$(final)" >> .env
