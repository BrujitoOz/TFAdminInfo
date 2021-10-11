# Data Science: Desplegar una plataforma de soporte a proyectos en ciencia de los datos
## Proyecto Casos de infectados positivos y fallecidos por covid-19
### Requisitos
- Escoger 2 datasets
- Montar 2 maquinas virtuales en AWS
- Recoleccion de datos
- Modelado de datos estructurados
- Transformacion y consultas exploratorias
- Preparación de datos
- Exploración visual de datos
- Modelado
- Exportación y comunicación


# Resultados

## Procedimiento
Para el proyecto se crearon dos máquinas virtuales para la base de datos y para utilizar el shiny. El shiny nos servirá para mostrar nuestro proyecto.

![d](https://user-images.githubusercontent.com/54952908/100210500-0f099800-2ed9-11eb-8fb0-f8fd97595deb.png)
Base de datos

![a](https://user-images.githubusercontent.com/54952908/100210344-e4b7da80-2ed8-11eb-9131-0e3770e763d8.png)
Shiny

El shiny mostrara nuestros queries:

![e](https://user-images.githubusercontent.com/54952908/100210556-2052a480-2ed9-11eb-8e95-23faffe549a1.png)
![b](https://user-images.githubusercontent.com/54952908/100210615-2f395700-2ed9-11eb-825f-f42f63b97517.png)

Se utilizaron un total de 20 queries para poder extraer toda la información posible y relevante de las datasets. Algunos ejemplos de los queries y sus respectivas graficas serían las siguientes:
### Cantidad de fallecidos en cada departamento
![c](https://user-images.githubusercontent.com/54952908/100210650-38c2bf00-2ed9-11eb-9685-9a42279be5e5.png)

### Cantidad de contagiados por mes en Lima
![f](https://user-images.githubusercontent.com/54952908/100210718-4c6e2580-2ed9-11eb-9a22-eb3ca4e5c06c.png)

### Cantidad de contagios por distrito en lima
![g](https://user-images.githubusercontent.com/54952908/100210740-54c66080-2ed9-11eb-81b4-496396117f33.png)

#### Otro detalle importante es que Lima cuenta con 1/3 de la población del país, por lo que compararlo en una misma grafica con otros departamentos podría no mostrar del todo el impacto que los departamentos también recibieron. 
Por ese motivo este query también es muy importante:

-	Cantidad de fallecidos Hombres por departamento Excepto Lima

![h](https://user-images.githubusercontent.com/54952908/100210776-5e4fc880-2ed9-11eb-9719-cfb9de520408.png)

Diagramas de cajas también fueron incluidos como este:
	Un gráfico de cajas de los fallecidos de acuerdo a su edad

![i](https://user-images.githubusercontent.com/54952908/100210964-8fc89400-2ed9-11eb-86d5-9f7956005261.png)

Finalmente para la parte de Modelo se utilizaro otro dataset. Los algoritmos implementados fueron:

### KNN con librería class:
![j](https://user-images.githubusercontent.com/54952908/100210997-9951fc00-2ed9-11eb-94bf-c8c2598a29d8.png)


En la izqueirda aparecen los datos predichos y a la derecha los datos reales. La opción de “Garantia danos propios contratada” predijo correctamente 31 datos pero luego se equivocó en predecir los datos de “No contratada”. Esto se puede deber a modificaciones del dataset como remover tildes. Sin embargo, en “No contratada” predijo correctamente 1803 y solo tuvo errores con 122. 

### K-means:
![k](https://user-images.githubusercontent.com/54952908/100211028-a242cd80-2ed9-11eb-922c-b015598d74a8.png)

#### El cluster verde indica personas que son fieles a la compania y cuentan con cierta experiencia como conductores.

#### En el kmean tambien se muestra esto con el aggregate.
![z](https://user-images.githubusercontent.com/54952908/100211065-aa9b0880-2ed9-11eb-8a56-4a18b5ab7dd8.png)


La tasa más alta de siniestros en la 2 de personas corresponde a gente que lleva una media de 3 años en la compañía, 21 años de permiso, 49 años de edad y con vehículos de 3 años de antigüedad.
Ósea que los vehículos más nuevos, con las personas mayores representan el mayor índice de siniestralidad.

## Conclusiones
Como conclusiones finales, podemos afirmar que el trabajo con datos requiere de habilidad de análisis, pues el desarrollo de consultas, modelos predictivos o clasificativos se eligen según lo requiera nuestro conjunto de datos, además la correcta interpretación y visualización de estos permiten mejor comprensión del problema, de modo que podemos tomar mejores decisiones.
