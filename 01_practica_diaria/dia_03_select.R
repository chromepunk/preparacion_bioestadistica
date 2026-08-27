# ==============================================================================
# DÍA 3: SELECCIÓN Y LIMPIEZA DE COLUMNAS CON SELECT()
# Objetivo: Quedarnos solo con las columnas que nos interesan o descartar ruido.
# Tiempo estimado: 20 minutos
# ==============================================================================

library(tidyverse)
data("iris")

# ------------------------------------------------------------------------------
# PASO 1: Seleccionar columnas específicas por su nombre
# ------------------------------------------------------------------------------

# Imagina que solo te interesan las medidas de los pétalos y la especie
petalos_df <- iris |> 
  select(Petal.Length, Petal.Width, Species)

head(petalos_df)

# ------------------------------------------------------------------------------
# PASO 2: Descartar columnas que no quieres con el signo menos (-)
# ------------------------------------------------------------------------------

# Si no quieres ver las medidas del sépalo, puedes excluirlas directamente
sin_sepalo <- iris |> 
  select(-Sepal.Length, -Sepal.Width)

head(sin_sepalo)

# ------------------------------------------------------------------------------
# PASO 3: Seleccionar rangos continuos de columnas (:)
# ------------------------------------------------------------------------------

# Si las columnas están juntas en la tabla, puedes seleccionarlas desde la primera hasta la última
ancho_columnas <- iris |> 
  select(Sepal.Width:Petal.Width)

head(ancho_columnas)

# ------------------------------------------------------------------------------
# PASO 4: Trucos útiles (starts_with, ends_with, contains)
# ------------------------------------------------------------------------------

# Seleccionar todas las columnas que empiecen por "Petal"
solo_petalos <- iris |> 
  select(starts_with("Petal"))

head(solo_petalos)

# ------------------------------------------------------------------------------
# TU TURNO (5 minutos de práctica):
# Combina lo de estos días: toma 'iris', filtra las flores de la especie 'setosa' 
# y quédate únicamente con las columnas 'Sepal.Length' y 'Species' usando select().
# ------------------------------------------------------------------------------

# Tu código aquí:
# resultado_dia3 <- iris |> 
#   filter(...) |> 
#   select(...)



# ==============================================================================
# DESAFÍO EXTRA DÍA 3
# ==============================================================================

# NIVEL 1: 
# Crea una variable 'desafio_1' que contenga únicamente las columnas 
# que TERMINEN con el texto "Width". 
# (PISTA: Usa el helper ends_with())

desafio1 <- iris |> select(ends_with("Width"))
head(desafio1)


# NIVEL 2: 
# Toma 'iris', quédate solo con las flores con sépalos mayores de 5.5 cm 
# Y LUEGO selecciona solo la especie y las medidas de los pétalos.
# (PISTA: Encadena iris |> filter(...) |> select(...))

prueba <- iris |> filter(Sepal.Length > 5.5) |> select(Species, starts_with("Petal"))
head(prueba)


# NIVEL 3 (PRO): 
# Filtra las flores que NO sean 'setosa' y descarta las columnas del sépalo.
# (PISTA: Para "diferente de" usa el operador !=)

prueba <- iris |> filter(Species != "setosa") |> select(-starts_with("Sepal"))
head(prueba)
