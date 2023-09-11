# Preparing your machine
Make sure you install Python, this can be done via Pyenv-win. Then also install Poetry. 

## Pyenv-Win 
In order to still make use of Pyenv on windows, we need to install the windows port. 

Download/info: https://github.com/pyenv-win/pyenv-win

Installation via Powershell: 
```powershell
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
```

After the installation you can clean up the install-pyenv-win.ps1 file that is left in the current working directory. 

After restarting your Powershell (or command prompt or terminal) you can test Pyenv with:
```powershell
pyenv --version
```

If you get the `command not found` error, it is necessary to add the path where the pyenv executable is located to your user or system PATH.

Now it is possible to install whichever version of **Python** we need. For example if you want ot use version **`3.10.9`**. Run the following commands.
```powershell
pyenv install 3.10.9
pyenv global 3.10.9
pyenv local 3.10.9
```
Now you have python version 3.10.9 installed and set as your global python version. For the last command `pyenv local` you should navigate to the project directory where you want to use that version of python. 

## Poetry
Installing Poetry in your system is required as well. How to do this is found [HERE](poetry.md)