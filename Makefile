.DEFAULT_GOAL := help
.PHONY: docs
TUTOR ?= $(if $(VIRTUAL_ENV),$(VIRTUAL_ENV)/bin/tutor,tutor)
TUTOR_CMD = $(TUTOR) -r $(CURDIR)
SRC_DIRS = ./tutorltistore
PYTHON ?= python3

clean: ## Remove build artifacts
	rm -rf build dist *.egg-info

requirements: ## Install the package in editable mode
	$(PYTHON) -m pip install -e '.[dev]'

build: clean ## Build the package
	$(PYTHON) -m build

dist: ## Upload package to PyPI
	twine upload dist/*

# Warning: These checks are not necessarily run on every PR.
test: test-lint test-types test-format test-dist test-tutor # Run some static checks.

test-format: ## Run code formatting tests
	ruff format --check --diff ${SRC_DIRS}

test-lint: ## Run code linting tests
	ruff check ${SRC_DIRS}

test-types: ## Run type checks.
	mypy --exclude=templates --ignore-missing-imports --implicit-reexport --strict ${SRC_DIRS}

test-dist: build ## Check the distribution files
	twine check dist/*

test-tutor:
	rm -rf config.yml env/
	$(TUTOR_CMD) config save
	$(TUTOR_CMD) plugins enable ltistore
	rm -rf config.yml env/

format: ## Format code
	ruff format ${SRC_DIRS}

fix-lint: ## Fix lint errors automatically
	ruff check --fix ${SRC_DIRS}

version: ## Print the current tutor-cairn version
	@python -c 'import io, os; about = {}; exec(io.open(os.path.join("tutorltistore", "__about__.py"), "rt", encoding="utf-8").read(), about); print(about["__version__"])'

ESCAPE = 
help: ## Print this help
	@grep -E '^([a-zA-Z_-]+:.*?## .*|######* .+)$$' Makefile \
		| sed 's/######* \(.*\)/@               $(ESCAPE)[1;31m\1$(ESCAPE)[0m/g' | tr '@' '\n' \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[33m%-30s\033[0m %s\n", $$1, $$2}'
