if (!("caTools" %in% rownames(installed.packages()))){
  install.packages("caTools")
}
if (!("lubridate" %in% rownames(installed.packages()))){
  install.packages("lubridate")
}
if (!("ggplot2" %in% rownames(installed.packages()))){
  install.packages("ggplot2")
}
if (!("dbplyr" %in% rownames(installed.packages()))){
  install.packages("dbplyr")
}
if (!("tidyr" %in% rownames(installed.packages()))){
  install.packages("tidyr")
}
if (!("shinyjs" %in% rownames(installed.packages()))){
  install.packages("shinyjs")
}
if (!("shiny" %in% rownames(installed.packages()))){
  install.packages("shiny")
}
if (!("readxl" %in% rownames(installed.packages()))){
  install.packages("readxl")
}
if (!("shinythemes" %in% rownames(installed.packages()))){
  install.packages("shinythemes")
}
if (!("plotly" %in% rownames(installed.packages()))){
  install.packages("plotly")
}
if (!("rJava" %in% rownames(installed.packages()))){
  install.packages("rJava")
}
if (!("mailR" %in% rownames(installed.packages()))){
  install.packages("mailR")
}
library(caTools)
library(lubridate)
library(ggplot2)
library(dbplyr)
library(tidyr)
library(shinyjs)#para la funcion toggle
library(shiny)
library(readxl)#para lectura de excel
library(shinythemes)
library(plotly)#para graficos dinamicos
library(class)
library(rJava)
library(mailR)