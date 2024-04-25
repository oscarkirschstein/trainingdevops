# Python setup on Macbook

This guide provides the recommended setup of Python and its tooling on a Macbook.
It's highly recommended to follow the advice in this guide.
A consistent setup will help you seek out help when needed.

## Command-line tools and `brew`

If you haven't already, install the `brew` package manager.

First make sure you have the Mac developer tools:

```bash
xcode-select --install
```

> ✏️  **Notes**
>
> - If the command line tools cannot be downloaded for some reason,
>   they can be downloaded from [here](https://developer.apple.com/download/more/)
> - It should be possible to install the command-line tools without installing
>   the XCode application itself

Install homebrew, the package manager.
You can do this by following the instructions [here](https://brew.sh/)

## `pyenv`

Run the following command:

```bash
brew install pyenv pyenv-virtualenv xz
```

Add the following to your `~/.zshrc` file:

```zsh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

Then, restart your terminal.

See [here](tooling/pyenv.md) for further instructions on using `pyenv`.

## Final notes

- Remember to frequently update your `brew` dependencies
  (including `pyenv` and `pyenv-virtualenv`).
  You can easily do this by running the following command regularly:

  ```bash
  brew update && brew upgrade
  ```
