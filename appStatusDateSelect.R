tabAppStatusDateSelectUI <- function(){
        fluidRow(
                column(4,
                       dateRangeInput('dateRange',
                                      language = 'de',
                                      separator = ' bis ',
                                      format = 'dd.mm.yyyy',
                                      label = 'Zeitfenster',
                                      start = Sys.Date() - 30, end = Sys.Date())
                ),
                column(4,
                       selectInput('dateSelect',
                                   label = 'Auswahl',
                                   choices = c('letzte Woche'='1',
                                               'letztes Monat'='2',
                                               'letzten 2 Monate'='3',
                                               'letzten 6 Monate'='4',
                                               'aktuelles Jahr'='5',
                                               'letztes Jahr'='6',
                                               'individuell'='7'))),
                column(4,
                       sliderInput("maxWords",
                                   "max. Anzahl Wörter:",
                                   min = 1,  max = 300,  value = 100))
        )
}
