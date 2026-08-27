# ==============================================================================
# DÍA 4: CREACIÓN Y TRANSFORMACIÓN DE COLUMNAS CON MUTATE()
# Objetivo: Calcular nuevas variables a partir de las existentes.
# Tiempo estimado: 20 minutos
# ==============================================================================

library(tidyverse)
data("iris")

# ------------------------------------------------------------------------------
# PASO 1: Operaciones matemáticas simples entre columnas
# ------------------------------------------------------------------------------

# Crear una columna con el área aproximada del pétalo (Largo x Ancho)
iris_area <- iris |> 
  mutate(Petal.Area = Petal.Length * Petal.Width)

head(iris_area)

# ------------------------------------------------------------------------------
# PASO 2: Crear múltiples columnas a la vez
# ------------------------------------------------------------------------------

# Podemos calcular varias variables dentro del mismo mutate() separando por comas
iris_ratios <- iris |> 
  mutate(
    Ratio.Sepal = Sepal.Length / Sepal.Width,
    Ratio.Petal = Petal.Length / Petal.Width
  )

glimpse(iris_ratios)

# ------------------------------------------------------------------------------
# PASO 3: Transformaciones condicionales con ifelse()
# ------------------------------------------------------------------------------

# Clasificar las flores en "Grande" o "Normal" según la longitud del pétalo
iris_clasificado <- iris |> 
  mutate(
    Tamaño.Petalo = ifelse(Petal.Length > 4.0, "Grande", "Normal")
  )

head(iris_clasificado)

# ------------------------------------------------------------------------------
# TU TURNO (5 minutos de práctica):
# Crea una nueva columna llamada 'Sepal.Area' (Sepal.Length * Sepal.Width)
# y quédate solo con las columnas 'Species' y tu nueva variable 'Sepal.Area'.
# (PISTA: Combina mutate() y luego select())
# ------------------------------------------------------------------------------

# Tu código aquí:
# mi_resultado <- iris |> 
#   mutate(...) |> 
#   select(...)