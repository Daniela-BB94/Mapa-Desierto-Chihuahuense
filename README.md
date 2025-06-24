# 🗺️ Mapa Interactivo del Desierto Chihuahuense

Este repositorio contiene un script en R que genera un mapa interactivo de puntos de muestreo de suelos y polígonos de unidades litológicas en una zona del Desierto Chihuahuense. El mapa fue creado usando el paquete `mapview` y exportado como un archivo HTML interactivo.

## 🧪 Requisitos

- R (versión 4.0 o superior recomendada)
- Paquetes: `readxl`, `sf`, `mapview`, `dplyr`, `webshot`, `webshot2`

Para instalar los paquetes:

```r
install.packages(c("readxl", "sf", "mapview", "dplyr"))
webshot::install_webshot()


# script_mapa.R

# Mapa interactivo del Desierto Chihuahuense con datos edáficos y litológicos

# -----------------------------
# 1. Cargar librerías necesarias
# -----------------------------
library(readxl)     # Leer archivos Excel
library(sf)         # Manejo de datos espaciales
library(mapview)    # Visualización de mapas interactivos
library(dplyr)      # Manipulación de datos

# -----------------------------
# 2. Cargar datos
# -----------------------------
# Leer base de datos con coordenadas y atributos
DC <- read_excel("BD_DC_pre.xlsx")

# Leer archivo shapefile del polígono de estudio
DC_p <- st_read("coor-polygon.shp")

# -----------------------------
# 3. Crear objeto sf con puntos
# -----------------------------
puntos <- st_as_sf(DC, coords = c("X", "Y"), crs = "EPSG:4326") %>%
  mutate(etiqueta = paste("Suelo:", Grupo1, "| Litología:", LITOLOGIA))

# -----------------------------
# 4. Crear mapa interactivo
# -----------------------------
mapa_completo <- 
  mapview(DC_p,
          layer.name = "Área de interés",
          alpha.region = 0,          # Sin relleno
          color = "maroon",          # Color del borde
          lwd = 1.5) +               # Grosor de línea
  mapview(puntos,
          zcol = "Color",
          col.regions = as.character(puntos$Color),
          label = puntos$etiqueta,
          legend = FALSE,
          layer.name = "Puntos DC")

# Mostrar el mapa en visor
mapa_completo

# -----------------------------
# 5. Exportar el mapa como HTML
# -----------------------------
# Solo ejecutar la primera vez si no está instalado:
# webshot::install_webshot()

# Exportar a archivo HTML interactivo
mapshot(mapa_completo,
        url = "mapa_desierto_chihuahuense.html")

# Fin del script
*.bak

# Carpetas de cache
__pycache__/
.cache/
