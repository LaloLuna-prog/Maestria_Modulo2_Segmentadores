# Uso: powershell -ExecutionPolicy Bypass -File setup_env.ps1

param(
    [string]$EnvDir = ".venv",
    [string]$PreferredPython = "3.11"
)

function Resolve-Python {
    param([string]$PreferredVersion)

    $pythonPath = $null
    if (Get-Command py -ErrorAction SilentlyContinue) {
        try {
            $pythonPath = (& py "-$PreferredVersion" -c "import sys; print(sys.executable)" 2>$null).Trim()
            if (-not $pythonPath) {
                $pythonPath = $null
            }
        } catch {
            $pythonPath = $null
        }
    }

    if (-not $pythonPath) {
        $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
        if ($pythonCmd) {
            $pythonPath = $pythonCmd.Source
            $versionOk = & $pythonPath -c "import sys; print(sys.version_info[:2] >= ($PreferredVersion.split('.')[0], $PreferredVersion.split('.')[1]))"
            if ($versionOk.Trim() -ne "True") {
                Write-Warning "Se encontró python en $pythonPath pero su versión es inferior a $PreferredVersion. Intenta instalar Python $PreferredVersion desde https://www.python.org/downloads/."
            }
        }
    }

    if (-not $pythonPath) {
        throw "No se encontró un intérprete de Python $PreferredVersion. Instálalo y vuelve a ejecutar este script."
    }
    return $pythonPath
}

$pythonExe = Resolve-Python -PreferredVersion $PreferredPython
Write-Host "Usando Python en $pythonExe" -ForegroundColor Cyan

Write-Host "Creando entorno virtual en $EnvDir" -ForegroundColor Cyan
if (-Not (Test-Path $EnvDir)) {
    & $pythonExe -m venv $EnvDir
}

$venvPython = Join-Path $EnvDir "Scripts\python.exe"
if (-not (Test-Path $venvPython)) {
    throw "No se encontró el intérprete dentro del entorno virtual: $venvPython"
}

Write-Host "Activando entorno virtual" -ForegroundColor Cyan
$activateScript = Join-Path $EnvDir "Scripts\Activate.ps1"
if (-Not (Test-Path $activateScript)) {
    throw "No se encontró el script de activación: $activateScript"
}
& $activateScript

Write-Host "Actualizando pip" -ForegroundColor Cyan
& $venvPython -m pip install --upgrade pip

Write-Host "Instalando dependencias" -ForegroundColor Cyan
& $venvPython -m pip install --upgrade -r requirements.txt

Write-Host "Habilitando ipywidgets" -ForegroundColor Cyan
try {
    & $venvPython -m jupyter nbextension enable --py widgetsnbextension --sys-prefix | Out-Null
} catch {
    Write-Warning "No se pudo habilitar automáticamente widgetsnbextension. Si usas JupyterLab 4 o superior, esta acción no es necesaria."
}

Write-Host "Entorno listo. Usa 'jupyter notebook segmentacion_frutas.ipynb' para ejecutar el cuaderno." -ForegroundColor Green

