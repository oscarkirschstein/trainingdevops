# Poetry

## Why poetry, and not just `pip`/`venv`? (short answer)

Poetry supports essential features which `pip`/`venv` alone don't provide.
(For a longer answer, see further down this article.)

## Installation

To prevent annoying bugs, it is important you install `poetry`
in a specific way.

Firstly, make sure you are using a modern Python version installed by [`pyenv`](./pyenv.md).
(Do *not* use the system Python or Homebrew Python.)

```bash
pyenv shell 3.11
```

Then, run the [installation command from the poetry documentation](https://python-poetry.org/docs/#installation).
At the time of writing, this is for Mac:

```bash
curl -sSL https://install.python-poetry.org | python -
```

And for Windows:

```powershell
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python - 
```


> ⛔️ Do not install `poetry` with `pip`
>
> This will install poetry's own dependencies
> into your environment, which could mess up your own dependencies

> ⛔️ Do *not* install `poetry` with `brew`
>
> This doesn't allow `poetry` to update itself, along with other problems.

On Mac, make sure you've added `$HOME/.local/bin` to `$PATH` in your shell (e.g. `.zshrc`)

On Windows, make sure you've added `%APPDATA%\Python\Scripts` to `PATH`.

## Use with `pyenv`

We recommend using `pyenv-virtualenv` to manage virtualenvs on Mac.
You'll need to prevent `poetry` from attempting to manage your virtualenvs:

```shell
poetry config virtualenvs.create false
```

On Windows using `python -m venv .venv` is recommended.

See the article on [pyenv](./pyenv.md) to see how to manage Python versions
and virtualenvs.

## Troubleshooting

- Having problems installing dependencies, try these:
  - Check if you're on the latest version, using `poetry --version`
  - You can update `poetry` with `poetry self update`
  - If necessary, you can revert to a specific version with `poetry self update <version>`
  - Clear cache `poetry cache clear . --all`
  - Clear pip cache: `rm -r $(pip cache dir)`
  - Delete `poetry.lock` and regenerate with `poetry lock`

- Package installation failing on MacOS Big sur?
  This could be an issue with poetry not installing from MacOS wheels.
  This should be fixed on versions >=1.1.5.
  If not, try using `env SYSTEM_VERSION_COMPAT=1 poetry <your command>` when running a command.
  Tip: don't set this env var globally.

- If you’re getting a warning message from poetry like this:

  ```
  Consider moving TOML configuration files to
  /Users/youraccound/Library/Application Support/pypoetry, as support for the
  legacy directory will be removed in an upcoming release.
  ```

  You can fix this with:

  ```shell
  mv "/Users/$(whoami)/Library/Preferences/pypoetry/config.toml" \
    "/Users/$(whoami)/Library/Preferences/pypoetry/poetry.lock" \
    "/Users/$(whoami)/Library/Preferences/pypoetry/pyproject.toml"  \
    "/Users/$(whoami)/Library/Application Support/pypoetry"
  ```

## Why poetry, and not `pip`/`venv`? (long answer)

For security, we need to lock dependencies and subdependencies.
`pip` does not offer a maintainable way to do this. You can `pip freeze`,
but this very difficult to update regularly. Tools like `pip-tools` can
help with this, **but** the output ``requirements.txt`` is platform-dependent
(i.e. You need to maintain a different file for Mac, linux, and Windows,
which you can only generate *on* that specific platform).
Thus, at the moment, `poetry` is the easiest way to manage locked dependencies.
Although it has had issues in the past, it is currently broadly supported by the community.