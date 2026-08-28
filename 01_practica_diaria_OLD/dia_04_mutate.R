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

sepal_area = iris |> mutate(
  Sepal.Area = Sepal.Length * Sepal.Width
) |>  select(Species, Sepal.Area)

head(sepal_area)

# Tu código aquí:
# mi_resultado <- iris |> 
#   mutate(...) |> 
#   select(...)

# 
# Ejercicio 1: Filtrar y Crear (Nivel Falso Principiante)
# Crea una nueva variable llamada Petal.Ratio dividiendo Petal.Length entre 
# Petal.Width. Después, quédate solo con las flores que pertenezcan a la 
# especie "virginica" y selecciona únicamente las columnas Species y 
# Petal.Ratio.


petal_ratio <- iris |> mutate(Petal.Ratio = Petal.Length / Petal.Width) |> select(Species, Petal.Ratio)

head(petal_ratio)


# 
# 
# 
# Ejercicio 2: Ordenar Datos (Nuevo Truco: arrange())
# Investiga o prueba la función arrange(). 
# Toma el dataframe original iris, calcula de nuevo Sepal.Area (como 
# hiciste antes) y ordena las filas de mayor a menor según esa nueva área (Pista: usa arrange(desc(Sepal.Area))). Muestra solo las columnas Species y Sepal.Area.
# 


ordenadas <- iris |> mutate(Sepal.Area = Sepal.Length * Sepal.Width) |> arrange(desc(Sepal.Area))



head(ordenadas)

# 
# Ejercicio 3: Desafío Combinado (Máster)
# Con un solo flujo de pipes (|>), haz lo siguiente:
#   Quédate solo con las flores cuyo Sepal.Length sea mayor que 5.5.
# Crea una columna llamada Is.Large que valga TRUE si Petal.Length > 4 y FALSE si no.
# Selecciona Species, Sepal.Length, Petal.Length e Is.Large.
# Ordena el resultado de menor a mayor por Sepal.Length.

resultado <- iris |> 
  mutate(Is.Large = ifelse(Petal.Length > 4, TRUE, FALSE)) |>
  filter(Sepal.Length > 5.5) |>
  select(Species, Sepal.Length, Petal.Length, Is.Large) |>
  arrange(desc(Sepal.Length))

head(resultado)


#Repaso


library(tidyverse)

# Creamos el dataset de prueba
ventas_tienda <- tibble(
  producto = c("Portátil", "Teclado", "Ratón", "Cafetera", "Aspiradora", "Auriculares"),
  categoria = c("Electrónica", "Electrónica", "Electrónica", "Hogar", "Hogar", "Electrónica"),
  precio_unitario = c(800, 45, 25, 60, 120, 50),
  unidades_vendidas = c(12, 25, 8, 15, 5, 30),
  descuento = c(0.10, 0.05, 0.00, 0.15, 0.20, 0.10)
)

resultado <- ventas_tienda |> 
  filter(categoria == "Electrónica" & unidades_vendidas > 10) |>
  mutate(ingreso_total = precio_unitario*(1-descuento)*unidades_vendidas) |>
  select(producto, ingreso_total, unidades_vendidas)

head(resultado)
