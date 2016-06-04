# install.packages(c('shiny', 'shinyBS', 'RCurl', 'jsonlite', 'dplyr'), repos='https://cran.rstudio.com/')
library(shiny)
library(shinyBS)    # https://ebailey78.github.io/shinyBS/index.html
library(shinyStore) # https://github.com/trestletech/shinyStore
library(RCurl)
library(httr)
library(jsonlite)
library(dplyr)
library(lubridate)
library(rhandsontable) # https://github.com/jrowen/rhandsontable
library(sqldf)
library(tm)
library(wordcloud)

source("oyd_helpers.R")
source("appStatus.R")
source("appSource.R")
source("appStore.R")

first <- TRUE
appName <- 'goal'
appTitle <- 'tägliches Ziel'
appTitleStatus <- 'Zielstatus'
repo_app <- 'eu.ownyourdata.goal'


