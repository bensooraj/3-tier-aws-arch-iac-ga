gen-arch-diag:
	@echo "Generating architecture diagram"
	@python3 docs/architecture/diagrams/architecture.py
	@mv 3tier_architecture.png docs/architecture/diagrams/3tier_architecture.png
	@echo "Done"

lint:
	@echo "Running lint"
	@terraform fmt -recursive
	@cd iac && terraform validate && cd ..
	@tflint