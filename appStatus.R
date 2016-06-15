source("appStatusDateSelect.R")
source("appStatusSurveySelect.R")
source("appStatusItems.R")

tabAppStatusUI <- function(){
        fluidRow(
                column(12,
                       #h3('Anzeige'),
                       tabAppStatusDateSelectUI(),
                       bsAlert('noData'),
                       tabAppStatusItemsUI(),
                       bsAlert("noPIA"))
        )
}