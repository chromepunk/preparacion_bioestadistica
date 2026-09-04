# ==============================================================================
# Master en Bioinformática / Ciencia de Datos
# Práctica Diaria - Día 7: Creación de Funciones y Programación Defensiva
# Autor: chromepunk
# Objetivo: Diseñar funciones reutilizables, gestionar entornos y validar entradas
# ==============================================================================

# ==============================================================================
# 1. EXPLICACIÓN Y EJEMPLOS DE REFERENCIA
# ==============================================================================

# --- A. Estructura básica de una función ---
# Las funciones se definen con la palabra reservada 'function'. 
# Se recomienda usar return() de forma explícita para el valor de salida.

calcular_porcentaje <- function(cuenta, total, digitos = 2) {
  # 'digitos' tiene un valor por defecto de 2
  resultado <- (cuenta / total) * 100
  resultado_redondeado <- round(resultado, digits = digitos)
  return(resultado_redondeado)
}


# Uso de la función
calcular_porcentaje(15, 60)              # Devuelve 25
calcular_porcentaje(13, 60, digitos = 7) # Devuelve 25 (sin decimales)


# --- B. Entornos (Scope / Ámbito de variables) ---
# R tiene un "Global Environment" (tu consola) y un entorno local temporal para cada función.
# Las variables creadas dentro de una función NO existen fuera de ella.

mi_variable_global <- "Hola"

mi_funcion_test <- function() {
  mi_variable_local <- "Mundo"
  print(mi_variable_global) # Las funciones pueden LEER variables globales...
}

mi_funcion_test()
# print(mi_variable_local) # ¡ERROR! Esta variable no existe en tu consola.


# --- C. Programación Defensiva (stop) ---
# Sirve para lanzar un error personalizado si las condiciones de tus datos no son correctas.

calcular_log <- function(x) {
  if (any(x < 0, na.rm = TRUE)) {
    stop("Error crítico: No se pueden calcular logaritmos de números negativos.")
  }
  return(log2(x))
}

calcular_log(-3)


# ==============================================================================
# 2. BLOQUE DE EJERCICIOS (Para resolver)
# ==============================================================================

# --- EJERCICIO 1: Error Estándar de la Media (SEM) ---
# El Error Estándar de la Media (SEM) se calcula como: sd(x) / sqrt(length(x)).
#   a) Escribe una función llamada 'calcular_sem' que reciba un vector numérico 'x'.
#   b) Añade un argumento 'na.rm' que por defecto sea TRUE.
#   c) Asegúrate de que la función calcule la desviación estándar y la longitud (usando sum(!is.na(x)) si na.rm es TRUE) correctamente según el valor de 'na.rm'.
#   d) Pruébala con el vector de prueba provisto.

vector_prueba <- c(2.5, 4.0, NA, 5.5, 3.0)

# TU SOLUCIÓN AQUÍ (a, b, c y d):

calcular_sem <- function(x, na_rm = TRUE){
  if(na_rm){
    
    x_not_na <- x[!is.na(x)]
    result <- sd(x_not_na) / sqrt(length(x_not_na))
    
    }
    
    return(result)
  }

# --- EJERCICIO 2: Calculadora de Fold Change con Pseudoconteo ---
# En bioinformática, el Fold Change (FC) es la razón entre dos medias:
# media(grupo_A) / media(grupo_B).
# Para evitar la división por cero si una media es 0, se suele sumar un pequeño 
# "pseudocount" (normalmente 1).
#   a) Crea la función 'calcular_fold_change' que acepte dos vectores numéricos: 
#   'grupo_a' y 'grupo_b'.
#   b) Añade el argumento 'pseudocount' con un valor por defecto de 1.
#   c) La función debe calcular las medias de cada grupo (removiendo NAs), 
#   sumarles el pseudocount a ambas medias y luego dividirlas (media_a / media_b).
#   d) Devuelve el resultado.

# TU SOLUCIÓN AQUÍ (a, b, c y d):

calcular_fold_change <- function(A, B, pseudocount = 1){
  mean_A <- mean(A[!is.na(A)])
  mean_B <- mean(B[!is.na(B)]) + pseudocount
  
  result <- mean_A / mean_B
  
  return(result)
}


calcular_fold_change(c(3,2,3,4), c(2,2,2,2))



# --- EJERCICIO 3: El Experimento del Entorno (Comprensión Teórica) ---
# Analiza el siguiente bloque de código sin ejecutarlo primero:
#
# x <- 10
# duplicar <- function(x) {
#   x <- x * 2
#   return(x)
# }
# duplicar(5)
# print(x)
#
#   a) Responde en un comentario: ¿Qué valor imprimirá 'print(x)' al final y por qué?
#   b) Escribe un código que demuestre tu teoría.

