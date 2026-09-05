# ==============================================================================
# Master en Bioinformática / Ciencia de Datos
# EXAMEN SEMANA 1: FUNDAMENTOS DE R BASE
# Alumno: chromepunk
# Fecha: 2026-09-04
# ==============================================================================

# ==============================================================================
# PARTE A: DIAGNÓSTICO DE PRECISIÓN (Teórico-Conceptual)
# Escribe tus respuestas de texto directamente debajo de cada pregunta como comentarios.
# ==============================================================================

# ------------------------------------------------------------------------------
# PREGUNTA 1: Tienes el siguiente vector: x <- c(TRUE, "0.05", 0.001)
# ¿De qué clase (class(x)) será el vector resultante en R y por qué?
# ------------------------------------------------------------------------------
# RESPUESTA 1:
# tipo caracter (R aplica coerción implícita de forma automática)
# 


# ------------------------------------------------------------------------------
# PREGUNTA 2: Si ejecutas:
#   Caso A: resultado <- mi_lista[3]
#   Caso B: resultado <- mi_lista[[3]]
# ¿Qué diferencia estructural hay entre lo que guarda la variable 'resultado' 
# en el Caso A frente al Caso B?
# ------------------------------------------------------------------------------
# RESPUESTA 2:
# el caso A es una lista que contiene a lo que hay en esa posicion mientras
# que el B es  el elemento en si mismo, es decir [] genera una sublista
# 


# ------------------------------------------------------------------------------
# PREGUNTA 3: ¿Por qué es peligroso hacer un filtrado biológico usando:
#   cohorte[cohorte$p_val < 0.05, ]
# si la columna 'p_val' contiene valores perdidos (NA)? 
# ¿Cómo lo solucionarías de forma segura usando R Base?
# ------------------------------------------------------------------------------
# RESPUESTA 3:
# por que los valores na no pueden ser computados por no ser numeros en si
# pudiendo obtener resultados anomales, habria que eliminarlos de la estructura
# cohorte primero. NA < 0.05 no devuelve un booleano sino NA. 
#           Truco usar which
# 



# ==============================================================================
# PARTE B: EL FLUJO INTEGRADO (Caso de Estudio Práctico)
# Resuelve cada sección programando en las áreas indicadas.
# ==============================================================================

# --- INICIALIZACIÓN DE LOS DATOS (No modificar este bloque) ---
set.seed(42)
matriz_cruda <- matrix(
  c(1.2, 12.4, NA, 8.5, 1.1,
    0.9, 14.1, 1.5, 9.0, 1.0,
    1.2, NA, 0.1, 7.9, 1.3), 
  nrow = 3, ncol = 5
)
rownames(matriz_cruda) <- c("Gene_A", "Gene_B", "Gene_C")
colnames(matriz_cruda) <- paste0("Muestra_", 1:5)

# Factor de diseño clínico
diseño_clinico <- factor(c("Sano", "Sano", "Tratado", "Tratado", "Sano"), 
                         levels = c("Sano", "Tratado"))

# ------------------------------------------------------------------------------
# SECCIÓN 1: Control de Calidad e Imputación de Datos
#   a) Detecta mediante código si hay valores ausentes (NA) en 'matriz_cruda'.
#   b) Crea una copia de la matriz llamada 'matriz_limpia'.
#   c) En 'matriz_limpia', sustituye todos los valores NA por el promedio general 
#      de toda la matriz (calculado SIN tener en cuenta los NAs).
# ------------------------------------------------------------------------------

# TU SOLUCIÓN AQUÍ (Sección 1):
valores_ausentes <- sum(is.na(matriz_cruda))

matriz_limpia <- matriz_cruda
matriz_limpia[is.na(matriz_limpia)] <-  mean(matriz_cruda, na.rm = TRUE)
matriz_limpia




# ------------------------------------------------------------------------------
# SECCIÓN 2: Escribir tu propia Función de Normalización (Z-Score)
#   a) Diseña una función llamada 'normalizar_z' que reciba un vector numérico 'x'.
#   b) La función debe restar la media de 'x' y dividir el resultado por la 
#      desviación estándar de 'x' (ambos estadísticos calculados sin NAs).
#   c) Programación defensiva: Si el vector recibido 'x' NO es de tipo numérico, 
#      la función debe detenerse inmediatamente (función stop) mostrando un mensaje 
#      claro que explique el problema.
# ------------------------------------------------------------------------------

# TU SOLUCIÓN AQUÍ (Sección 2):
normalizar_z <- function(x){
  if(!is.numeric(x)){
    stop("Argumento debe ser vector numerico")
  }
  mean_x <- mean(x, na.rm = TRUE)
  sd_x <- sd(x, na.rm = TRUE)
  
  return((x-mean_x)/sd_x)
}

normalizar_z(c(1,3,4))

# ------------------------------------------------------------------------------
# SECCIÓN 3: Aplicación Masiva de la Función (apply)
#   a) Aplica tu función 'normalizar_z' a cada GEN (fila) de 'matriz_limpia' 
#      utilizando la función apply().
#   b) Asegúrate de que la matriz resultante mantenga la orientación biológica 
#      original (genes en filas, muestras en columnas). Transponla si es necesario.
#   c) Guarda el resultado en un objeto llamado 'matriz_normalizada'.
# ------------------------------------------------------------------------------

# TU SOLUCIÓN AQUÍ (Sección 3):
matriz_normalizada <- t(apply(matriz_limpia, MARGIN = 1, FUN = normalizar_z))




# ------------------------------------------------------------------------------
# SECCIÓN 4: Análisis por Grupos Clínicos (Integración de Listas)
#   a) Utiliza el factor 'diseño_clinico' para separar la 'matriz_normalizada' 
#      en dos submatrices: una para el grupo "Sano" y otra para "Tratado".
#   b) Calcula el promedio de expresión para cada gen en el grupo Sano usando 
#      rowMeans() y guárdalo en 'medias_sanos'. Haz lo mismo para el grupo 
#      Tratado y guárdalo en 'medias_tratados'.
#   c) Crea una lista llamada 'resultados_finales' que contenga tres elementos:
#        - Elemento 1: 'sanos' -> Guarda el vector 'medias_sanos'.
#        - Elemento 2: 'tratados' -> Guarda el vector 'medias_tratados'.
#        - Elemento 3: 'fold_change' -> Guarda el cociente simple de: 
#          medias_tratados / medias_sanos
# ------------------------------------------------------------------------------

# TU SOLUCIÓN AQUÍ (Sección 4):
sano <- matriz_normalizada[,diseño_clinico == "Sano"]
tratado <- matriz_normalizada[,diseño_clinico == "Tratado"]

medias_sanos <- rowMeans(sano)
medias_tratados <- rowMeans(tratado)

resultados_finales <- list(
  sanos = medias_sanos,
  tratados = medias_tratados, 
  fold_change = medias_tratados / medias_sanos
)



# --- COMPROBACIÓN FINAL ---
# Ejecuta esta línea al acabar para visualizar tus resultados del análisis:
# print(resultados_finales)