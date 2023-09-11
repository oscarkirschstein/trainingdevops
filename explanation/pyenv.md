# Pyenv

## Installation

See the [macbook guide](./macbook-setup.md) for installing `pyenv` AND `pyenv-virtualenv`

Seet the [windows guide](./windows-setup.md) for install `pyenv` (`pyenv-win`). Pyenv-win does not have the pyenv-virtualenv command. 
For working with virtual environments read this document [pyenv-win and virtualenv on windows](https://rkadezone.wordpress.com/2020/09/14/pyenv-win-virtualenv-windows/)

## Recommended usage

Install any Python versions you need with `pyenv`, for example:

```bash
pyenv install 3.11
```

When working on a Python project/repository, we recommend setting up the following:

```bash
# create a virtualenv
# pyenv virtualenv <main python version> <projectname>
# for example,
pyenv virtualenv 3.8 sentry
# (make sure you're in the project directory)
# pyenv local <your virtualenv> <ALL python versions supported by the project>
# for example,
pyenv local sentry 3.8 3.7 3.9
```

Then, you'll automatically get the correct setup when navigating to that directory.

## Troubleshooting

- Command line tool not appearing? try `pyenv rehash`.
- `pyenv install` failing on MacOS Big Sur? try:

  ```bash
  brew install zlib bzip2
  env LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib" \
  CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip3/include" \
  pyenv install -v <the version>
  ```