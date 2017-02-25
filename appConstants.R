# global constants available to the app
# last update:2016-01-17

# constants required for every app
appName <- 'goal'
appTitle <- 'Tägliches Ziel'
app_id <- 'eu.ownyourdata.goal'

# definition of data structure
currRepoSelect <- ''
appRepos <- list(Vorlage = 'eu.ownyourdata.goal',
                 Verlauf = 'eu.ownyourdata.goal.log')
appStruct <- list(
        Vorlage = list(
                fields      = c('date', 'value'),
                fieldKey    = 'date',
                fieldTypes  = c('date', 'string'),
                fieldInits  = c('empty', 'empty'),
                fieldTitles = c('Datum', 'Ziel'),
                fieldWidths = c(150, 450)),
        Verlauf = list(
                fields      = c('date', 'description'),
                fieldKey    = 'date',
                fieldTypes  = c('date', 'string'),
                fieldInits  = c('empty', 'empty'),
                fieldTitles = c('Datum', 'Text'),
                fieldWidths = c(150, 450)))

# Version information
currVersion <- "0.3.0"
verHistory <- data.frame(rbind(
        c(version = "0.3.0",
          text    = "erstes Release")
))

# app specific constants
goalEmailText <- 'antworte auf dieses Mail und schreibe in die erste Zeile dein heutiges Ziel.'
