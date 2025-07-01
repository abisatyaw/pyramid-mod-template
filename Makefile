.PHONY: bootstrap

bootstrap:
	@echo "Bootstrapping project from template..."
	@chmod +x .template/render/render.sh
	@.template/render/render.sh
	@rm -rf .git
	@echo "Initializing git repository..."
	@git init
	@git branch -m master main
	@git add .
	@git commit -m "Initial commit from template"
	@echo "Project bootstrapped successfully!"
