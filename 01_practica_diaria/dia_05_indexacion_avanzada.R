# ==============================================================================
# Master en Bioinformática / Ciencia de Datos
# Práctica Diaria - Día 5: Indexación Avanzada y Filtros de Precisión
# Autor: chromepunk
# Objetivo: Dominar %in%, which(), evitar la trampa de los NAs y usar subset()
# ==============================================================================

# ==============================================================================
# 1. EXPLICACIÓN Y EJEMPLOS DE REFERENCIA
# ==============================================================================

# --- A. El operador %in% (Buscador de coincidencia de conjuntos) ---
# Sirve para saber si los elementos de un vector están presentes en otro vector.
# Devuelve un vector lógico. Es vital para filtrar "listas de genes candidatos".

genes_detectados <- c("TP53", "GAPDH", "BRCA1", "ACTB", "EGFR")
mis_favoritos    <- c("BRCA1", "EGFR", "MYC") # MYC no está en el dataset

# ¿Cuáles de mis favoritos fueron detectados?
mis_favoritos %in% genes_detectados # TRUE, TRUE, FALSE
genes_detectados %in% mis_favoritos

# Filtrar el vector original para quedarme solo con los que me interesan
genes_detectados[genes_detectados %in% mis_favoritos] # "BRCA1" "EGFR"


# --- B. La función which() (De lógicos a índices de posición) ---
# Convierte un vector lógico en las posiciones numéricas donde se cumple el TRUE.
edades <- c(18, 45, NA, 65, 12)
posiciones_adultos <- which(edades >= 18) # Devuelve c(1, 2, 4) (ignora automáticamente el NA)


# --- C. La trampa mortal de los NAs en filtrados ---
# Si haces un filtro lógico normal en un Data Frame y hay NAs, R te devolverá 
# filas completas llenas de NA. ¡Un desastre!
df_test <- data.frame(id = 1:3, valor = c(10, NA, 30))
df_test

# Filtro clásico con peligro de NA:
df_test[df_test$valor > 15, ] # Devuelve la fila 3 y una fila fantasmal de NAs en la fila 2

# Solución con is.na() o which():
df_test[which(df_test$valor > 15), ] # Seguro y limpio


# --- D. La función subset() ---
# Una función de R base muy cómoda para filtrar Data Frames sin tener que 
# escribir el nombre del data frame tantas veces ni preocuparse por la coma final.
df_filtrado <- subset(df_test, valor > 15) # Filtrado elegante


# ==============================================================================
# 2. BLOQUE DE EJERCICIOS (Para resolver)
# ==============================================================================

# --- PREPARACIÓN DEL DATASET DE TRABAJO ---
# Ejecuta este bloque para crear el dataset simulado de expresión génica
set.seed(42) # Para reproducibilidad
datos_genes <- data.frame(
  gene_id = c("ENSG01", "ENSG02", "ENSG03", "ENSG04", "ENSG05", "ENSG06"),
  log2FC = c(2.1, -1.5, 0.4, NA, 3.2, -0.8),
  p_val = c(0.001, 0.042, 0.12, 0.002, NA, 0.65),
  ruta_metabolica = c("Apoptosis", "Ciclo_Celular", "Metabolismo", "Apoptosis", "Inmune", "Metabolismo")
)


# --- EJERCICIO 1: El Filtro del Panel de Cáncer (%in%) ---
# Tienes una lista de genes de interés clínico (tu panel de biomarcadores):
genes_panel <- c("ENSG01", "ENSG05", "ENSG09") # Nota: ENSG09 no está en la tabla 'datos_genes'


#   a) Filtra la tabla 'datos_genes' para obtener únicamente las filas correspondientes 
#      a los genes que pertenezcan a tu 'genes_panel'.

# TU SOLUCIÓN AQUÍ (a):
datos_genes$gene_id %in% genes_panel


# --- EJERCICIO 2: Evitando la Trampa de los NAs (which) ---
# Intenta filtrar los genes que tengan un p-value (columna p_val) inferior a 0.05.
#   a) Hazlo primero usando la indexación tradicional con corchetes: df[df$col < 0.05, ]. 
#      Observa el resultado y la fila de NAs que aparece.
#   b) Corrige el problema anterior utilizando la función which() para obtener un 
#      filtrado limpio libre de filas fantasma con NAs.

# TU SOLUCIÓN AQUÍ (a y b):
#a
datos_genes
resultados <- datos_genes$gene_id[datos_genes$p_val < 0.05]
resultados

#b
resultados <- datos_genes$gene_id[which(datos_genes$p_val < 0.05)]
resultados


# --- EJERCICIO 3: El poder de subset() ---
#   a) Utiliza la función subset() sobre la tabla 'datos_genes' para extraer los genes
#      que tengan un log2FC superior a 1.0 AND pertenecientes a la ruta "Apoptosis".
#   b) Usa subset() de nuevo, pero esta vez selecciona únicamente las columnas 
#      'gene_id' y 'log2FC' (Pista: investiga el argumento 'select' dentro de ?subset).

# TU SOLUCIÓN AQUÍ (a y b):
#a
resultados <- subset(datos_genes$gene_id, datos_genes$log2FC > 1.0)
resultados

#b
resultados <- subset(datos_genes, select = gene_id:log2FC, datos_genes$log2FC > 1.0)
resultados


# --- EJERCICIO 4: Sustitución Condicional Avanzada (Imputación básica) ---
# En ciencia de datos, a veces sustituimos los NAs por un valor por defecto (imputación).
#   a) Utiliza la función is.na() junto con la indexación en corchetes para localizar 
#      el valor NA en la columna 'log2FC' de 'datos_genes' y sustitúyelo por el valor 0.0.
#   b) Haz un print de la tabla 'datos_genes' para verificar que el NA ahora es un 0.0.

# TU SOLUCIÓN AQUÍ (a y b):
#a
datos_genes$log2FC[is.na(datos_genes$log2FC)] <- 0.0
datos_genes

#b
print(datos_genes)



# --- EJERCICIO 5: Extracción de Índices Biológicos ---
# Imagina que quieres enviar a un script de visualización únicamente los números 
# de las filas que cumplen un criterio.
#   a) Utiliza which() para obtener los índices (números) de las filas de los genes que 
#      están subexpresados (log2FC < 0).
#   b) Guarda esos índices en un vector llamado 'indices_sub'.
#   c) Usa ese vector 'indices_sub' para extraer esas filas completas de la tabla original.

# TU SOLUCIÓN AQUÍ (a, b y c):

