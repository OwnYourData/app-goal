tabAppStatusSurveySelectUI <- function(){
        fluidRow(
                column(4,
                       selectInput('surveySelect',
                                   label = 'Umfrage',
                                   choices = c('default'='1'))),
                column(4,
                       numericInput('surveyResult', 'Ergebnis', 0)),
                column(1),
                column(3,
                       helpText('Daten neu laden:'),
                       actionButton("refreshBtn", "Aktualsieren"))
        )
}
