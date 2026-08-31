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
datos_expresion

# Indexación: [fila, columna]. Si dejas un espacio vacío, seleccionas todo.
fila_1 <- datos_expresion[1,]    # Primera fila completa: c(1.2, 0.9)
# sin coma: fila_1 <- datos_expresion[1]    Estira la matriz y lo trata como un vector
fila_3_no_coma <- datos_expresion[3]    # Primera fila completa: c(1.2, 0.9)
columna_2 <- datos_expresion[, 2] # Segunda columna completa: c(0.9, 11.2, 8.4)
celda_especifica <- datos_expresion[3] # Fila 2, Columna 2: 11.2

fila_1
fila_3_no_coma

# Operaciones rápidas por filas y columnas (esenciales en ómicas)
medias_por_columna <- colMeans(datos_expresion) # Medias de muestras
sumas_por_fila <- rowSums(datos_expresion)     # Expresión total de genes

datos_expresion
medias_por_columna


# --- B. Listas: El contenedor heterogéneo ---
# A diferencia de vectores y matrices, las listas pueden almacenar objetos de
# CUALQUIER tipo y tamaño (caracteres, números, matrices e incluso otras listas).
# Las funciones de análisis estadístico en R suelen devolver sus resultados como listas.

mi_analisis <- list(
  metodo = "Análisis de Expresión Diferencial",
  genes_interes = c("TP53", "EGFR"),
  matriz_filtrada = datos_expresion
)

class(mi_analisis)

# Indexación de listas:
# 1. Con un solo corchete [ ] -> Devuelve una sublista (mantiene el contenedor "lista").
sublista <- mi_analisis[2] # Devuelve una lista de tamaño 1
sublista

# 2. Con doble corchete [[ ]] o el operador $ -> Extrae el contenido crudo.
metodo_texto <- mi_analisis[[2]]     # "Análisis de Expresión Diferencial"
genes_vector <- mi_analisis$genes_interes # c("TP53", "EGFR")

class(metodo_texto)


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

niv_exp <- matrix(c(10.5, 1.2, 8.4, 11.0, 0.9, 9.1, 9.8, 1.5, 8.0), nrow = 3, ncol = 3)

names <- c("GeneA", "GeneB", "GeneC")

colnames(niv_exp) <- names
rownames(niv_exp) <- c("Paciente1", "Paciente2", "Paciente3")
niv_exp

rowMeans(niv_exp)


# --- EJERCICIO 2: Construcción y Consulta de un Objeto Experimento (Listas) ---
# En bioinformática es muy común empaquetar toda la metadata de un ensayo en una lista.
#   a) Crea una lista llamada 'experimento_rna' que contenga:
#        - Un elemento de texto llamado "tecnologia" con el valor: "RNA-Seq"
#        - Un vector de factores llamado "condiciones" con los valores: "Sano", "Tratado", "Sano", 
# "Tratado" (niveles controlados)
#        - Un vector numérico llamado "p_values" con los valores: 0.001, 0.042, 0.120, 0.005
#   b) Extrae el vector "p_values" de la lista de dos formas diferentes (usando [[]] y usando $).
#   c) Filtra el vector "p_values" que acabas de extraer para quedarte solo con los que son < 0.05.

# TU SOLUCIÓN AQUÍ (a, b y c):

#a
experimento_rna <- list("RNA-Seq",
                        factor(c("Sano", "Tratado", "Sano", "Tratado")),
                        c(0.001, 0.042, 0.120, 0.005))

names(experimento_rna) <- c("tecnologia", "condiciones", "p_values")

#b
experimento_rna[3]
experimento_rna$p_values

#c
filtro <- experimento_rna[[3]] < 0.05
experimento_rna[[3]][filtro]

# ==============================================================================
# BLOQUE DE TARDE: EJERCICIOS DE CONSOLIDACIÓN Y CASOS REALES
# ==============================================================================

# --- EJERCICIO 3: Filtrado de Ruido en Matrices de Expresión (Masking) ---
# En microarrays o RNA-Seq, los valores de expresión muy bajos se consideran 
# "ruido de fondo". Tienes la siguiente matriz de expresión de 4 genes y 3 muestras:

matriz_cruda <- matrix(
  c(1.1, 12.4, 0.2, 8.5, 
    0.9, 14.1, 1.5, 9.0, 
    1.2, 11.8, 0.1, 7.9), 
  nrow = 4, ncol = 3
)
rownames(matriz_cruda) <- c("Gene1", "Gene2", "Gene3", "Gene4")
colnames(matriz_cruda) <- c("Muestra1", "Muestra2", "Muestra3")

# Tareas:
#   a) Crea una copia de 'matriz_cruda' llamada 'matriz_filtrada'.
#   b) Utilizando indexación lógica directa sobre la matriz (sin bucles), 
#      sustituye todos los valores menores o iguales a 1.5 (<= 1.5) por 0.
#   c) Calcula cuántos genes han quedado completamente "apagados" (con expresión 0) 
#      en la Muestra 1 tras el filtrado.

# TU SOLUCIÓN AQUÍ (a, b y c):

#a
matriz_filtrada <- matriz_cruda

#b
matriz_filtrada[matriz_filtrada <= 1.5] = 0

#c
sum(matriz_filtrada[, "Muestra1"] == 0)


# --- EJERCICIO 4: Desempaquetando Resultados de Modelos (Listas Anidadas) ---
# La mayoría de los paquetes estadísticos en R (como limma o t.test) devuelven 
# los resultados en listas que contienen más listas.
# Tienes la siguiente lista que simula el resultado de un análisis de expresión diferencial:

resultado_pipeline <- list(
  experimento = "RNA-Seq Cáncer de Mama",
  fecha = "2026-08-29",
  resultados_estadisticos = list(
    p_values = c(0.001, 0.45, 0.02, 0.08),
    fold_change = c(2.5, -0.4, 1.8, -1.2),
    intervalos_confianza = list(
      Gene1 = c(1.9, 3.1),
      Gene3 = c(1.1, 2.5)
    )
  )
)

# Tareas:
#   a) Extrae la fecha del experimento directamente usando el operador $.
#   b) Extrae el vector de 'fold_change' que está dentro de 'resultados_estadisticos'.
#   c) Extrae el límite inferior del intervalo de confianza para el "Gene1" 
#      (Pista: debes navegar por tres niveles de la lista utilizando [[ ]] o $ consecutivamente 
#      hasta llegar al vector del Gene1, y luego indexar su primera posición).

# TU SOLUCIÓN AQUÍ (a, b y c):
#a
resultado_pipeline$fecha

#b
resultado_pipeline[["resultados_estadisticos"]][["fold_change"]]

#c
min(resultado_pipeline$resultados_estadisticos$intervalos_confianza$Gene1)
