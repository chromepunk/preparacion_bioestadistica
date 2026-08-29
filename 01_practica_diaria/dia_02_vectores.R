# ==============================================================================
# Master en Bioinformática / Ciencia de Datos
# Práctica Diaria - Día 2: Vectores y Operaciones Vectorizadas en R
# Autor: chromepunk
# Objetivo: Comprender el filtrado lógico, operaciones vectorizadas y manejo de NAs
# ==============================================================================

# ==============================================================================
# 1. EXPLICACIÓN Y EJEMPLOS
# ==============================================================================

# --- A. La magia de la vectorización ---
# En R, casi todo es un vector. Las funciones matemáticas se aplican a cada 
# elemento de forma automática y ultra-eficiente (implementadas en C/Fortran).
# ¡Evita usar bucles 'for' siempre que puedas!

expresion_inicial <- c(2, 4, 8, 16)

# Operaciones element-wise (elemento a elemento)
log2_expresion <- log2(expresion_inicial) # c(1, 2, 3, 4)
expresion_duplicada <- expresion_inicial * 2 # c(4, 8, 16, 32)


# --- B. Indexación Lógica (Filtrado de datos) ---
# Si indexamos un vector con un vector lógico del mismo tamaño, R solo se queda
# con las posiciones que son TRUE. Es la base de todo el filtrado de datos.

genes_expresion <- c(1.2, 15.4, 0.5, 23.1, 8.9)
pasa_filtro <- genes_expresion > 10.0 # Vector lógico: c(FALSE, TRUE, FALSE, TRUE, FALSE)
pasa_filtro

# Filtrado real utilizando corchetes []
genes_altamente_expresados <- genes_expresion[pasa_filtro] # c(15.4, 23.1)
genes_altamente_expresados

# --- C. Vectores con Nombres ---
# Puedes asignar un identificador de texto a cada elemento de un vector. Es muy
# útil en genómica para asociar valores (como Fold-Change) a IDs de genes.

fold_change <- c(1.5, -2.1, 0.4)
names(fold_change) <- c("TP53", "BRCA1", "GAPDH")


# Ahora puedes filtrar directamente por el nombre del gen
fc_brca1 <- fold_change["BRCA1"] # -2.1
fc_brca1



# --- D. El problema de los datos ausentes (NA) ---
# En biología clínica es muy común tener valores perdidos (NA). Cualquier 
# operación matemática sobre un NA devuelve NA a menos que se indique lo contrario.

datos_clinicos <- c(120, 115, NA, 132, 118)
media_erronea <- mean(datos_clinicos) # Devuelve NA
media_erronea

# Solución: usar el argumento na.rm = TRUE (NA Remove)
media_correcta <- mean(datos_clinicos, na.rm = TRUE) # 121.25
media_correcta


# ==============================================================================
# 2. EJERCICIOS PRÁCTICOS (Para resolver)
# ==============================================================================

# --- EJERCICIO 1: Control de Datos Ausentes (NAs) ---
# Tienes el siguiente vector de niveles de expresión de un biomarcador con fallos de lectura (NA).
# Calcula:
#   a) La media de expresión ignorando los NAs.
#   b) La mediana de expresión ignorando los NAs.

# TU SOLUCIÓN AQUÍ (a y b):
lecturas_biomarcador <- c(4.5, 6.2, NA, 5.8, 7.1, NA, 3.9)
mean(lecturas_biomarcador, na.rm = TRUE)


# --- EJERCICIO 2: Indexación y Filtrado Lógico ---
# Tienes un vector de valores de p-value obtenidos de un análisis de expresión diferencial.
#   a) Crea un vector lógico que sea TRUE para los p-values significativos (menores de 0.05).
#   b) Utiliza ese vector lógico para extraer los p-values significativos del vector original.

p_values <- c(0.012, 0.450, 0.003, 0.051, 0.049, 0.820, 0.0001)

# TU SOLUCIÓN AQUÍ (a y b):

filtro <- p_values < 0.05
filtro

p_values[filtro]


# --- EJERCICIO 3: Vectores con Nombres (Mapeo de Genes) ---
# Tienes las tasas de mutación de 4 genes implicados en cáncer.
#   a) Crea un vector numérico con las tasas: 0.12, 0.05, 0.34, 0.01.
#   b) Asígnale los nombres de los genes: "EGFR", "KRAS", "PIK3CA", "PTEN".
#   c) Extrae la tasa de mutación únicamente para "KRAS" y "PTEN" usando sus nombres.

# TU SOLUCIÓN AQUÍ (a, b y c):

tasas <- c(0.12, 0.05, 0.34, 0.01)
names(tasas)=c("EGFR", "KRAS", "PIK3CA", "PTEN")

a_extraer <- c("KRAS", "PTEN")#tiene que usar un vector 

tasas[a_extraer]



# --- EJERCICIO 4: Operación Vectorizada Combinada ---
# En bioinformática es común normalizar datos aplicando transformaciones logarítmicas.
# Toma el vector 'lecturas_biomarcador' (del Ejercicio 1):
#   a) Suma un "pseudocount" de 1 a todos los elementos del vector (para evitar log(0) si hubiera ceros).
#   b) Aplica la transformación log2 a todo el vector resultante.
#   c) Recuerda calcular la media del vector transformado final sin que los NAs arruinen el resultado.

# TU SOLUCIÓN AQUÍ (a, b y c):
mean(log2(lecturas_biomarcador + 1), na.rm = TRUE)




