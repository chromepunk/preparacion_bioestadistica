# ==============================================================================
# Master en Bioinformática / Ciencia de Datos
# Práctica Diaria - Día 8: Introducción a Tibbles y Lectura de Datos con readr
# Autor: chromepunk
# Objetivo: Importar datos de forma eficiente y trabajar con la estructura tibble
# ==============================================================================

# Cargar la librería necesaria (instálala con install.packages("tidyverse") si no la tienes)
library(tidyverse)

# ==============================================================================
# 1. EXPLICACIÓN Y EJEMPLOS DE REFERENCIA
# ==============================================================================

# --- A. ¿Qué es un Tibble? ---
# Es un data frame optimizado para la ciencia de datos moderna. 
# Si lo imprimes en la consola, tiene tres ventajas clave:
#   1. Solo muestra las primeras 10 filas (no te satura la consola con millones de datos).
#   2. Te indica bajo el nombre de cada columna su tipo de datos (<chr>, <dbl>, <int>, <fct>).
#   3. Es mucho más estricto: si buscas una columna que no existe, se queja en lugar de dar NULL en silencio.

mi_tibble <- tibble(
  id = 1:5,
  grupo = c("A", "A", "B", "B", "A"),
  valor = rnorm(5)
)
print(mi_tibble)


# --- B. Lectura eficiente con readr ---
# En bioinformática manejamos constantemente archivos de texto plano con delimitadores:
#   - CSV: Valores separados por comas (,) -> Usamos read_csv()
#   - TSV o TXT: Valores separados por tabuladores (\t) -> Usamos read_tsv() o read_delim()

# Ventajas de read_csv/tsv frente a read.csv de R Base:
# 1. Son entre 10 y 100 veces más rápidos leyendo datos masivos.
# 2. Importan los textos como caracteres (<chr>) directamente, evitando transformaciones raras.
# 3. Muestran en consola una "guía" clara con el tipo de datos que ha detectado para cada columna.


# ==============================================================================
# 2. BLOQUE DE EJERCICIOS (Para resolver)
# ==============================================================================

# --- PREPARACIÓN DE ARCHIVOS DE PRUEBA (No modificar este bloque) ---
# Ejecuta esta sección primero para generar dos archivos de datos simulados en tu sesión local.
write_csv(data.frame(
  Sample_ID = paste0("S", 1:10),
  Genotype = rep(c("WT", "KO"), each = 5),
  Expression = c(1.2, 1.5, 0.9, 1.1, 1.3, 4.5, 5.0, 4.8, NA, 5.2)
), "muestras_expresion.csv")

write_tsv(data.frame(
  Patient = c("P_01", "P_02", "P_03"),
  Age = c(45, 52, 61),
  Survival_Status = c("Alive", "Dead", "Alive")
), "clinico_pacientes.txt")


# --- EJERCICIO 1: Importación de un Dataset de Expresión (CSV) ---
#   a) Utiliza la función adecuada del paquete 'readr' para importar el archivo "muestras_expresion.csv".
#   b) Guarda el resultado en un objeto llamado 'exp_data'.
#   c) Comprueba la clase del objeto resultante en tu consola para verificar que es un tibble (tbl_df).

# TU SOLUCIÓN AQUÍ (a, b y c):




# --- EJERCICIO 2: Importación de Datos Clínicos (Tabulado / TSV) ---
#   a) Utiliza la función adecuada de 'readr' para importar el archivo "clinico_pacientes.txt" 
#      (ten en cuenta que está delimitado por tabuladores).
#   b) Guarda el resultado en un objeto llamado 'clin_data'.
#   c) Imprime el objeto en tu consola y observa cómo readr te describe automáticamente los tipos de columna.

# TU SOLUCIÓN AQUÍ (a, b y c):




# --- EJERCICIO 3: Creación Manual de Tibbles y Comportamiento Estricto ---
#   a) Crea manualmente un tibble llamado 'mis_genes' con tres columnas:
#        - 'gene_symbol': "TP53", "BRCA1", "GAPDH", "ACTB" (character)
#        - 'p_val': 0.001, 0.042, 0.230, 0.0002 (numeric)
#        - 'significativo': (un vector lógico basado en si el 'p_val' es menor de 0.05)
#   b) Intenta extraer una columna que NO exista en tu tibble (por ejemplo: 'mis_genes$score').
#   c) Escribe en un breve comentario qué advertencia (warning) te ha devuelto el tibble y por qué este comportamiento es más seguro que el de un data.frame común de R base (que devuelve NULL en silencio).

# TU SOLUCIÓN AQUÍ (a, b y c):




# --- EJERCICIO 4: Escritura Limpia de Datos ---
# Tras procesar tus datos, necesitas guardarlos en un formato estándar para compartirlos.
#   a) Toma el tibble 'mis_genes' que creaste en el Ejercicio 3.
#   b) Utiliza la función write_tsv() para guardarlo en tu disco local con el nombre "genes_filtrados_salida.tsv".
#   c) Comprueba que el archivo se ha creado correctamente (puedes verificar si aparece en la pestaña "Files" de tu RStudio).

# TU SOLUCIÓN AQUÍ (a, b y c):
