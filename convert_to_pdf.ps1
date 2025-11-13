# Script para convertir el notebook a PDF
# Uso: powershell -ExecutionPolicy Bypass -File .\convert_to_pdf.ps1

param(
    [string]$Notebook = "segmentacion_frutas.ipynb",
    [string]$EnvDir = ".venv"
)

$activateScript = Join-Path $EnvDir "Scripts\Activate.ps1"

if (Test-Path $activateScript) {
    Write-Host "Activando entorno virtual..." -ForegroundColor Cyan
    & $activateScript
} else {
    Write-Warning "No se encontró el entorno virtual en $EnvDir"
    Write-Host "Intentando con Python del sistema..." -ForegroundColor Yellow
}

Write-Host "Convirtiendo notebook a PDF..." -ForegroundColor Cyan
Write-Host "Esto puede tardar unos minutos..." -ForegroundColor Yellow

try {
    # Opción 1: Conversión directa a PDF (requiere LaTeX o pandoc)
    jupyter nbconvert --to pdf $Notebook --output-dir .
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n¡Conversión exitosa!" -ForegroundColor Green
        Write-Host "Archivo generado: $($Notebook -replace '\.ipynb$', '.pdf')" -ForegroundColor Green
    } else {
        Write-Warning "La conversión directa falló. Intentando método alternativo..."
        
        # Opción 2: Convertir a HTML primero, luego a PDF (requiere wkhtmltopdf)
        Write-Host "Convirtiendo a HTML primero..." -ForegroundColor Cyan
        jupyter nbconvert --to html $Notebook --output-dir .
        
        $htmlFile = $Notebook -replace '\.ipynb$', '.html'
        Write-Host "`nArchivo HTML generado: $htmlFile" -ForegroundColor Yellow
        Write-Host "Puede abrir este archivo en su navegador y usar 'Imprimir' -> 'Guardar como PDF'" -ForegroundColor Yellow
    }
} catch {
    Write-Error "Error durante la conversión: $_"
    Write-Host "`nAlternativas:" -ForegroundColor Yellow
    Write-Host "1. Desde Jupyter Notebook: Archivo -> Imprimir -> Guardar como PDF" -ForegroundColor Cyan
    Write-Host "2. Convertir a HTML y usar el navegador para guardar como PDF" -ForegroundColor Cyan
    Write-Host "3. Instalar LaTeX o pandoc para conversión directa a PDF" -ForegroundColor Cyan
}

