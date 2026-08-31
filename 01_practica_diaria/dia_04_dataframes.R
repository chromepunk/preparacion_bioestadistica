# ==============================================================================
# Master en Bioinformática / Ciencia de Datos
# Práctica Diaria - Día 4: Data Frames en R Base
# Autor: chromepunk
# Objetivo: Crear, manipular, filtrar y ordenar tablas de datos clínicos/genómicos
# ==============================================================================

# ==============================================================================
# 1. EXPLICACIÓN Y EJEMPLOS DE REFERENCIA
# ==============================================================================

# --- A. Creación de un Data Frame ---
# Se utiliza la función data.frame(). Cada argumento define una columna.
# Nota: Desde R 4.0.0, 'stringsAsFactors' es FALSE por defecto, por lo que los 
# caracteres no se transforman automáticamente en factores a menos que lo forcemos.

df_clinico <- data.frame(
  id_paciente = c("P01", "P02", "P03"),
  edad = c(45, 62, 34),
  respuesta = factor(c("Si", "No", "Si"), levels = c("No", "Si"))
)

# ¿Es un data frame técnicamente una lista? Sip, bajó el capó es un tipo de lista
is.list(df_clinico) 
# [1] TRUE

# ¿Cómo almacena R un data frame en la memoria?
typeof(df_clinico)
# [1] "list"

# --- B. Indexación y Extracción de Datos ---
# Podemos usar la coma [fila, columna], el signo $ para columnas completas, 
# o corchetes dobles [[]].

edades <- df_clinico$edad          # Vector numérico: c(45, 62, 34)
sub_tabla <- df_clinico[1:2, c("id_paciente", "edad")] # Filas 1 y 2, columnas específicas

df_clinico
sub_tabla

# La forma óptima para variables ordinales:
cohorte$estadio <- factor(c("I", "III", "II", "III", "I"), 
                          levels = c("I", "II", "III"), 
                          ordered = TRUE)

# --- C. Añadir Nuevas Columnas ---
df_clinico$IMC <- c(22.4, 28.1, 24.5) # Añade de golpe
df_clinico$grupo_edad <- ifelse(df_clinico$edad >= 50, "Mayor", "Joven") # Condicional

# --- D. Filtrado Lógico Avanzado ---
# Extraer filas que cumplan condiciones biológicas específicas.
# ¡Recuerda siempre poner la coma al final del corchete para indicar que quieres TODAS las columnas!
pacientes_jovenes_con_respuesta <- df_clinico[df_clinico$edad < 50 & df_clinico$respuesta == "Si", ]


# ==============================================================================
# 2. BLOQUE DE EJERCICIOS (Para resolver)
# ==============================================================================

# --- EJERCICIO 1: Creación de la Cohorte Oncológica ---
# Tienes datos de 5 pacientes con cáncer de pulmón.
#   a) Crea un data frame llamado 'cohorte' con las siguientes 4 columnas:
#        - 'paciente_id': "ID_A", "ID_B", "ID_C", "ID_D", "ID_E" (character)
#        - 'edad': 58, 71, 45, 63, 50 (numeric)
#        - 'estadio': "I", "III", "II", "III", "I" (transformado a factor con niveles ordenados: 
#           "I", "II", "III")
#        - 'supervivencia_dias': 1200, 340, 950, 180, 1500 (numeric)

# TU SOLUCIÓN AQUÍ (a):
cohorte <- data.frame(
  paciente_id= c("ID_A", "ID_B", "ID_C", "ID_D", "ID_E"),
  edad= c(58, 71, 45, 63, 50),
  estadio= as.factor(c("I", "III", "II", "III", "I")),
  supervivencia_dias= c(1200, 340, 950, 180, 1500)
)

# --- EJERCICIO 2: Inspección y Control de Calidad Inicial ---
# Utilizando el data frame 'cohorte' creado en el Ejercicio 1:
#   a) Escribe la función para ver las dimensiones del data frame (filas y columnas).
#   b) Escribe la función para obtener un resumen estadístico rápido de todas las columnas (summary).
#   c) Extrae la edad del paciente en la tercera fila de dos formas distintas.

# TU SOLUCIÓN AQUÍ (a, b y c):

#a
dim(cohorte)

#b
summary(cohorte)

#c
cohorte[3,"edad"]
cohorte[[2]][[3]]

# --- EJERCICIO 3: Mutación de Columnas (Cálculos Clínicos) ---
# En investigación clínica, el tiempo suele manejarse en meses o años para facilitar la interpretación.
#   a) Añade una nueva columna a 'cohorte' llamada 'supervivencia_meses' que sea el resultado 
#      de dividir 'supervivencia_dias' entre 30.4 (promedio de días al mes).
#   b) Añade una columna lógica llamada 'supervivencia_larga' que sea TRUE si la supervivencia en días 
#      es superior a 900, y FALSE en caso contrario.

# TU SOLUCIÓN AQUÍ (a y b):
#a
cohorte$supervivencia_meses <- cohorte$supervivencia_dias/30.4
cohorte

#b
cohorte$supervivencia_larga <- ifelse(cohorte$supervivencia_dias > 900, TRUE, FALSE)
cohorte

# --- EJERCICIO 4: Filtrado Selectivo de Pacientes ---
# Imagina que el comité ético te pide aislar ciertos subgrupos para un ensayo clínico.
#   a) Filtra 'cohorte' para obtener únicamente los pacientes con una edad igual o superior a 50 años.
#   b) Filtra 'cohorte' para obtener pacientes con un estadio de enfermedad grave ("III") AND 
#      que tengan una supervivencia inferior a 1 año (365 días).

# TU SOLUCIÓN AQUÍ (a y b):
#a, vemos fila a fila, me ha costado un poco sacarlo
cohorte[cohorte$edad >= 50,]

#b
cohorte[cohorte$estadio=="III" & cohorte$supervivencia_dias < 365, ]


# --- EJERCICIO 5: Ordenación de Datos por Prioridad Clínica ---
# R base utiliza la función order() para ordenar data frames. 
# Recuerda que order() devuelve las posiciones de los elementos ordenados, y se 
# aplica en las filas: df[order(df$columna), ]
#   a) Ordena la tabla 'cohorte' de menor a mayor edad.
#   b) Ordena la tabla 'cohorte' de mayor a menor supervivencia en días 
#  (Pista: usa un signo menos '-' antes de la columna en order() o usa el argumento decreasing = TRUE).

# TU SOLUCIÓN AQUÍ (a y b):
#a
cohorte[order(cohorte$edad),]

#b
cohorte[order(cohorte$supervivencia_dias, decreasing = TRUE), ]
