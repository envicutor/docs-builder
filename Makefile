run = docker-compose run --rm -it $(1) bash -c "cd /$(3) && $(2)"
build_pdf = $(call run,pdf-builder,latexmk -pdf $(1).tex,$(1))
clean = $(call run,pdf-builder,latexmk -C,$(1))
define build_html =
make clean-$(1)
$(call run,pdf-builder,latexmk $(1).tex,$(1))
$(call run,html-builder,latex2html $(1).tex,$(1))
endef

env: ## Copy .env.sample to .env
	cp .env.sample .env

spec: ## Build the specification document
	$(call build_pdf,spec)

handbook: ## Build the handbook
	$(call build_pdf,handbook)

html-spec: ## Build the html files
	$(call build_html,spec)

html-handbook: ## Build the html files
	$(call build_html,handbook)


clean-spec: ## Clean temporary files
	$(call clean,spec)

clean-handbook: ## Clean temporary files
	$(call clean,handbook)
