#---------------------------------------------------------------------------------------
# Muestra de datasets
# casos positivos covid-19
View(cposi)
# casos fallecidos covid-19
View(cfalle)
#---------------------------------------------------------------------------------------
# Normalizar: al haber solo datos de edades y fechas, no consideramos necesario normalizar
# --------------------------------------------------------------------------------------
# Imputacion: eliminar NA's

# dataset casos positivos covid-19
# contamos la cantidad de NA's : treinta y cuatro
sum(is.na(cposi))
# todas tienen toda la fila llena de NA
cposi[is.na(cposi),] 
# Eliminamos todas esas filas
cposi <- cposi %>% drop_na()
# comprobamos que la cantidad de NA's es cero
sum(is.na(cposi))

# dataset fallecidos por covid-19
# contamos la cantidad de NA's : tres mil seiscientos noventa y ocho
sum(is.na(cfalle))
# todas tienen toda la fila llena de NA
cfalle[is.na(cfalle),] 
# Eliminamos todas esas filas
cfalle <- cfalle %>% drop_na()
# comprobamos que la cantidad de NA's es cero
sum(is.na(cposi))
#---------------------------------------------------------------------------------------
# Eliminacion de valores anomalos
# convertimos las fechas a formato Date que maneja Lubridate

# Dataset Casos Positivos Covid-19
# Fecha_Corte
# Primero es dato tipo integer
class(cposi[,1])
# Lo modificamos
cposi[,1] <- ymd(cposi[,1])
# Ahora es tipo Date
class(cposi[,1])

# Fecha_Resultado
class(cposi[,9])
cposi[,9] <- ymd(cposi[,9])
class(cposi[,9])

# Dataset Fallecidos por Covid-19
# Fecha_Corte
# dato tipo integer
class(cfalle[,1])
cfalle[,1] <- ymd(cfalle[,1])
# ahora es Date
class(cfalle[,1])

# Fecha_Fallecimiento
class(cfalle[,3])
cfalle[,3] <- ymd(cfalle[,3])
class(cfalle[,3])
#---------------------------------------------------------------------------------------
# Eliminacion de outliers

# Dataset casos positivos covid-19
# vista rapida de outliers usando boxplot
test <- boxplot(cposi[,7], ylab = "edad")
# Posiciones y valores de los outliers encontrados
which(cposi[,7] %in% test$out)
test$out
# Reemplazando por la media de Edad
cposi[which(cposi[,7] %in% test$out), 7] <- as.integer(mean(cposi$EDAD))
# No hay mas outliers
boxplot(cposi[,7], ylab = "edad")

# Dataset casos fallecimiento por covid-19
# vista rapida de outliers usando boxplot
test <- boxplot(cfalle$EDAD_DECLARADA, ylab = "edad")
# Posiciones y valores de los outliers encontrados
which(cfalle$EDAD_DECLARADA %in% test$out)
test$out
# Reemplazando por la media de Edad
cfalle[which(cfalle$EDAD_DECLARADA %in% test$out), 4] <- as.integer(mean(cfalle$EDAD_DECLARADA))
# No hay mas outliers
boxplot(cfalle$EDAD_DECLARADA, ylab = "edad")
#---------------------------------------------------------------------------------------