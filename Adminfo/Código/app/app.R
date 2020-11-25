library(shiny)
# Define UI for application that draws a histogram
ui <- fluidPage(
    
    theme = shinytheme("superhero"),
    
    navbarPage("Proyecto Casos de infectados positivos y fallecidos por covid-19",
               tabPanel("Presentación",
                        fluidRow(
                            column(12, 
                                   align="center", 
                                   tags$b(h1("Universidad Peruana de Ciencias Aplicadas")),
                                   h2("Administración de la información"),
                                   h3("Integrantes:"),
                                   h3("Adrian Gabriel Moscol Suarez"),
                                   h3("Hernán Aaron Razo Ballón"),
                                   h4("Ciclo: 2020-2"),
                                   h4(getwd())
                                   ),
                            div(
                                column(12, 
                                       align="center",
                                       br(),h4("Descripcion del Proyecto"),
                                       p("El objetivo de este trabajo es desplegar una plataforma de soporte a proyectos de ciencia de los datos"),
                                       p("Dado unos conjuntos de datos escogidos se realizaran tareas como el preprocesamiento, exploración, y creación de modelos predictivos y/o clasificatorios usando herramientas de visualización."),
                                       p("Por lo cual, los estudiantes tendran la oportunidad de demostrar lo aprendido durante el desarrollo del curso de Administración de la Información"),
                                     
                                       tags$image(src="datascience.jpg", width="100%")
                                       ),
                                )
                            )
                        ),
               tabPanel("Datos/Datasets",
                        sidebarLayout(
                            sidebarPanel(
                                selectInput("inputselect", 
                                            label = h3("Tipo de archivo: "), 
                                            choices = c('text'='1','csv'='2','xlsx'='3')
                                            ),
                                hr(),
                                fileInput("inputds1", "Seleccione Archivo",
                                          accept = c("text/csv","text/json", "text/comma-separated-values,text/plain",".csv","XLSX file", ".json",".xlsx",".xls",".xml")
                                          ),
                                helpText("Max. Tamaño de archivo: 100MB")
                                ),
                            mainPanel(
                                tabsetPanel(
                                    tabPanel(
                                        "Info",
                                        tableOutput("tablaInfo")
                                        ),
                                    tabPanel(
                                        "Data",
                                        tableOutput("tablaData")
                                        )
                                    )
                                )
                            )
                        ),
               tabPanel("Preprocesamiento",
                        navlistPanel(
                            
                            tabPanel("Limpieza e Imputacion",
                                     h4("Unir Dataset's Separados"),
                                     hr(),
                                     checkboxInput("control1", "Mostrar Codigo", FALSE),
                                     hr(),
                                     verbatimTextOutput("preprocesamiento"), 
                                     tableOutput("tablaPrepro"))
                            )
                        ),
               
               
               tabPanel("Exploracion",
                        navlistPanel(
                            tabPanel("Consultas DPLYR",
                                     h4("DPLYR"), 
                                     hr(),
                                     selectInput("selectdp", 
                                                 label = NULL, 
                                                 choices = c('consulta 1'='1','consulta 2'='2','consulta 3'='3','consulta 4'='4','consulta 5'='5', 'consulta 6' = '6', 'consulta 7' = '7', 'consulta 8' = '8', 'consulta 9' = '9', 'consulta 10' = '10', 'consulta 11' = '11', 'consulta 12' = '12', 'consulta 13' = '13', 'consulta 14' = '14', 'consulta 15' = '15', 'consulta 16' = '16', 'consulta 17' = '17', 'consulta 18' = '18', 'consulta 19' = '19', 'consulta 20' = '20')),
                                     checkboxInput("control2", "Mostrar Codigo", FALSE),
                                     hr(),
                                     verbatimTextOutput("queries"),
                                     dataTableOutput("queryexplo")
                                     )
                            )
                        ),
               
               tabPanel("Graficos",
                        
                        
                        navlistPanel( 
                            tabPanel("Graficos GGPLOT2",
                                     h4("GGPLOT2"),hr(),
                                     selectInput("selectgg", label = NULL, choices = c('consulta 1'='1','consulta 2'='2','consulta 3'='3','consulta 4'='4','consulta 5'='5', 'consulta 6' = '6', 'consulta 7' = '7', 'consulta 8' = '8', 'consulta 9' = '9', 'consulta 10' = '10', 'consulta 11' = '11', 'consulta 12' = '12', 'consulta 13' = '13', 'consulta 14' = '14', 'consulta 15' = '15', 'consulta 16' = '16', 'consulta 17' = '17', 'consulta 18' = '18', 'consulta 19' = '19', 'consulta 20' = '20')),
                                     checkboxInput("control4", "Mostrar Codigo", FALSE),
                                     hr(),
                                     verbatimTextOutput(""),
                                     plotOutput('plot1')
                                     )
                            )
                        ),
               
               tabPanel("Modelos",
                        
                        navlistPanel(  
                            tabPanel("Ayuda vs Estimacion de Daño",
                                     hr(),
                                     selectInput("sose", label = NULL, choices = c('consulta 1' = '1', 'consulta 2' = '2', 'consulta 3' = '3', 'consulta 4'='4')),
                                     checkboxInput("control6", "Mostrar Codigo", FALSE),
                                     verbatimTextOutput("consulta6"),
                                     hr(), 
                                     plotOutput("plot8"))))
                        
                        
               
               
               ),
    
    
)
options(shiny.maxRequestSize=100*1024^2)
server <- function(input, output) {
    
    setwd("C:/Users/Hernan/Documents/GitHub/TFAdminInfo/Adminfo/Código/app")
    # Datos.R
    #---------------------------------------------------------------------------------------
    # 2 Datasets elegidos (Queries, graficos)
    cposi = read.csv("../positivos_covid.csv", sep = ";")
    cfalle = read.csv("../fallecidos_covid.csv", sep = ";")
    #---------------------------------------------------------------------------------------
    # Regresion Lineal
    valuation = read.csv("../valuation.csv", sep = ";")
    #---------------------------------------------------------------------------------------
    
    output$tablaData <- renderTable({
        if(is.null(input$inputds1))
        {return(NULL)}
        input$inputselect
        if(input$inputselect == "1"){
            head(read.csv(input$inputds1$datapath, sep=";"), 30 )
        } else { if(input$inputselect == "2") {
            head(read.csv(input$inputds1$datapath, sep=";"), 30)
        } else { if(input$inputselect == "3") {
            read_xlsx(input$inputds1$datapath)
        }
         } }
    })
    
    output$tablaInfo <- renderTable({
        if(is.null(input$inputds1)){return ()}
        input$inputds1
    })
    
    
    output$preprocesamiento <- renderText({ '
        sum(is.na(cposi))
        cposi[is.na(cposi),] 
        # Eliminamos todas esas filas
        cposi <- cposi %>% drop_na()

        sum(is.na(cposi))
        
        # dataset fallecidos por covid-19
        # contamos la cantidad de NAs : tres mil seiscientos noventa y ocho
        sum(is.na(cfalle))
        # todas tienen toda la fila llena de NA
        cfalle[is.na(cfalle),] 
        # Eliminamos todas esas filas
        cfalle <- cfalle %>% drop_na()
        # comprobamos que la cantidad de NAs es cero
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
        # Si siguen habiendo outliers, ejecutar de nuevo desde la linea 77
        boxplot(cfalle$EDAD_DECLARADA, ylab = "edad")
        '})
    
    observeEvent(input$control1, {
        if(input$control1==TRUE)
        {toggle("preprocesamiento")} else {toggle("preprocesamiento")}
    })
    observeEvent(input$control2, {
        if(input$control2==TRUE)
        {toggle("consulta2")} else {toggle("consulta2")}
    })
    
    observeEvent(input$control4, {

        if(input$control4==TRUE)
        {toggle("consulta4")} else {toggle("consulta4")}
        
    })
    output$consulta6 <- renderText({
        "
        ##PCA
        insurancePCA<- insurance[,5:9]
            pc <- princomp(insurancePCA, cor=TRUE, score=TRUE)
            
            consulta 1
            return (plot(pc))
            consulta 2
            return(plot(pc, type='l'))
            consulta 3
            return (biplot(pc))
        ## K Means
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
            ##Inspeccionando los resultados
            plot(insurance$ant_comp, insurance$ant_perm, col=insurance.km$cluster, xlab = 'Fidelidad a la compania', ylab = 'Experiencia')
        
        "
    })
    observeEvent(input$control6, {
        if(input$control6==TRUE)
        {toggle("consulta6")} else {toggle("consulta6")}
        
    })
    output$tablaPrepro <- renderTable({
        Pro <- read.csv(file = '../dscombinado.csv')
        if (is.null(Pro)) 
            return(NULL)
        else head(Pro, 30)
    })
    
    
    
    output$plot8 <- renderPlot({
        box<- input$sose
        if (is.null(box))
        {return(NULL)}
        if (box == "1") {
            insurancePCA<- insurance[,5:9]
            pc <- princomp(insurancePCA, cor=TRUE, score=TRUE)
            return (plot(pc))
            dim(insurancePCA)
            attributes(pc)
            pc$loadings
            pc$scores
        } else {
        if (box == "2") {
            insurancePCA<- insurance[,5:9]
            pc <- princomp(insurancePCA, cor=TRUE, score=TRUE)
            dim(insurancePCA)
            attributes(pc)
            pc$loadings
            pc$scores
            return(plot(pc, type="l"))
            
        } else {
        if (box == "3") {
            insurancePCA<- insurance[,5:9]
            pc <- princomp(insurancePCA, cor=TRUE, score=TRUE)
            dim(insurancePCA)
            attributes(pc)
            pc$loadings
            pc$scores
            return (biplot(pc))
            
        } else {
        if (box == "4") {
            
            
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
            # aggregate(insurance[,5:9], by = list(insurance.km$cluster), mean)
            
        }
        }
        }
        }
            
            
        
        
        
    })
    
    
    
    output$plot1 <- renderPlot({
        box<- input$selectgg
        if (is.null(box))
        {return(NULL)}
        
         
        if (box == "1") {
            tce3<- cposi %>% dplyr::select(SEXO) %>% dplyr::group_by(SEXO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
            names(tce3)<-c('Sexo', 'Cantidad Contagiados')
            graf<-ggplot(tce3,aes(x=`Sexo`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`)) + geom_bar(stat = "identity")
            return (graf)
        } else{  
            if (box == "2") {
                tce4<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::select(DISTRITO) %>% dplyr::group_by(DISTRITO) %>% 
                    dplyr::summarise(Cantidad_Total = dplyr::n())
                names(tce4)<-c('Distrito', 'Cantidad Contagiados')
                graf<-ggplot(tce4,aes(x=`Distrito`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`)) + geom_bar(stat = "identity", position ="dodge")+coord_flip()
                return (graf)
            } else { 
                if (box == "3") {
                    tce5<- cposi %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
                    names(tce5)<-c('DEPARTAMENTO', 'Cantidad Contagiados')
                    graf<-ggplot(tce5,aes(x=`DEPARTAMENTO`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`))+ geom_bar(stat = "identity", position ="dodge")+coord_flip()
                    return (graf)

                } else { 
                    if (box == "4") { 
                        tce6<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA') %>% dplyr::select(EDAD) %>% dplyr::group_by(EDAD) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
                        names(tce6)<-c('EDAD', 'Cantidad Contagiados')
                        p1<-ggplot(tce6)+aes(y=EDAD, x="", fill=`Cantidad Contagiados`)+geom_boxplot()
                        p1<-p1+labs(y="EDAD", x="", title = "Edad Contagiados")+theme_linedraw()
                        return (p1)
                        
                    } else { 
                        if (box=="5") { 
                            tce6<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA') %>% dplyr::select(EDAD) %>% dplyr::group_by(EDAD) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
                            names(tce6)<-c('EDAD', 'Cantidad Contagiados')
                            graf<-ggplot(tce6,aes(x=`EDAD`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`)) + geom_bar(stat = "identity")
                            return (graf)
                            
                        } else {
                            if (box=="6") {
                                tce7<- cposi %>% dplyr::select(METODODX) %>% dplyr::group_by(METODODX) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
                                names(tce7)<-c('METODODX', 'Cantidad Contagiados')
                                graf<-ggplot(tce7,aes(x=`METODODX`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`))+ geom_bar(stat = "identity")
                                return (graf)
                                
                            } else {
                                if (box =="7") {
                                    ### 8 - Cantidad de contagiados por mes en Lima
                                    tce8 <- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::mutate(month = format(FECHA_RESULTADO, '%m')) %>% 
                                        dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
                                    
                                    names(tce8)<-c('Mes', 'Cantidad Contagiados')
                                    graf<-ggplot(tce8,aes(x=`Mes`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`)) + geom_bar(stat = "identity")
                                    return (graf)
                                } else {
                                    if (box =="8") {
                                        tce9 <- cposi %>% dplyr::mutate(month = format(FECHA_RESULTADO, "%m")) %>% 
                                            dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
                                        names(tce9)<-c('Mes', 'Cantidad Contagiados')
                                        graf<-ggplot(tce9,aes(x=`Mes`, y=`Cantidad Contagiados`, fill = `Cantidad Contagiados`)) + geom_bar(stat = "identity", position ="dodge")+coord_flip()
                                        return (graf)
                                        
                                    } else {
                                        if (box == "9") {
                                            tce10<- cposi %>% dplyr::filter(EDAD <= 45, EDAD >=19) %>% dplyr::select(DEPARTAMENTO) %>% 
                                                dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% 
                                                dplyr::arrange(desc(Cantidad_Total))
                                            names(tce10)<-c('DEPARTAMENTO', 'Cantidad Contagiados entre 19 y 45')
                                            graf<-ggplot(tce10,aes(x=`DEPARTAMENTO`, y=`Cantidad Contagiados entre 19 y 45`, fill = `Cantidad Contagiados entre 19 y 45`))+ geom_bar(stat = "identity", position ="dodge")+coord_flip()
                                            return (graf)
                                            
                                        } else {
                                            if (box == "10") {
                                                tce13<- cfalle %>% dplyr::select(SEXO) %>% dplyr::group_by(SEXO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
                                                names(tce13)<-c('SEXO', 'Cantidad fallecidos')
                                                graf<-ggplot(tce13,aes(x=`SEXO`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`)) + geom_bar(stat = "identity")
                                                return (graf)
                                                
                                            } else {
                                                if (box == "11") {
                                                    tce14<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::select(DISTRITO) %>% dplyr::group_by(DISTRITO) %>% dplyr::summarise(Cantidad_Total = dplyr::n()) %>% dplyr::arrange(desc(Cantidad_Total))
                                                    names(tce14)<-c('Distrito', 'Cantidad fallecidos')
                                                    graf<-ggplot(tce14,aes(x=`Distrito`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))+ geom_bar(stat = "identity", position ="dodge")+coord_flip()
                                                    return (graf)
                                                    
                                                } else {
                                                    if (box == "12") {
                                                        
                                                        tce15<- cfalle %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% 
                                                            dplyr::arrange(desc(Cantidad_Total))
                                                        names(tce15)<-c('DEPARTAMENTO', 'Cantidad fallecidos')
                                                        graf<-ggplot(tce15,aes(x=`DEPARTAMENTO`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`)) + geom_bar(stat = "identity", position ="dodge")+coord_flip()
                                                        return (graf)
                                                        
                                                    } else {
                                                        if (box == "13") {
                                                            tce18 <- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::mutate(month = format(FECHA_FALLECIMIENTO, "%m")) %>% 
                                                                dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
                                                            names(tce18)<-c('Mes', 'Cantidad fallecidos')
                                                            graf<-ggplot(tce18,aes(x=`Mes`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))+ geom_bar(stat = "identity", position ="dodge")+coord_flip()
                                                            return (graf)
                                                            
                                                        } else {
                                                            if (box == "14") {
                                                                tce19 <- cfalle %>% dplyr::mutate(month = format(FECHA_FALLECIMIENTO, "%m")) %>% 
                                                                    dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
                                                                names(tce19)<-c('Mes', 'Cantidad fallecidos')
                                                                graf<-ggplot(tce19,aes(x=`Mes`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`)) + geom_bar(stat = "identity", position ="dodge")+coord_flip()
                                                                return (graf)
                                                            } else {
                                                                if (box == "15") {
                                                                    tce20<- cfalle %>% dplyr::filter(EDAD_DECLARADA <= 45) %>% dplyr::select(DEPARTAMENTO) %>% 
                                                                        dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% 
                                                                        dplyr::arrange(desc(Cantidad_Total))
                                                                    names(tce20)<-c('DEPARTAMENTO', 'Cantidad fallecidos')
                                                                    graf<-ggplot(tce20,aes(x=`DEPARTAMENTO`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`)) + geom_bar(stat = "identity", position ="dodge")+coord_flip()
                                                                    return (graf)
                                                                    
                                                                } else {
                                                                    if (box == "16") {
                                                                        fallec2<- cfalle %>% dplyr::filter(SEXO == 'FEMENINO', DEPARTAMENTO != 'LIMA') %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>%
                                                                            dplyr::summarise(Cantidad_Fallecidas = dplyr::n())
                                                                        names(fallec2)<-c('DEPARTAMENTO', 'Cantidad fallecidos')
                                                                        graf<-ggplot(fallec2,aes(x=`DEPARTAMENTO`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`))+ geom_bar(stat = "identity", position ="dodge")+coord_flip()
                                                                        return (graf)
                                                                        
                                                                    } else {
                                                                        if (box == "17") {
                                                                            fallec3<- cfalle %>% dplyr::filter(SEXO == 'MASCULINO', DEPARTAMENTO != 'LIMA') %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>%
                                                                                dplyr::summarise(Cantidad_Fallecidas = dplyr::n())
                                                                            
                                                                            names(fallec3)<-c('DEPARTAMENTO', 'Cantidad fallecidos')
                                                                            graf<-ggplot(fallec3,aes(x=`DEPARTAMENTO`, y=`Cantidad fallecidos`, fill = `Cantidad fallecidos`)) + geom_bar(stat = "identity", position ="dodge")+coord_flip()
                                                                            return (graf)
                                                                        } else {
                                                                            if (box == "18") {
                                                                                return(ggplot(cfalle) + aes(y = EDAD_DECLARADA) + geom_boxplot(fill = "#AA5512") + labs(title="Bloxplot"))
                                                                                
                                                                            } else {
                                                                                if (box == "19") {
                                                                                    contag1<- cposi %>% dplyr::filter(SEXO == 'MASCULINO', EDAD >= 40) %>% 
                                                                                        dplyr::select(EDAD) %>% dplyr::group_by(EDAD) %>% dplyr::summarise(Cantidad_Contagiados = dplyr::n()) %>% dplyr::arrange(EDAD)
                                                                                    names(contag1)<-c('EDAD', 'Cantidad Contagiados')
                                                                                    p1<-ggplot(contag1)+aes(y=EDAD, x="", fill=`Cantidad Contagiados`)+geom_boxplot()
                                                                                    p1<-p1+labs(y="EDAD", x="", title = "Hombres mayores de 40")+theme_linedraw()
                                                                                    return (p1)
                                                                                    
                                                                                    
                                                                                } else {
                                                                                    if (box == "20") {
                                                                                        fallec1<- cfalle %>% dplyr::filter(SEXO == 'MASCULINO', EDAD_DECLARADA >= 40) %>% 
                                                                                            dplyr::select(EDAD_DECLARADA) %>% dplyr::group_by(EDAD_DECLARADA) %>% dplyr::summarise(Cantidad_Fallecidos = dplyr::n())
                                                                                        
                                                                                        names(fallec1)<-c('EDAD', 'Cantidad_Fallecidos')
                                                                                        p1<-ggplot(fallec1)+aes(y=EDAD, x="", fill=`Cantidad_Fallecidos`)+geom_boxplot()
                                                                                        p1<-p1+labs(y="EDAD", x="", title = "Hombres mayores de 40")+theme_linedraw()
                                                                                        return (p1)
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                    
                                    
                                }
                            }
                        }
                        
                    } 
                    
                }
            } }
        
        
        
        
        
        }
    )
    
    
    
    
    
    
    
    
    
    output$queryexplo <- renderDataTable({
        box<- input$selectdp
        if (is.null(box))
        {return(NULL)}
        
        if (box == "1") {
            tce1<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'MASCULINO', EDAD >= 50) %>% dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD, UUID) %>% dplyr::arrange(EDAD)
            return (tce1)
        } else{  
        if (box == "2") {
            tce2<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'FEMENINO', EDAD >= 50) %>% dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD, UUID) %>% dplyr::arrange(EDAD)
            return (tce2)
        } else { 
        if (box == "3") {
            tce3<- cposi %>% dplyr::select(SEXO) %>% dplyr::group_by(SEXO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
            return (tce3)
        } else { 
        if (box == "4") { 
            tce4<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::select(DISTRITO) %>% dplyr::group_by(DISTRITO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
            return (tce4)
        } else { 
        if (box=="5") { 
            tce5<- cposi %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
            return (tce5)
        } else {
        if (box=="6") {
            tce6<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA') %>% dplyr::select(EDAD) %>% dplyr::group_by(EDAD) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
            return (tce6)
        } else {
        if (box =="7") {
            tce7<- cposi %>% dplyr::select(METODODX) %>% dplyr::group_by(METODODX) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
            return (tce7)
        } else {
        if (box =="8") {
            tce8 <- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::mutate(month = format(FECHA_RESULTADO, "%m")) %>% dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n()) 
            return (tce8)
        } else {
        if (box == "9") {
            tce9 <- cposi %>% dplyr::mutate(month = format(FECHA_RESULTADO, "%m")) %>% dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
            return (tce9)
        } else {
        if (box == "10") {
            tce10<- cposi %>% dplyr::filter(EDAD <= 45, EDAD >=19) %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% dplyr::arrange(desc(Cantidad_Total))
            return (tce10)
        } else {
        if (box == "11") {
            tce11<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'MASCULINO', EDAD_DECLARADA >= 65) %>% dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD_DECLARADA, UUID) %>% dplyr::arrange(desc(EDAD_DECLARADA))
            return (tce11)
        } else {
        if (box == "12") {
            tce12<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'FEMENINO', EDAD_DECLARADA >= 65) %>% dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD_DECLARADA, UUID) %>% dplyr::arrange(desc(EDAD_DECLARADA))
            return (tce12)
        } else {
        if (box == "13") {
            tce13<- cfalle %>% dplyr::select(SEXO) %>% dplyr::group_by(SEXO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
            return (tce13)
        } else {
        if (box == "14") {
            tce14<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::select(DISTRITO) %>% dplyr::group_by(DISTRITO) %>% dplyr::summarise(Cantidad_Total = dplyr::n()) %>% dplyr::arrange(desc(Cantidad_Total))
            return (tce14)
        } else {
        if (box == "15") {
            tce15<- cfalle %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% dplyr::arrange(desc(Cantidad_Total))
            return (tce15)
        } else {
        if (box == "16") {
            tce16<- cfalle %>% dplyr::filter(EDAD_DECLARADA>65) %>% dplyr::select(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total_Mayores_65 = dplyr::n()) 
            return (tce16)
        } else {
        if (box == "17") {
            tce17<- cfalle %>% dplyr::filter(DEPARTAMENTO != 'LIMA') %>% dplyr::select(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Provincia = dplyr::n())
            return (tce17)
        } else {
        if (box == "18") {
            tce18 <- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::mutate(month = format(FECHA_FALLECIMIENTO, '%m')) %>% 
                dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
            return (tce18)
        } else {
        if (box == "19") {
            tce19 <- cfalle %>% dplyr::mutate(month = format(FECHA_FALLECIMIENTO, "%m")) %>% 
                dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
            return (tce19)
        } else {
        if (box == "20") {
            tce20<- cfalle %>% dplyr::filter(EDAD_DECLARADA <= 45) %>% dplyr::select(DEPARTAMENTO) %>% 
                dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% 
                dplyr::arrange(desc(Cantidad_Total))
            return (tce20)
        }
        }
        }
        }
        }
        }
        }
        }
        }
        }
        }
        }
        }
            
            
            
        }
        }
        }
            
        } 
            
            }
        } }
        
        }
    )
    
   
    
    
    
    
    output$queries <- renderText({
        "
        tce1<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'MASCULINO', EDAD >= 50) %>% dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD, UUID) %>% dplyr::arrange(EDAD)
        tce2<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'FEMENINO', EDAD >= 50) %>% dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD, UUID) %>% dplyr::arrange(EDAD)
        tce3<- cposi %>% dplyr::select(SEXO) %>% dplyr::group_by(SEXO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
        tce4<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::select(DISTRITO) %>% dplyr::group_by(DISTRITO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
        tce5<- cposi %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
        tce6<- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA') %>% dplyr::select(EDAD) %>% dplyr::group_by(EDAD) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
        tce7<- cposi %>% dplyr::select(METODODX) %>% dplyr::group_by(METODODX) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
        tce8 <- cposi %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::mutate(month = format(FECHA_RESULTADO, '%m')) %>% dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n()) 
        tce9 <- cposi %>% dplyr::mutate(month = format(FECHA_RESULTADO, '%m')) %>% dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
        tce10<- cposi %>% dplyr::filter(EDAD <= 45, EDAD >=19) %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% dplyr::arrange(desc(Cantidad_Total))
        tce11<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'MASCULINO', EDAD_DECLARADA >= 65) %>% dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD_DECLARADA, UUID) %>% dplyr::arrange(desc(EDAD_DECLARADA))
        tce12<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA', SEXO == 'FEMENINO', EDAD_DECLARADA >= 65) %>% dplyr::select(DEPARTAMENTO, DISTRITO, SEXO, EDAD_DECLARADA, UUID) %>% dplyr::arrange(desc(EDAD_DECLARADA))
        tce13<- cfalle %>% dplyr::select(SEXO) %>% dplyr::group_by(SEXO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())
        tce14<- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::select(DISTRITO) %>% dplyr::group_by(DISTRITO) %>% dplyr::summarise(Cantidad_Total = dplyr::n()) %>% dplyr::arrange(desc(Cantidad_Total))
        tce15<- cfalle %>% dplyr::select(DEPARTAMENTO) %>% dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% dplyr::arrange(desc(Cantidad_Total))
        tce16<- cfalle %>% dplyr::filter(EDAD_DECLARADA>65) %>% dplyr::select(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total_Mayores_65 = dplyr::n()) 
        tce17<- cfalle %>% dplyr::filter(DEPARTAMENTO != 'LIMA') %>% dplyr::select(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Provincia = dplyr::n())
        tce18 <- cfalle %>% dplyr::filter(DEPARTAMENTO == 'LIMA', PROVINCIA == 'LIMA') %>% dplyr::mutate(month = format(FECHA_FALLECIMIENTO, '%m')) %>% 
            dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
        tce19 <- cfalle %>% dplyr::mutate(month = format(FECHA_FALLECIMIENTO, '%m')) %>% 
            dplyr::group_by(month)  %>% dplyr::summarise(Cantidad = dplyr::n())
        tce20<- cfalle %>% dplyr::filter(EDAD_DECLARADA <= 45) %>% dplyr::select(DEPARTAMENTO) %>% 
            dplyr::group_by(DEPARTAMENTO) %>% dplyr::summarise(Cantidad_Total = dplyr::n())  %>% 
            dplyr::arrange(desc(Cantidad_Total))
        "
    })
    
    
    
    
    
}
# Run the application 
shinyApp(ui = ui, server = server)