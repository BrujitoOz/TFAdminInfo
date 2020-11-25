#---------------------------------------------------------------------------------------
# Regresion Lineal
# data set precio de casas
# has 414 rows and 7 columns. 
# It provides the market historical data set of real estate valuations which are collected from Sindian Dist. New Taipei City, Taiwan.
# House price of unit area (10000 New Taiwan Dollar/Ping, where Ping is a local unit, 1 Ping = 3.3 meter squared) 
plot(valuation)
# Elegimos regresion lineal multiple para preedecir el precio de la casa basado en su antiguedad, latitud, longitud
f = lm(house.price.of.unit.area~latitude+longitude+house.age, data = valuation)
summary(f)
# 70% para entrenamiento
ids <- sample(1:NROW(valuation), NROW(valuation)*0.7)
entrenamiento <- valuation[ids, c(2,5:7) ]
probar <- valuation[-ids, c(2,5:7)]
# generar un modelo para entrenamiento
ft = lm(house.price.of.unit.area~latitude+longitude+house.age, data = entrenamiento)
# predecir
probar$prediccion <- predict(ft, probar)
probar
#---------------------------------------------------------------------------------------
# K- means
insurance.scale<-as.data.frame(scale(insurance[,5:9])) #escalar los datos
###Creamos los clusters
set.seed(80) #Fijar semilla, nos permite reproducir el mismo ejercicio y nos da el mismo resultado. Sino la fijamos nos da un resultado diferente
#ya que kmeans aleatorio al iniciarlo selecciona aleatoriamente las primeras observaciones una para  cada uno de los clusters q hayamos elegido
insurance.km <- kmeans(insurance.scale, centers = 4) #Realizamos clustering
names(insurance.km) # contenido del objeto
insurance.km$cluster # asignacion observaciones a clusters
#Se me como han sido asignados las observaciones a los distintos clusters
insurance.km$totss # inercia total
insurance.km$betweenss #inercia inter grupos
insurance.km$withinss # inercia intra grupos
insurance.km$tot.withinss # inercia intra grupos (total)
##Determinar un numero de clusters optimo
sumbt<-kmeans(insurance.scale, centers = 1)$betweenss
for(i in 2:10) sumbt[i] <-kmeans(insurance.scale, centers = i)$betweenss
plot(1:10, sumbt, type = "b", xlab = "numero de clusters", ylab = "suma de cuadrados inter grupos")
##Inspeccionando los resultados
plot(insurance$ant_comp, insurance$ant_perm, col=insurance.km$cluster, xlab = "Fidelidad a la compania", ylab = "Experiencia")
aggregate(insurance[,5:9], by = list(insurance.km$cluster), mean)

##KNN
insuranceKNN <- insurance[,-1:-3]
data_norm <- function(x) {((x - min(x)) / (max(x)-min(x)))}
insurance_norm <- as.data.frame(lapply(insuranceKNN[,-1], data_norm))
summary(insuranceKNN[,1:5])
summary(insurance_norm[,1:5])
insurance_train <- insurance_norm[1:17008,]
insurance_test <- insurance_norm[17008:18008,]
insurance_pred <- knn(insurance_train, insurance_test, insuranceKNN[1:17008,1], k=132)
table(insurance_pred, insuranceKNN[17008:18008,1])


##PCA
insurancePCA<- insurance[,5:9]
pc <- princomp(insurancePCA, cor=TRUE, score=TRUE)
summary(pc)
plot(pc)
plot(pc, type="l")
biplot(pc)
dim(insurancePCA)
attributes(pc)
pc$loadings
pc$scores