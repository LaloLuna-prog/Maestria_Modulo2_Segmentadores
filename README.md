# Segmentadores de Frutas

Proyecto para entrenar y evaluar segmentadores (ColorGaussian, SLICGraph y Mask R-CNN) sobre un subconjunto de COCO con frutas.

## Requisitos
- Windows con PowerShell 5 o superior
- Python 3.11 instalado (accesible como `py -3.11` o `python`)

## Puesta en marcha
1. Clona este repositorio y abre PowerShell en la carpeta del proyecto.
2. Ejecuta el script de setup (crea `.venv`, instala dependencias, habilita widgets):
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\setup_env.ps1
   ```
3. Lanza el notebook:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\run_notebook.ps1
   ```

## Descarga de datos
El notebook descarga automáticamente las anotaciones e imágenes necesarias de COCO la primera vez que se ejecuta la celda correspondiente. Los archivos se guardan en `data/coco_frutas`. Como esta carpeta está en `.gitignore`, cada usuario descargará los datos de forma local.

## Exportar resultados
Una vez que todas las celdas se hayan ejecutado, puedes usar las opciones de Jupyter para exportar el notebook como PDF o HTML.
