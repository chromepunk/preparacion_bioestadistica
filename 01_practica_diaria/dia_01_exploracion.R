# ==============================================================================
# DÍA 1: EXPLORACIÓN INICIAL DE DATOS
# Objetivo: Inspeccionar la estructura, tipos de variables y dimensiones.
# Tiempo estimado: 20 minutos
# ==============================================================================

# 1. Cargar el ecosistema tidyverse (incluye dplyr, ggplot2, etc.)
#install.packages("tidyverse")
library(tidyverse)

# 2. Cargar el dataset de prueba integrado en R
data("iris")


# ------------------------------------------------------------------------------
# PASO 1: Visión general rápida
# ------------------------------------------------------------------------------

# Muestra las primeras 6 filas del dataset
head(iris)

# Muestra las dimensiones (filas x columnas) -> [1] 150 5
dim(iris)

# ------------------------------------------------------------------------------
# PASO 2: Estructura interna de las variables
# ------------------------------------------------------------------------------

# 'glimpse' es la forma compacta de tidyverse para ver variables y tipos de datos
# fíjate en los tipos: dbl (numérico decimal) y fct (factor/categoría)
glimpse(iris)

# ------------------------------------------------------------------------------
# PASO 3: Resumen estadístico básico
# ------------------------------------------------------------------------------

# Muestra mínimo, cuartiles, media y máximo para variables numéricas,
# y recuentos para variables categóricas.
summary(iris)

# ------------------------------------------------------------------------------
# TU TURNO (5 minutos de experimentación):
# Prueba a ejecutar estas mismas funciones pero cambiando 'iris' por el dataset 'mtcars'
# ------------------------------------------------------------------------------
data("mtcars")
glimpse(mtcars)
summary(mtcars)
