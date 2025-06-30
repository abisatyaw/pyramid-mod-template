.PHONY: bootstrap

bootstrap:
	@echo "Bootstrapping project from template..."
	@chmod +x .template/render/render.sh
	@.template/render/render.sh
