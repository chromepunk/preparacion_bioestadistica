# ==============================================================================
# Master en Bioinformática / Ciencia de Datos
# Práctica Diaria - Día 1: Tipos de Datos y Factores en R
# Autor: chromepunk
# Objetivo: Evitar coerción no deseada y controlar niveles de referencia
# ==============================================================================

# --- Ejercicio 1 y 2: Creación de factor con nivel de referencia controlado ---
muestras <- c("Tratado", "Control", "Tratado", "Tratado", "Control", "Control")

# Definimos explícitamente "Control" como primer nivel (referencia para modelos lineales)
muestras_factor <- factor(muestras, levels = c("Control", "Tratado"))

# Verificación de seguridad (Sanity check)
print("Niveles del factor (el primero debe ser Control):")
print(levels(muestras_factor)) 


# --- Ejercicio 3: Creación de vector lógico indexador ---
# Obtenemos TRUE únicamente para la condición de interés biológico ("Tratado")
muestras_logico <- muestras_factor == "Tratado"

# Verificación
print("Vector lógico de muestras bajo tratamiento:")
print(muestras_logico)


# --- Ejercicio 4: Conversión segura de factor numérico a real (double) ---
concentraciones <- factor(c("0.5", "1.0", "0.5", "2.0"))

# Evitamos la trampa de as.numeric() directo convirtiendo primero a character
concentraciones_numeric <- as.numeric(as.character(concentraciones))

# Verificación del tipo de datos final
print("Valores numéricos convertidos:")
print(concentraciones_numeric)
print(paste("¿Es de tipo numérico?:", is.numeric(concentraciones_numeric)))