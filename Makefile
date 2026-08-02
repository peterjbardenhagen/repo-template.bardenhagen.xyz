.PHONY: help test lint format build clean docs install dev

## Show this help message
help:
	@echo "Available targets:"
	@grep -E '^## ' $(MAKEFILE_LIST) | sed 's/## //; s/^\([^:]*\): */\1 — /' | column -t -s '—'

## Install dependencies (customize per project)
install:
	@echo "No dependencies defined. Add install steps here."

## Run linters (runs pre-commit if available)
lint:
	@echo "Running pre-commit hooks..."
	@if command -v pre-commit >/dev/null 2>&1; then \
		pre-commit run --all-files; \
	else \
		echo "pre-commit not installed. Install with: pip install pre-commit && pre-commit install"; \
	fi

## Format code (runs fix hooks via pre-commit)
format:
	@if command -v pre-commit >/dev/null 2>&1; then \
		pre-commit run --all-files --hook-stage manual; \
	else \
		echo "pre-commit not installed. Install with: pip install pre-commit"; \
	fi
	@echo "Formatting complete."

## Run tests
test:
	@echo "No tests defined. Add test commands here."

## Build project artifacts
build:
	@echo "No build steps defined. Add build commands here."

## Build or serve documentation
docs:
	@echo "No docs build defined. Add documentation build steps here."

## Start a local development server
dev:
	@echo "No dev server defined. Add dev command here."

## Remove build artifacts and caches
clean:
	rm -rf build/ dist/ .cache/ .pytest_cache/ node_modules/
