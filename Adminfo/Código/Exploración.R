#POSITIVOS

### 1 - Mostrar casos positivos de Hombres en Lima mayores de 50 de la provincia de lima
tce1<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'MASCULINO', EDAD >= 50) %>% 
  dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD, UUID) %>% dplyr::arrange(EDAD)
tce1


### 2 - Mostrar casos positivos de Mujeres en Lima de 50 de la provincia de lima
tce2<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'FEMENINO', EDAD >= 50) %>% 
  dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD, UUID) %>% dplyr::arrange(EDAD)
tce2

### 3 - Cantidad de Mujeres contagiadas vs Hombres
tce3<- cposi %>% dplyr::select(SEXO) %>% dplyr::group_by(SEXO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
tce3
names(tce3)<-c('Sexo', 'Cantidad Contagiados')
graf<-ggplot(tce3,aes(x=`Sexo`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`))
graf + geom_bar(stat = "identity")


### 4 - Cantidad de contagios por distrito en lima 
tce4<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::select(DISTRITO) %>% dplyr::group_by(DISTRITO) %>% 
  dplyr::summarise(Cantidad_Total = dplyr::n())
tce4
names(tce4)<-c('Distrito', 'Cantidad Contagiados')
graf<-ggplot(tce4,aes(x=`Distrito`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()

### 5 - Cantidad de contagios en cada departamento

tce5<- cposi %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
tce5
names(tce5)<-c('DEPARTAMENTO', 'Cantidad Contagiados')
graf<-ggplot(tce5,aes(x=`DEPARTAMENTO`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()

### 6 - Cantidad de contagiados por edad en  lima
tce6<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA') %>% dplyr::select(EDAD) %>% dplyr::group_by(EDAD) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
tce6

names(tce6)<-c('EDAD', 'Cantidad Contagiados')
p1<-ggplot(tce6)+aes(y=EDAD, x="", fill=`Cantidad Contagiados`)+geom_boxplot()
p1<-p1+labs(y="EDAD", x="", title = "Edad Contagiados")+theme_linedraw()
print(p1)

names(tce6)<-c('EDAD', 'Cantidad Contagiados')
graf<-ggplot(tce6,aes(x=`EDAD`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`))
graf + geom_bar(stat = "identity")

### 7 -  Cantidad de Peruanos positivos que utilizaron PCR o PR como metodo de testeo

tce7<- cposi %>% dplyr::select(METODODX) %>% dplyr::group_by(METODODX) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
tce7
names(tce7)<-c('METODODX', 'Cantidad Contagiados')
graf<-ggplot(tce7,aes(x=`METODODX`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`))
graf + geom_bar(stat = "identity")

### 8 - Cantidad de contagiados por mes en Lima
tce8 <- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::mutate(month = format(FECHA_RESULTADO, '%m')) %>% 
  dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
tce8
names(tce8)<-c('Mes', 'Cantidad Contagiados')
graf<-ggplot(tce8,aes(x=`Mes`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`))
graf + geom_bar(stat = "identity")


### 9 - Cantidad de contagiados por mes en Peru
tce9 <- cposi %>% dplyr::mutate(month = format(FECHA_RESULTADO, "%m")) %>% 
  dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
tce9
names(tce9)<-c('Mes', 'Cantidad Contagiados')
graf<-ggplot(tce9,aes(x=`Mes`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()

### 10 - Cantidad de personas contagiadas entre los 19 y 45 de edad por departamento
tce10<- cposi %>% dplyr::filter(EDAD <= 45, EDAD >=19) %>% dplyr::select(DEPARTAMENTO) %>% 
  dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% 
  dplyr::arrange(desc(Cantidad_Total))
tce10
names(tce10)<-c('DEPARTAMENTO', 'Cantidad Contagiados entre 19 y 45')
graf<-ggplot(tce10,aes(x=`DEPARTAMENTO`, y=`Cantidad Contagiados entre 19 y 45`, fill = `Cantidad Contagiados entre 19 y 45`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()




#####################
#FALLECIDOS 

### 11 - Mostrar casos de fallecidos Hombres en Lima provincia de Lima mayores a 65
tce11<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'MASCULINO', EDAD_DECLARADA >= 65) %>% 
  dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD_DECLARADA, UUID) %>% dplyr::arrange(desc(EDAD_DECLARADA))
tce11

### 12 - Mostrar casos positivos de Mujeres en Lima
tce12<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'FEMENINO', EDAD_DECLARADA >= 65) %>% 
  dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD_DECLARADA, UUID) %>% dplyr::arrange(desc(EDAD_DECLARADA))
tce12

### 13 - Cantidad de Mujeres fallecidas vs Hombres en el Peru
tce13<- cfalle %>% dplyr::select(SEXO) %>% dplyr::group_by(SEXO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
tce13
names(tce13)<-c('SEXO', 'Cantidad fallecidos')
graf<-ggplot(tce13,aes(x=`SEXO`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))
graf + geom_bar(stat = "identity")

### 14 - Cantidad de fallecidos por distrito en lima, provincia de Lima
tce14<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::select(DISTRITO) %>% dplyr::group_by(DISTRITO) %>% dplyr::summarise(Cantidad_Total = dplyr::n()) %>% dplyr::arrange(desc(Cantidad_Total))
tce14
names(tce14)<-c('Distrito', 'Cantidad fallecidos')
graf<-ggplot(tce14,aes(x=`Distrito`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()

### 15 - Cantidad de fallecidos en cada departamento

tce15<- cfalle %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% 
  dplyr::arrange(desc(Cantidad_Total))
tce15
names(tce15)<-c('DEPARTAMENTO', 'Cantidad fallecidos')
graf<-ggplot(tce15,aes(x=`DEPARTAMENTO`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()

### 16 - Cantidad de fallecidos mayores de 65 vs menores en Peru
tce16<- cfalle %>% dplyr::filter(EDAD_DECLARADA>65) %>% dplyr::select(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total_Mayores_65 = dplyr::n()) 
tce16
tce16_1<- cfalle %>% dplyr::filter(EDAD_DECLARADA<65) %>% dplyr::select(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total_Menores_65 = dplyr::n()) 
tce16_1


### 17 -  Cantidad de Limenos fallecidos en provincias vs Lima

tce17<- cfalle %>% dplyr::filter(DEPARTAMENTO != 'LIMA') %>% dplyr::select(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Provincia = dplyr::n())
tce17
tce17_1<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA') %>% dplyr::select(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Lima = dplyr::n())
tce17_1

### 18 - Cantidad de fallecidos por mes en Lima
tce18 <- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::mutate(month = format(FECHA_FALLECIMIENTO, "%m")) %>% 
  dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
tce18
names(tce18)<-c('Mes', 'Cantidad fallecidos')
graf<-ggplot(tce18,aes(x=`Mes`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()

### 19 - Cantidad de fallecidos por mes en el Peru
tce19 <- cfalle %>% dplyr::mutate(month = format(FECHA_FALLECIMIENTO, "%m")) %>% 
  dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
tce19

names(tce19)<-c('Mes', 'Cantidad fallecidos')
graf<-ggplot(tce19,aes(x=`Mes`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()

### 20 - Cantidad de personas menores de 45 fallecidas por departamento
tce20<- cfalle %>% dplyr::filter(EDAD_DECLARADA <= 45) %>% dplyr::select(DEPARTAMENTO) %>% 
  dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% 
  dplyr::arrange(desc(Cantidad_Total))
tce20
names(tce20)<-c('DEPARTAMENTO', 'Cantidad fallecidos')
graf<-ggplot(tce20,aes(x=`DEPARTAMENTO`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()



### Cantidad de fallecidos Mujeres por departamento excepto Lima
fallec2<- cfalle %>% dplyr::filter(SEXO == 'FEMENINO', DEPARTAMENTO != 'LIMA') %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>%
  dplyr::summarise(Cantidad_Fallecidas = dplyr::n())
fallec2
names(fallec2)<-c('DEPARTAMENTO', 'Cantidad fallecidos')
graf<-ggplot(fallec2,aes(x=`DEPARTAMENTO`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()

### Cantidad de fallecidos Hombres por departamento Excepto Lima
fallec3<- cfalle %>% dplyr::filter(SEXO == 'MASCULINO', DEPARTAMENTO != 'LIMA') %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>%
  dplyr::summarise(Cantidad_Fallecidas = dplyr::n())
fallec3
names(fallec3)<-c('DEPARTAMENTO', 'Cantidad fallecidos')
graf<-ggplot(fallec3,aes(x=`DEPARTAMENTO`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))
graf + geom_bar(stat = "identity", position ="dodge")+coord_flip()


###Diagramas de cajas
### Fallecidos
ggplot(cfalle) + aes(y = EDAD_DECLARADA) + geom_boxplot(fill = "#AA5512") + labs(title="Bloxplot")

### Contagiados
ggplot(cposi) + aes(y = EDAD) + geom_boxplot(fill = "#AA5512") + labs(title="Bloxplot")

###Contagiados Hombres mayores de 40
contag1<- cposi %>% dplyr::filter(SEXO == 'MASCULINO', EDAD >= 40) %>% 
  dplyr::select(EDAD) %>% dplyr::group_by(EDAD) %>% dplyr::summarise(Cantidad_Contagiados = dplyr::n()) %>% dplyr::arrange(EDAD)
contag1
names(contag1)<-c('EDAD', 'Cantidad Contagiados')
p1<-ggplot(contag1)+aes(y=EDAD, x="", fill=`Cantidad Contagiados`)+geom_boxplot()
p1<-p1+labs(y="EDAD", x="", title = "Hombres mayores de 40")+theme_linedraw()
print(p1)

###Fallecidos Hombres mayores de 40
fallec1<- cfalle %>% dplyr::filter(SEXO == 'MASCULINO', EDAD_DECLARADA >= 40) %>% 
  dplyr::select(EDAD_DECLARADA) %>% dplyr::group_by(EDAD_DECLARADA) %>% dplyr::summarise(Cantidad_Fallecidos = dplyr::n())
fallec1
names(fallec1)<-c('EDAD', 'Cantidad_Fallecidos')
p1<-ggplot(fallec1)+aes(y=EDAD, x="", fill=`Cantidad_Fallecidos`)+geom_boxplot()
p1<-p1+labs(y="EDAD", x="", title = "Hombres mayores de 40")+theme_linedraw()
print(p1)