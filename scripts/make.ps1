# Define the commands as functions for each target

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

function RunIsort {
    & isort .
    Write-Output "Isort command executed successfully."
}

function RunIsortCheck {
    & isort . --check-only --diff
    Write-Output "Isort-check command executed successfully."
}

function RunFormat {
    & black .
    Write-Output "Format command executed successfully."
}

function RunFormatCheck {
    & black --check --diff .
    Write-Output "Format-check command executed successfully."
}

function RunFix {
    RunIsort
    RunFormat
    Write-Output "Fix command executed successfully."
}

function RunLint {
    & flake8 --exclude=.tox,build,.venv
    Write-Output "Lint command executed successfully."
}

function RunTypeCheck {
    & mypy --pretty -p klm.hero
    & mypy --pretty tests 
    Write-Output "Type-check command executed successfully."
}

function RunCheck {
    RunLint
    RunIsortCheck
    RunFormatCheck
    RunTypeCheck
    Write-Output "Check command executed successfully."
}

function RunPytest {
    & pytest --cov=ff.examplelib --junitxml=.\python_test_report.xml --basetemp=.\\tests\\.tmp
    Write-Output "Pytest command executed successfully."
}

function RunTest {
    RunCheck
    RunPytest
    Write-Output "Test command executed successfully."
}

function RunDocumentation {
    & sphinx-build -d docs_tree docs docs_out -bhtml
    Write-Output "Documentation command executed successfully."
}

# Check the command-line arguments and activate the corresponding command

# Determine the OS
# Construct the path to the virtual environment activation script
$venvBase = "./.venv"
$activateScript = if ($IsWindows) { "Scripts\activate" } else { "bin/activate" }
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
    "isort" { RunIsort }
    "isort-check" { RunIsortCheck }
    "format" { RunFormat }
    "format-check" { RunFormatCheck }
    "fix" { RunFix }
    "lint" { RunLint }
    "type-check" { RunTypeCheck }
    "pytest" { RunPytest }
    "check" { RunCheck }
    "test" { RunTest }
    "documentation" { RunDocumentation }
    default { Write-Output "Invalid argument. Please specify a valid command: clean, isort, isort-check, format, format-check, fix, lint, type-check, pytest, check, test, or documentation." }
}
