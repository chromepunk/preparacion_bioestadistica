# ==============================================================================
# DÍA 2: FILTRADO DE DATOS CON FILTER()
# Objetivo: Seleccionar subconjuntos de datos según condiciones lógicas.
# Tiempo estimado: 20 minutos
# ==============================================================================

library(tidyverse)
data("iris")

# ------------------------------------------------------------------------------
# PASO 1: Filtrado numérico simple (Operadores: >, <, >=, <=, ==, !=)
# ------------------------------------------------------------------------------

# Filtrar flores cuyo sépalo mida más de 6 cm
flores_grandes <- iris |> 
  filter(Sepal.Length > 6)

head(flores_grandes)

# ------------------------------------------------------------------------------
# PASO 2: Filtrado por variables categóricas (Texto/Factores)
# ------------------------------------------------------------------------------

# Filtrar únicamente la especie 'versicolor' (ojo con las mayúsculas)
versicolor_df <- iris |> 
  filter(Species == "versicolor")

glimpse(versicolor_df)

# ------------------------------------------------------------------------------
# PASO 3: Condiciones compuestas (Y / O)
# ------------------------------------------------------------------------------

# Condición "Y" (& o comas): Debe cumplir AMBAS condiciones a la vez
# Especie setosa Y pétalo menor a 1.4 cm
setosa_pequena <- iris |> 
  filter(Species == "setosa", Petal.Length < 1.4)

# Condición "O" (|): Puede cumplir cualquiera de las dos
# Especie setosa O especie virginica
dos_especies <- iris |> 
  filter(Species == "setosa" | Species == "virginica")

# Forma elegante de hacer un "O" múltiple usando %in%:
dos_especies_alt <- iris |> 
  filter(Species %in% c("setosa", "virginica"))

# ------------------------------------------------------------------------------
# TU TURNO (5 minutos de práctica):
# Escribe un filtro para encontrar las flores de la especie 'virginica' 
# que tengan un Petal.Width mayor o igual a 2.0
# ------------------------------------------------------------------------------

# Tu código aquí:
# virginica_top <- iris |> 
#   filter(...)