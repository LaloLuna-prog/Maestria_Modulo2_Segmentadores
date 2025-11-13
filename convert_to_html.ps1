# Script para convertir el notebook a HTML (sin necesidad de Pandoc)
# Luego puede convertir el HTML a PDF desde el navegador

param(
    [string]$Notebook = "segmentacion_frutas.ipynb"
)

Write-Host "Convirtiendo notebook a HTML..." -ForegroundColor Cyan

# Activar entorno virtual si existe
if (Test-Path "D:\Maestria\Proyecto\Segmentadores_3\.venv\Scripts\Activate.ps1") {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass | Out-Null
    & "D:\Maestria\Proyecto\Segmentadores_3\.venv\Scripts\Activate.ps1"
} elseif (Test-Path ".\.venv\Scripts\Activate.ps1") {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass | Out-Null
    & ".\.venv\Scripts\Activate.ps1"
}

try {
    jupyter nbconvert --to html $Notebook --output-dir .
    
    if ($LASTEXITCODE -eq 0) {
        $htmlFile = $Notebook -replace '\.ipynb$', '.html'
        Write-Host "`n¡Conversión exitosa!" -ForegroundColor Green
        Write-Host "Archivo generado: $htmlFile" -ForegroundColor Green
        Write-Host "`nPara convertir a PDF:" -ForegroundColor Yellow
        Write-Host "1. Abra el archivo $htmlFile en su navegador" -ForegroundColor Cyan
        Write-Host "2. Presione Ctrl+P (o Archivo → Imprimir)" -ForegroundColor Cyan
        Write-Host "3. Seleccione 'Guardar como PDF' como destino" -ForegroundColor Cyan
        Write-Host "4. Guarde el archivo" -ForegroundColor Cyan
        
        # Intentar abrir el archivo automáticamente
        if (Test-Path $htmlFile) {
            Write-Host "`nAbriendo el archivo HTML..." -ForegroundColor Cyan
            Start-Process $htmlFile
        }
    } else {
        Write-Error "Error durante la conversión"
    }
} catch {
    Write-Error "Error: $_"
    Write-Host "`nAlternativa: Use el método desde Jupyter Notebook:" -ForegroundColor Yellow
    Write-Host "Archivo → Imprimir → Guardar como PDF" -ForegroundColor Cyan
}

