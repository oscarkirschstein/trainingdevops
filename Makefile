.PHONY: clean isort isort-check format format-check fix lint type-check pytest check test documentation

clean:
	rm -rf .coverage .hypothesis .mypy_cache .pytest_cache .tox *.egg-info
	rm -rf dist
	find . | grep -E "(__pycache__|docs_.*$$|\.pyc|\.pyo$$)" | xargs rm -rf

isort:
	isort .

isort-check:
	isort . --check-only --diff

format:
	black .

format-check:
	black --check --diff .

fix: isort format

lint:
	flake8 --exclude=.tox,build

type-check:
	mypy --pretty src/ff tests

check: lint isort-check format-check type-check

pytest:
	pytest --cov=ff.examplelib --junitxml=python_test_report.xml --basetemp=./tests/.tmp

test: check pytest

documentation:
	sphinx-build -d docs_tree docs docs_out --color -bhtml
