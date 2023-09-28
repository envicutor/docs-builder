build: ## Build sphinx html at a certain path
	docker run --rm -it -v $(path):/app sphinxdoc/sphinx:7.1.2 bash -c "cd /app && rm -rf _build && make html"

serve: ## Serve html at a certain path
	docker-compose run --build --rm -it -p $(port):$(port) -v $(path):/app server \
	/bin/sh -c "cd /app/_build/html && serve -n --no-port-switching -p $(port)"

env: ## Set up the .env file, takes "spec" and "handbook" arguments representing the spec path and the handbook path
	echo SPEC_PATH="$(spec)" > .env
	echo HANDBOOK_PATH="$(handbook)" >> .env
