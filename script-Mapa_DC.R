
library(readxl)
library(sf)
library(mapview)
library(dplyr)

# Leer datos
DC <- read_excel("BD_DC_pre.xlsx")
DC_p <- st_read("coor-polygon.shp")

# Crear sf con puntos y etiquetas
puntos <- st_as_sf(DC, coords = c("X", "Y"), crs = "EPSG:4326") %>%
  mutate(etiqueta = paste("Suelo:", Grupo1, "| Litologia:", LITOLOGIA))

# Visualización
mapa_completo <- 
  mapview(DC_p,
          layer.name = "Área de interés",
          alpha.region = 0,     # Sin relleno
          color = "maroon",      # Color del borde
          lwd = 1.5) +            # Grosor de línea
  mapview(puntos,
          zcol = "Color",
          col.regions = as.character(puntos$Color),
          label = puntos$etiqueta,
          legend = FALSE,
          layer.name = "Puntos DC")

# Mostrar
mapa_completo

mapview(DC_p) + mapa_completo
# Exportar como archivo HTML
webshot::install_webshot()  # Solo la primera vez

mapshot(mapa_completo,
        url = "mapa_desierto_chihuahuense.html")
