param(
    [string]$EnvDir = ".venv",
    [string]$Notebook = "segmentacion_frutas.ipynb"
)

$activateScript = Join-Path $EnvDir "Scripts\Activate.ps1"
if (-Not (Test-Path $activateScript)) {
    throw "No se encontró el entorno virtual. Ejecuta primero setup_env.ps1"
}

& $activateScript
jupyter notebook $Notebook

