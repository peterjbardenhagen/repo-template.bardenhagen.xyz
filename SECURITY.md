# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 2.x     | :white_check_mark: |
| 1.x     | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability in this repository or any of its downstream projects, please report it responsibly:

1. **Do not** open a public issue for security vulnerabilities.
2. Email the maintainer directly or use GitHub's private vulnerability reporting feature.
3. Include as much detail as possible: the affected file/component, steps to reproduce, potential impact, and suggested remediation.

We will acknowledge receipt within 72 hours and provide a detailed response within 7 days.

## Security Best Practices

- Never commit secrets, API keys, or credentials to version control.
- Use `.env.example` to document required environment variables without values.
- Enable GitHub secret scanning and push protection in repository settings.
- Use Dependabot and GitHub's Dependency Review action to catch vulnerable dependencies early.
- Pin GitHub Actions to full commit SHAs in production workflows.
- Follow the principle of least privilege for `GITHUB_TOKEN` permissions in all workflows.
