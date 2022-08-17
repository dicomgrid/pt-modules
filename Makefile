fmt:
	@echo "==> Formatting Terraform files..."
	@find ./ -type f -iname "*.tf" -exec terraform fmt '{}' \;