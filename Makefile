modules = src/ff
.PHONY: clean isort isort-check format format-check fix lint type-check pytest check test documentation

clean:
	rm -rf .coverage .hypothesis .mypy_cache .pytest_cache .tox *.egg-info
	rm -rf dist
	find . | grep -E "(__pycache__|docs_.*$$|\.pyc|\.pyo$$)" | xargs rm -rf

format:
	poetry run ruff format $(modules)

check:
	poetry run ruff check $(modules)

type-check:
	poetry run mypy --pretty src/ff tests

pytest:
	poetry run pytest --cov=ff.examplelib --junitxml=python_test_report.xml --basetemp=./tests/.tmp

test: check pytest

documentation:
	poetry run sphinx-build -d docs/_build/docs_tree docs docs/_build/docs_out -bhtml
