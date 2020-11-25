setwd("C:/Users/Hernan/Documents/GitHub/TFAdminInfo/Adminfo/Código/app")
#---------------------------------------------------------------------------------------
# 2 Datasets elegidos (Queries, graficos)
cposi = read.csv("../positivos_covid.csv", sep = ";")
cfalle = read.csv("../fallecidos_covid.csv", sep = ";")
#---------------------------------------------------------------------------------------
# Regresion Lineal
valuation = read.csv("../valuation.csv", sep = ";")
#---------------------------------------------------------------------------------------
# K-means, KNN 
insurance = read.csv("../insurance.csv")