# ==============================================================================
# Master en Bioinformática / Ciencia de Datos
# Práctica Diaria - Día 3: Matrices y Listas en R Base
# Autor: chromepunk
# Objetivo: Comprender estructuras multidimensionales (matrices) y heterogéneas (listas)
# ==============================================================================

# ==============================================================================
# 1. EXPLICACIÓN Y EJEMPLOS
# ==============================================================================

# --- A. Matrices: Datos tabulares homogéneos ---
# Una matriz es bidimensional (filas y columnas) pero, al igual que los vectores,
# SOLO puede contener un tipo de datos (por ejemplo, todo números).
# Es la estructura estándar para almacenar matrices de expresión génica (como RNA-seq).

# Creación de una matriz 3x2 (3 filas, 2 columnas)
datos_expresion <- matrix(c(1.2, 3.4, 5.1, 0.9, 11.2, 8.4), nrow = 3, ncol = 2)

# Indexación: [fila, columna]. Si dejas un espacio vacío, seleccionas todo.
fila_1 <- datos_expresion[2]    # Primera fila completa: c(1.2, 0.9)
columna_2 <- datos_expresion[, 2] # Segunda columna completa: c(0.9, 11.2, 8.4)
celda_especifica <- datos_expresion[3] # Fila 2, Columna 2: 11.2

# Operaciones rápidas por filas y columnas (esenciales en ómicas)
medias_por_columna <- colMeans(datos_expresion) # Medias de muestras
sumas_por_fila <- rowSums(datos_expresion)     # Expresión total de genes


# --- B. Listas: El contenedor heterogéneo ---
# A diferencia de vectores y matrices, las listas pueden almacenar objetos de
# CUALQUIER tipo y tamaño (caracteres, números, matrices e incluso otras listas).
# Las funciones de análisis estadístico en R suelen devolver sus resultados como listas.

mi_analisis <- list(
  metodo = "Análisis de Expresión Diferencial",
  genes_interes = c("TP53", "EGFR"),
  matriz_filtrada = datos_expresion
)

# Indexación de listas:
# 1. Con un solo corchete [ ] -> Devuelve una sublista (mantiene el contenedor "lista").
sublista <- mi_analisis[2] # Devuelve una lista de tamaño 1

# 2. Con doble corchete [[ ]] o el operador $ -> Extrae el contenido crudo.
metodo_texto <- mi_analisis[[2]]     # "Análisis de Expresión Diferencial"
genes_vector <- mi_analisis$genes_interes # c("TP53", "EGFR")


# ==============================================================================
# 2. EJERCICIOS PRÁCTICOS (Para resolver)
# ==============================================================================

# --- EJERCICIO 1: Análisis de una Matriz de Expresión ---
# Tienes una matriz que representa los niveles de expresión de 3 genes (filas) 
# medidos en 3 pacientes diferentes (columnas).
#   a) Crea la matriz usando los siguientes datos: c(10.5, 1.2, 8.4, 11.0, 0.9, 9.1, 9.8, 1.5, 8.0) 
#      configurando la matriz para que tenga 3 filas y 3 columnas (nrow = 3, ncol = 3).
#   b) Asigna nombres a las filas: "GeneA", "GeneB", "GeneC".
#   c) Asigna nombres a las columnas: "Paciente1", "Paciente2", "Paciente3".
#   d) Utiliza la función rowMeans() para calcular la expresión promedio de cada gen a lo largo de todos los pacientes.

# TU SOLUCIÓN AQUÍ (a, b, c y d):



# --- EJERCICIO 2: Construcción y Consulta de un Objeto Experimento (Listas) ---
# En bioinformática es muy común empaquetar toda la metadata de un ensayo en una lista.
#   a) Crea una lista llamada 'experimento_rna' que contenga:
#        - Un elemento de texto llamado "tecnologia" con el valor: "RNA-Seq"
#        - Un vector de factores llamado "condiciones" con los valores: "Sano", "Tratado", "Sano", "Tratado" (niveles controlados)
#        - Un vector numérico llamado "p_values" con los valores: 0.001, 0.042, 0.120, 0.005
#   b) Extrae el vector "p_values" de la lista de dos formas diferentes (usando [[]] y usando $).
#   c) Filtra el vector "p_values" que acabas de extraer para quedarte solo con los que son < 0.05.

# TU SOLUCIÓN AQUÍ (a, b y c):
