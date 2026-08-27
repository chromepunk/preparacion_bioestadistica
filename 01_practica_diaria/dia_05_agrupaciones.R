# Día 5: Agrupación de datos (group_by + summarise) y la estructura tibble
# Paso 1: Crear e inspeccionar el dataset de prueba
# 
# Copia y ejecuta este código para disponer del dataset en tu sesión de 
# trabajo. Observa cómo al imprimirlo en consola la cabecera indica # A 
# tibble: 6 × 5 y muestra los tipos de datos debajo de cada variable 
#(<chr>, <dbl>, <int>).

library(tidyverse)

# Dataset de práctica para la sesión
ventas_tienda <- tibble(
  producto          = c("Portátil", "Teclado", "Ratón", "Cafetera", "Aspiradora", "Auriculares"),
  categoria         = c("Electrónica", "Electrónica", "Electrónica", "Hogar", "Hogar", "Electrónica"),
  precio_unitario   = c(800, 45, 25, 60, 120, 50),
  unidades_vendidas = c(12, 25, 8, 15, 5, 30),
  descuento         = c(0.10, 0.05, 0.00, 0.15, 0.20, 0.10)
)

# Visualizar la estructura tibble
# ventas_tienda

# Paso 2: Entender la combinación group_by() + summarise()

# Recuerda la regla central:
# 
#   group_by() agrupa los datos en "carpetas invisibles" según los valores de una o más columnas.
# 
# summarise() colapsa cada grupo a una sola fila, aplicando funciones de resumen como sum(), mean(), max(), min() o n() (para contar filas).
# 
# 🏋️‍♂️ Desafíos del Día 5

# Resuelve los siguientes ejercicios escribiendo pipelines con el operador pipe (|>) en tu archivo:
#   
#   Desafío 1 (Core de hoy - Ejercicio Bloque B):
#   Partiendo de ventas_tienda:
#   
#   Calcula el ingreso neto de cada producto con mutate() (fórmula: precio_unitario * (1 - descuento) * unidades_vendidas).
# 
# Agrupa los datos por categoria.
# 
# Usa summarise() para calcular dos métricas:
#   
#   ingreso_total_cat: la suma (sum()) de todos los ingresos netos de esa categoría.
# 
# promedio_unidades: la media (mean()) de unidades vendidas en esa categoría.
# 
# Ordena el resultado de mayor a menor según ingreso_total_cat usando arrange().
# 
# Desafío 2 (Conteo y métricas extremas):
#   A partir de ventas_tienda, crea un resumen por categoria que devuelva:
#   
#   total_productos: el número total de productos en cada categoría usando n().
# 
# precio_maximo: el precio unitario más alto de la categoría usando max().
# 
# precio_minimo: el precio unitario más bajo de la categoría usando min().
# 
# Desafío 3 (Repaso integrador con filtrado previo):
#   Escribe un pipeline que:
#   
#   Filtre primero los productos que tengan un descuento mayor a 0 (es decir, solo productos rebajados).
# 
# Agrupe por categoria.
# 
# Resuma calculando el total de unidades vendidas (sum(unidades_vendidas)) bajo el nombre unidades_rebajadas.