# Example Python project

[![Python Checks and Tests](https://github.com/ramsesk/git-lab/actions/workflows/test-check.yaml/badge.svg)](https://github.com/ramsesk/git-lab/actions/workflows/test-check.yaml)

This is an example of a Python Project. Use this
as a starting point for creating new python projects.

There are multiple different kinds of Python projects possible.
This project is not an app.
This project is not a library.
This project is not a data science project.

This project does cover some basics that could fit in all of the previously managed
different types of python projects.
This project features examples of:

- structuring a python module
  - readme and changelog (`README.md`, `CHANGELOG.md`)
  - package namespacing (e.g. `ff`)
- testing with `pytest`
  - unittests
  - test coverage
  - fixtures
  - property-based tests (with `hypothesis`)
- running multiple checks with `tox`
  - code style
  - compatibility with multiple python versions
  - type checking
- (partially) autogenerated documentation with `sphinx`
- Setting up a build on github actions
- ...


## Usage

To use this repository as a template, perform the following steps:

- copy the relevant files

  ```bash
  cd ff.examplelib
  cp -r {README.md,CHANGELOG.md,mypy.ini,pyproject.toml,poetry.lock,tox.ini,docs,src,tests,.gitignore,Makefile,bamboo-specs} path/to/new/repo/
  ```

- change the description in the README.
- change the package metadata in `pyproject.toml`. Reset the version.
- change the package name. Change this in all copied files!
  Do a text search (e.g. `grep`) to check you've found all references.
- remove any unneeded dependencies in `pyproject.toml` (e.g. `numpy`)

## Development guide

### Requirements

- Supported Python versions (see `pyproject.toml` )installed.
  See [HERE](./explanation/pyenv.md).
- The poetry dependency manager. Install as described [HERE](./explanation/poetry.md)

### Setup

First create a virtual environment:

On Mac:

```bash
pyenv virtualenv 3.9.8 exampleproj_3_9_8
```

On Windows:

```powershell
pyenv local 3.9.8
python -m venv .venv
.\.venv\Scripts\activate
```

To install all development requirements, run:

```bash
# running this in a virtualenv is highly recommended
poetry install
```

### make/run script?

All the tools that are used in this repo can be run via a script.
A windows powershell script has been added for support on Windows: `./scripts/make.ps1`.
On unix based systems the Makefile can be used.


### Checks

To run all checks (tests, linting, docs, etc), run:

```bash
tox
```

Use the `--parallel auto` option to run in parallel. If you run into
issues, try using the `--recreate` option to recreate the environments.

### Tests

To run the tests, use the following command:

```bash
pytest
```

To analyze test coverage, use:

```bash
make pytest
```

On Windows:

```powershell
.\scripts\make.ps1 pytest
```

### Type checking

```bash
make type-check
```

On Windows:

```powershell
.\scripts\make.ps1 type-check
```

### Style and formatting

`ruff` can be used to automatically format code, so you don\'t have to
worry about the nitty-gritty of code style.

```bash
make check
```

On Windows:

```powershell
.\scripts\make.ps1 check
```

On Windows:

```powershell
.\scripts\make.ps1 lint
```

To fix `ruff` issues automatically, run:

```bash
make format
```

On Windows:

```powershell
.\scripts\make.ps1 format
```

### Documentation

To generate documentation with `sphinx`, run the following command:

```bash
make documentation
```

On Windows:

```powershell
.\scripts\make.ps1 documentation
```

This command will output a local URI which you can open in your browser.

### Github Actions

A pipeline to run tests and checks on Github can be found in `.github/workflows/test-check.yaml`.
This pipeline can be started manually. It will also start automatically for each pull-request.

It checks the code and runs tests on python version 3.11. On Python version 3.9 and 3.10 it also runs and tests the code, but does not do thorough checking.

It is possible to make this succesfull pipeline run a mandatory check of any Pull Request, more info:
[HERE](https://docs.github.com/en/actions/using-workflows/required-workflows)

### Contributing

To contribute, create a pull request.
Before merging, all checks must pass successfully (i.e. the `tox` command).

Please update the `CHANGLELOG.md` and the version in `pyproject.toml` accordingly.

### Publishing

TODO.

It is better that a pipeline is configured that automatically publishes
each new commit to the `main` branch. Every new version should be tagged then as well.

Make sure pyproject.toml's version is updated.