# TU SOLUCIÓN AQUÍ (a y b):

# el valor es 10, porque la x dentro de la funcion es local y no afecta a la x global
# en el ejemplo x = 100 asi se ve la diferencia

x <- 100
dup <- function(x){
  x<- x * 2
  return(x)
}

dup(5)
print(x)


# --- EJERCICIO 4: Programación Defensiva para P-Values ---
# En estadística, los p-values deben estar estrictamente entre 0 y 1.
#   a) Diseña la función 'filtrar_pvalues' que reciba un vector 'p_vals' y un 
#   umbral 'alpha' que por defecto sea 0.05.
#   b) Dentro de la función, comprueba si ALGUN p-value es menor que 0 o mayor 
#   que 1. Si es así, detén la ejecución con stop() mostrando un mensaje descriptivo.
#   c) Si todos los valores son válidos, devuelve un vector lógico que sea TRUE 
#   para los p-values menores que 'alpha'.

# TU SOLUCIÓN AQUÍ (a, b y c):

filtrar_pvalues <- function(p_vals, alpha = 0.05){
  if(sum(p_vals > 1) > 0 | sum(p_vals < 0) > 0){
    stop("Los p_valores no pueden tener fuera del intervalo [0,1]")
  }
  return(p_vals < alpha)
}

filtrar_pvalues(c(1,10.5,0.3,0.001, 0.3))



# --- EJERCICIO 5: Mini-Pipeline Bioinformático Combinado ---
# Vamos a unificar lo aprendido. Diseña una función compleja llamada 'analisis_expresion'.
#   a) Debe recibir: una matriz de expresión ('matriz') y un factor de diseño con 
#   dos grupos ('condiciones').
#   b) Programación defensiva: Comprueba si el número de columnas de la matriz coincide 
#   con la longitud del factor 'condiciones'. Si no, lanza un error con stop().
#   c) Utiliza subsetting con corchetes para dividir la matriz en dos submatrices: 
#   una para las columnas del Grupo 1 y otra para las del Grupo 2 (según los niveles del factor).
#   d) Usa rowMeans() para calcular el promedio de expresión de cada gen en el Grupo 1 
#   y en el Grupo 2.
#   e) Devuelve una lista con tres elementos: 'media_grupo1', 'media_grupo2' y el 
#   cociente de ambas ('fold_change').

# Datos para probar tu función al finalizar:
matriz_test <- matrix(runif(12, 1, 10), nrow = 3, ncol = 4)
rownames(matriz_test) <- c("Gene1", "Gene2", "Gene3")
condiciones_test <- factor(c("Control", "Control", "Tratado", "Tratado"))


# TU SOLUCIÓN AQUÍ (a, b, c, d y e):

analisis_expresion <- function(matriz, condiciones = 4){
 if(ncol(matriz) != condiciones){
   stop("El numero de columnas de la matriz debe coincidir con el valor en condiciones")
 } 
  
  matriz_1 <- matriz_test[, c(1,2)]
  matriz_2 <- matriz_test[, c(3,4)]
  mean_1 <- rowMeans(matriz_1)
  mean_2 <- rowMeans(matriz_2)
  
  result <- list(
    media_grupo1 = mean_1,
    media_grupo2 = mean_2,
    fold_change = mean_1 / (mean_2 + 1)
  )
  
  #solucion GEMINI
  analisis_expresion <- function(matriz, condiciones){
    
    #1 validacion defensiva
    if(ncol(matriz) != length(condiciones)){
      stop("El numero de columnas de la matriz debe coincidir con la longitud de las condiciones")
    }
    
    #2 Identificar los 2 niveles/grupos del factor
    grupos <- levels(condiciones) # c("control", "tratado")
    
    #3 Subsetting dinamico usando vectores logicos basados en el factor
    matriz_g1 <- matriz[, condiciones == grupos[1]]
    matriz_g2 <- matriz[, condiciones == grupos[2]]
    
    #4 Calcular las medias por fila
    mean_1 <- rowMeans(matriz_g1)
    mean_2 <- rowMeans(matriz_g2)
    
    #5 retornar resultados
    result <- list(
      media_g1 = mean_1,
      media_g2 = mean_2,
      fold_change = mean_1 / mean_2
    )
    
    return(result)
    
    
    
    
    
    
  }
  
  return(result)
  
}


analisis_expresion(matriz_test)


