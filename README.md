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

## Buenas prácticas y originalidad del código
- Este trabajo implementa segmentadores propios (`ColorGaussianSegmenter`, `SLICGraphSegmenter`) combinando técnicas públicas (HSV, SLIC) con decisiones de diseño originales.
- El modelo `MaskRCNNDetector` usa `maskrcnn_resnet50_fpn` pre-entrenado de `torchvision`; los pesos provienen del modelo COCO oficial.
- Si reutilizas fragmentos o adaptas ideas de otras fuentes, cítalas en el notebook o en esta sección para dar crédito adecuado.
- Evita subir datasets descargados o entornos virtuales; cada usuario debe generarlos en su máquina mediante las celdas del cuaderno.

## Exportar resultados
Una vez que todas las celdas se hayan ejecutado, puedes usar las opciones de Jupyter para exportar el notebook como PDF o HTML.
