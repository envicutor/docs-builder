build = docker-compose run --rm -it $(1) bash -c "cd /$(3) && $(2) $(3).tex"
build_pdf = $(call build,pdf-builder,pdflatex,$(1))
build_html = $(call build,html-builder,latex2html,$(1))

env: ## Copy .env.sample to .env
	cp .env.sample .env

spec: ## Build the specification document
	$(call build_pdf,spec)

handbook: ## Build the handbook
	$(call build_pdf,handbook)

html: ## Build the html files
	$(call build_html,spec)
	$(call build_html,handbook)
