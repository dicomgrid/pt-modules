# PT Modules

A comprehensive collection of Terraform modules for multi-cloud infrastructure management. This repository contains reusable Terraform modules organized by cloud provider and service type.

## 🚀 Features

- **Multi-Cloud Support**: AWS, GCP, Azure, and more
- **Automated Versioning**: Semantic versioning with automated releases
- **Comprehensive Documentation**: Auto-generated wikis and documentation
- **Security Focused**: Built-in security scanning and best practices
- **Modular Design**: Reusable, composable infrastructure components

## 📁 Repository Structure

```text
pt-modules/
├── aws/              # Amazon Web Services modules
│   ├── accounts/     # AWS Organizations account management
│   ├── vpc/          # Virtual Private Cloud
│   ├── ec2/          # Elastic Compute Cloud
│   ├── s3/           # Simple Storage Service
│   └── ...
├── gcp/              # Google Cloud Platform modules
│   ├── compute/      # Compute Engine
│   ├── storage/      # Cloud Storage
│   └── ...
├── hashivault/       # HashiCorp Vault modules
├── panos/            # Palo Alto Networks modules
├── vsphere/          # VMware vSphere modules
└── templates/        # Module templates
```

## 🛠️ Development

### Prerequisites

- [Terraform](https://www.terraform.io/) >= 1.0
- [Make](https://www.gnu.org/software/make/)
- [Git](https://git-scm.com/)

### Quick Start

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your-org/pt-modules.git
   cd pt-modules
   ```

2. **Install development tools**:

   ```bash
   make install-tools
   ```

3. **Run development checks**:

   ```bash
   make dev-check
   ```

### Development Workflow

- **Format code**: `make fmt`
- **Validate modules**: `make validate`
- **Run security scans**: `make security`
- **Generate documentation**: `make docs`
- **Create new module**: `make new-module MODULE=aws/example-module`

## 📖 Using Modules

### Basic Usage

```hcl
module "example_vpc" {
  source = "git::https://github.com/your-org/pt-modules.git//aws/vpc?ref=aws/vpc/v1.0.0"
  
  name = "example-vpc"
  cidr = "10.0.0.0/16"
  
  # Additional configuration...
}
```

### Module Versioning

This repository uses semantic versioning with automated releases. Each module is tagged independently:

- `aws/vpc/v1.0.0` - AWS VPC module version 1.0.0
- `gcp/compute/v2.1.0` - GCP Compute module version 2.1.0

### Finding Modules

- **Browse the [Wiki](../../wiki)** for comprehensive documentation
- **Check [Releases](../../releases)** for version history
- **View source code** in the respective provider directories

## 🔒 Security

- All modules include security best practices
- Automated security scanning with Checkov and TFSec
- Regular dependency updates
- See [SECURITY.md](SECURITY.md) for security policy

## 📋 Module Standards

Each module follows these standards:

### File Structure

```text
module-name/
├── main.tf          # Main resources
├── variables.tf     # Input variables
├── outputs.tf       # Output values
├── README.md        # Module documentation
├── providers.tf     # Provider requirements (if needed)
└── examples/        # Usage examples
    └── basic/
        ├── main.tf
        └── variables.tf
```

### Naming Conventions

- Use lowercase with hyphens for module names
- Follow provider-specific naming patterns
- Use descriptive variable and output names

### Documentation

- Include comprehensive README with usage examples
- Document all variables and outputs
- Provide real-world examples

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/new-module`
3. **Make your changes**:
   - Add/modify modules following the standards
   - Update documentation
   - Add examples
4. **Run tests**: `make dev-check`
5. **Commit with conventional commits**:
   - `feat: add new AWS Lambda module`
   - `fix: resolve VPC CIDR validation issue`
   - `docs: update module usage examples`
6. **Create a Pull Request**

### Commit Message Format

We use [Conventional Commits](https://www.conventionalcommits.org/) for automated versioning:

- `feat:` - New features (minor version bump)
- `fix:` - Bug fixes (patch version bump)
- `BREAKING CHANGE:` - Breaking changes (major version bump)
- `docs:` - Documentation changes
- `chore:` - Maintenance tasks

## 📊 Continuous Integration

- **Automated Testing**: Terraform validation and security scanning
- **Automated Releases**: Semantic versioning based on commit messages
- **Documentation**: Auto-generated wikis and release notes
- **Security**: Continuous security scanning and compliance checks

## 📚 Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Module Development Guide](../../wiki/Development-Guide)
- [Security Best Practices](../../wiki/Security-Best-Practices)

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♂️ Support

- **Issues**: Report bugs and request features via [GitHub Issues](../../issues)
- **Discussions**: Join conversations in [GitHub Discussions](../../discussions)
- **Documentation**: Check the [Wiki](../../wiki) for detailed guides

---

Made with ❤️ by the PT Modules Team
