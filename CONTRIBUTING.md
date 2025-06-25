# Contributing to PT Modules

Thank you for your interest in contributing to PT Modules! This guide will help you get started with development and contribution guidelines.

## 🚀 Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/) >= 1.0
- [Make](https://www.gnu.org/software/make/)
- [Git](https://git-scm.com/)
- [Pre-commit](https://pre-commit.com/) (optional but recommended)

### Development Setup

1. **Fork and clone the repository**:

   ```bash
   git clone https://github.com/your-username/pt-modules.git
   cd pt-modules
   ```

2. **Install development tools**:

   ```bash
   make install-tools
   ```

3. **Set up pre-commit hooks** (optional):

   ```bash
   pip install pre-commit
   pre-commit install
   ```

## 📝 Development Workflow

### Creating a New Module

1. **Use the module template**:

   ```bash
   make new-module MODULE=provider/module-name
   ```

2. **Implement your module**:
   - Add resources to `main.tf`
   - Define variables in `variables.tf`
   - Add outputs to `outputs.tf`
   - Update `README.md` with documentation

3. **Add examples**:

   ```bash
   mkdir -p provider/module-name/examples/basic
   # Create example configuration
   ```

### Code Quality Checks

Run all quality checks before submitting:

```bash
make dev-check
```

This runs:
- `make fmt` - Format Terraform code
- `make validate` - Validate Terraform syntax
- `make lint` - Run TFLint
- `make security` - Run security scans

### Individual Commands

- **Format code**: `make fmt`
- **Validate modules**: `make validate`
- **Run linting**: `make lint`
- **Security scan**: `make security`
- **Generate docs**: `make docs`
- **Clean temp files**: `make clean`

## 🏗️ Module Standards

### File Structure

```text
provider/module-name/
├── main.tf          # Main resources
├── variables.tf     # Input variables
├── outputs.tf       # Output values
├── README.md        # Module documentation
├── providers.tf     # Provider requirements (if needed)
├── versions.tf      # Terraform version constraints (if needed)
└── examples/        # Usage examples
    └── basic/
        ├── main.tf
        ├── variables.tf
        └── terraform.tf
```

### Naming Conventions

- **Module names**: Use lowercase with hyphens (`vpc`, `s3-bucket`)
- **File names**: Use lowercase with underscores (`main.tf`, `variables.tf`)
- **Resource names**: Follow provider conventions
- **Variable names**: Use lowercase with underscores (`vpc_id`, `subnet_ids`)

### Code Standards

1. **Variables**:
   - Always include `description`
   - Use appropriate `type` constraints
   - Provide `default` values where appropriate
   - Use `validation` blocks for complex constraints

2. **Outputs**:
   - Always include `description`
   - Export all commonly needed resource attributes
   - Use consistent naming patterns

3. **Resources**:
   - Use data sources for existing resources
   - Include appropriate tags
   - Use locals for computed values

### Documentation Requirements

1. **README.md**:
   - Clear module description
   - Usage examples
   - Requirements table
   - Inputs/Outputs tables (auto-generated)

2. **Examples**:
   - At least one basic example
   - Complex examples for advanced use cases
   - Include `terraform.tf` with provider requirements

## 🔄 Git Workflow

### Commit Messages

We use [Conventional Commits](https://www.conventionalcommits.org/):

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat:` - New features (minor version bump)
- `fix:` - Bug fixes (patch version bump)
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks
- `BREAKING CHANGE:` - Breaking changes (major version bump)

**Examples:**
```text
feat(aws/vpc): add support for IPv6 CIDR blocks
fix(gcp/compute): resolve instance naming issue
docs: update contributing guidelines
```

### Branch Naming

- `feature/description` - New features
- `fix/description` - Bug fixes
- `docs/description` - Documentation updates
- `refactor/description` - Code refactoring

### Pull Request Process

1. **Create a feature branch**:

   ```bash
   git checkout -b feature/new-module
   ```

2. **Make your changes**:
   - Follow code standards
   - Add tests/examples
   - Update documentation

3. **Run quality checks**:

   ```bash
   make dev-check
   ```

4. **Commit your changes**:

   ```bash
   git add .
   git commit -m "feat: add new module for XYZ"
   ```

5. **Push and create PR**:

   ```bash
   git push origin feature/new-module
   ```

6. **Create Pull Request**:
   - Use descriptive title
   - Include detailed description
   - Reference any related issues

## 🧪 Testing

### Module Testing

1. **Validation Testing**:

   ```bash
   terraform init
   terraform validate
   ```

2. **Plan Testing**:

   ```bash
   terraform plan
   ```

3. **Example Testing**:

   ```bash
   cd examples/basic
   terraform init
   terraform plan
   ```

### Security Testing

Run security scans on your modules:

```bash
make security
```

This runs:
- Checkov for infrastructure security
- TFSec for Terraform-specific security issues

## 📚 Resources

- [Terraform Module Guidelines](https://www.terraform.io/docs/modules/index.html)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)

## 🤝 Getting Help

- **Issues**: Report bugs via [GitHub Issues](../../issues)
- **Discussions**: Ask questions in [GitHub Discussions](../../discussions)
- **Documentation**: Check the [Wiki](../../wiki)

## 📜 Code of Conduct

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms.
