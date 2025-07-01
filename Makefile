.PHONY: bootstrap

bootstrap:
	@echo "Bootstrapping project from template..."
	@chmod +x .template/render/render.sh
	@.template/render/render.sh
	@rm -rf .git
	@echo "Initializing git repository..."
	@git init
	@git add .
	@git commit -m "Initial commit from template"
	@git branch -m master main
	@echo "Project bootstrapped successfully!"
