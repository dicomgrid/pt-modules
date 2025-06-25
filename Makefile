# Terraform Modules Development Makefile

.PHONY: help fmt validate lint security docs clean install-tools

# Default target
help: ## Show this help message
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)


fmt:
	@echo "==> Formatting Terraform files..."
	@find ./ -type f -name "*.tf" -exec terraform fmt {} \;
	@echo "✓ Formatting complete"


validate:
	@echo "==> Validating Terraform modules..."
	@for dir in $$(find . -name "*.tf" -type f | sed 's|/[^/]*$$||' | sort -u | grep -v ".terraform"); do \
		if [ -d "$$dir" ]; then \
			echo "Validating $$dir..."; \
			cd "$$dir" && terraform init -backend=false && terraform validate && cd - > /dev/null; \
		fi; \
	done
	@echo "✓ Validation complete"

lint:
	@echo "==> Running TFLint..."
	@command -v tflint >/dev/null 2>&1 || { echo "TFLint not installed. Run 'make install-tools' first."; exit 1; }
	@find . -name "*.tf" -type f | sed 's|/[^/]*$$||' | sort -u | while read dir; do \
		echo "Linting $$dir..."; \
		cd "$$dir" && tflint && cd - > /dev/null; \
	done
	@echo "✓ Linting complete"

security: ## Run security scans
	@echo "==> Running Checkov security scan..."
	@command -v checkov >/dev/null 2>&1 || { echo "Checkov not installed. Run 'make install-tools' first."; exit 1; }
	@checkov -d . --framework terraform --quiet --skip-check CKV_TF_1
	@echo "✓ Security scan complete"

# Documentation
docs:
	@echo "==> Generating module documentation..."
	@command -v terraform-docs >/dev/null 2>&1 || { echo "terraform-docs not installed. Run 'make install-tools' first."; exit 1; }
	@find . -name "*.tf" -type f | sed 's|/[^/]*$$||' | sort -u | while read dir; do \
		if [ -f "$$dir/main.tf" ] || [ -f "$$dir/variables.tf" ]; then \
			echo "Generating docs for $$dir..."; \
			terraform-docs markdown table "$$dir" > "$$dir/README.md"; \
		fi; \
	done
	@echo "✓ Documentation generation complete"


install-tools:
	@echo "==> Installing development tools..."
	@if command -v brew >/dev/null 2>&1; then \
		echo "Installing tools via Homebrew..."; \
		brew install terraform tflint terraform-docs; \
		pip3 install checkov; \
	elif command -v apt-get >/dev/null 2>&1; then \
		echo "Installing tools via apt..."; \
		wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg; \
		echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list; \
		sudo apt-get update && sudo apt-get install terraform; \
		pip3 install checkov; \
	elif command -v yum >/dev/null 2>&1; then \
		echo "Installing tools via yum..."; \
		sudo yum install -y yum-utils; \
		sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo; \
		sudo yum -y install terraform; \
		pip3 install checkov; \
	else \
		echo "Package manager not found. Please install terraform, tflint, terraform-docs, and checkov manually."; \
	fi
	@echo "✓ Tool installation complete"

# Development workflow
dev-check: fmt validate lint security ## Run all development checks
	@echo "✓ All development checks passed"

# Quick development checks
dev-check-changed: fmt validate-changed ## Quick check for changed modules only (fast)
	@echo "✅ Changed modules validated successfully"

pr-check: fmt validate-changed ## Simulate PR validation locally
	@echo "✅ PR validation complete"

# Cleanup
clean: ## Clean up temporary files
	@echo "==> Cleaning up temporary files..."
	@find . -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name ".terraform.lock.hcl" -delete 2>/dev/null || true
	@find . -type f -name "terraform.tfstate*" -delete 2>/dev/null || true
	@echo "✓ Cleanup complete"

# Module creation helper
new-module: ## Create a new module template (usage: make new-module MODULE=provider/module-name)
ifndef MODULE
	@echo "Error: MODULE parameter is required. Usage: make new-module MODULE=aws/example-module"
	@exit 1
endif
	@echo "==> Creating new module: $(MODULE)"
	@mkdir -p "$(MODULE)"
	@cp -r templates/module-template/* "$(MODULE)/" 2>/dev/null || echo "No template found, creating basic structure..."
	@if [ ! -f "$(MODULE)/main.tf" ]; then \
		echo '# Main configuration for $(MODULE) module' > "$(MODULE)/main.tf"; \
	fi
	@if [ ! -f "$(MODULE)/variables.tf" ]; then \
		echo '# Variables for $(MODULE) module' > "$(MODULE)/variables.tf"; \
	fi
	@if [ ! -f "$(MODULE)/outputs.tf" ]; then \
		echo '# Outputs for $(MODULE) module' > "$(MODULE)/outputs.tf"; \
	fi
	@if [ ! -f "$(MODULE)/README.md" ]; then \
		echo '# $(MODULE) Module\n\nDescription of the module.\n\n## Usage\n\n```hcl\nmodule "example" {\n  source = "./$(MODULE)"\n}\n```' > "$(MODULE)/README.md"; \
	fi
	@echo "✓ Module $(MODULE) created successfully"

# Local validation script
validate-local: ## Run local validation script (same as CI)
	@echo "==> Running local Terraform validation..."
	@chmod +x scripts/validate.sh
	@./scripts/validate.sh

validate-changed: ## Run validation only on changed modules
	@echo "==> Running validation on changed modules only..."
	@chmod +x scripts/validate.sh
	@./scripts/validate.sh --changed-only
