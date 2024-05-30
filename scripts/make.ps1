# Define the commands as functions for each target
$global:modules = "src/ff"


function RunClean {
    Remove-Item -Path ".coverage" -Force -Recurse
    Remove-Item -Path ".hypothesis" -Force -Recurse
    Remove-Item -Path ".mypy_cache" -Force -Recurse
    Remove-Item -Path ".pytest_cache" -Force -Recurse
    Remove-Item -Path ".tox" -Force -Recurse
    Remove-Item -Path "*.egg-info" -Force -Recurse
    Remove-Item -Path "dist" -Force -Recurse
    Get-ChildItem -Path . | Where-Object { $_.Name -match "__pycache__|docs_.*|\.pyc|\.pyo" } | ForEach-Object { Remove-Item $_.FullName -Force -Recurse }
    Write-Output "Clean command executed successfully."
}

function RunFormat {
    & poetry run ruff format $global:modules
    Write-Output "Format command executed successfully for module(s): $global:modules"
}


function RunTypeCheck {
    & poetry run mypy --pretty $global:modules
    & poetry run mypy --pretty tests # Not sure if we need to do this?
    Write-Output "Type-check command executed successfully."
}

function RunCheck {
    & poetry run ruff check $global:modules
    RunTypeCheck
    Write-Output "Check command executed successfully."
}

function RunPytest {
    & poetry run pytest --cov=ff.examplelib --junitxml=.\python_test_report.xml --basetemp=.\\tests\\.tmp
    Write-Output "Pytest command executed successfully."
}

function RunCheckTest {
    RunCheck
    RunPytest
    Write-Output "Check + Test command executed successfully."
}

function RunDocumentation {
    & poetry run sphinx-build -d docs/_build/docs_tree docs docs/_build/docs_out -bhtml
    Write-Output "Documentation command executed successfully."
}

# Check the command-line arguments and activate the corresponding command

# Determine the OS
# Construct the path to the virtual environment activation script
$venvBase = "./.venv"
# Determine the OS
$IsWinOS = $false
if ([System.Environment]::OSVersion.Platform -eq "Win32NT") {
    $IsWinOS = $true
}
$activateScript = if ($IsWinOS) { "Scripts\activate" } else { "bin/activate" }
$activatePath = Join-Path -Path $venvBase -ChildPath $activateScript

# Check if the activation script exists
if (Test-Path -Path $activatePath) {
    # Activate the virtual environment
    & $activatePath
} else {
    Write-Host "Virtual environment activation script not found."
}


switch ($args[0]) {
    "clean" { RunClean }
    "format" { RunFormat }
    "type-check" { RunTypeCheck }
    "pytest" { RunPytest }
    "check" { RunCheck }
    "check-test" { RunCheckTest }
    "documentation" { RunDocumentation }
    default { Write-Output "Invalid argument. Please specify a valid command: clean, isort, isort-check, format, format-check, fix, lint, type-check, pytest, check, test, or documentation." }
}
