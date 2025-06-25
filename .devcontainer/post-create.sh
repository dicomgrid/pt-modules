#!/bin/bash

# Post-create script for development container

echo "Setting up Terraform development environment..."

# Install additional tools
pip3 install --user checkov pre-commit terraform-docs

# Install TFLint
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# Install TFSec
curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash

# Make tools available in PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Install pre-commit hooks
if [ -f .pre-commit-config.yaml ]; then
    pre-commit install
fi

echo "Development environment setup complete!"
echo "Available commands:"
echo "  make help          - Show available make targets"
echo "  make dev-check     - Run all development checks"
echo "  make fmt           - Format Terraform code"
echo "  make validate      - Validate Terraform modules"
