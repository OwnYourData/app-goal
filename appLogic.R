# application specific logic
# last update: 2017-02-13

source('srvDateselect.R', local=TRUE)
source('srvEmail.R', local=TRUE)
source('srvScheduler.R', local=TRUE)
source('appEmail.R', local=TRUE)

# any record manipulations before storing a record
appData <- function(record){
        record
}

getRepoStruct <- function(repo){
        appStruct[[repo]]
}

repoData <- function(repo){
        data <- data.frame()
        app <- currApp()
        if(length(app) > 0){
                url <- itemsUrl(app[['url']],
                                repo)
                data <- readItems(app, url)
        }
        data
}

# anything that should run only once during startup
appStart <- function(){
        app <- currApp()
        if(length(app) > 0){
                schedulerEmail <- getPiaSchedulerEmail(app)
                if(length(schedulerEmail) == 0) {
                        setGoalEmailStatus('Status: derzeit sind tägliche Emails nicht eingerichtet')
                        updateTextInput(session, 'goalEmail', value='')
                } else {
                        updateTextInput(session, 'goalEmail', 
                                        value=schedulerEmail[['email']])
                        setGoalEmailStatus('Status: tägliche Emails werden an die angegebene Adresse versandt')
                }
        
                # write script to collect last 3 goals used by scheduler ------
                scriptRepoUrl <- itemsUrl(app[['url']], scriptRepo)
                scriptItems <- readItems(app, scriptRepoUrl)
                goalScript <- scriptItems[
                        scriptItems$name == 'last3goals', ]
                if(nrow(goalScript) > 1){
                        lapply(goalScript$id,
                               function(x) deleteItem(app, 
                                                      scriptRepoUrl,
                                                      as.character(x)))
                        goalScript <- data.frame()
                }
                scriptData <- list(name           = 'last3goals',
                                   script         = last3goalsSkript,
                                   '_oydRepoName' = 'Ziel-Skript')
                if(nrow(goalScript) == 0){
                        writeItem(app, scriptRepoUrl, scriptData)
                } else {
                        updateItem(app, scriptRepoUrl, scriptData,
                                   goalScript$id)
                }
        }
}

getTermMatrix <- function() {
        data <- currDataSelection()
        if(nrow(data) > 0){
                data$dat <- as.Date(data$date)
                dataMin <- min(data$dat, na.rm=TRUE)
                dataMax <- max(data$dat, na.rm=TRUE)
                curMin <- as.Date(input$dateRange[1], '%d.%m.%Y')
                curMax <- as.Date(input$dateRange[2], '%d.%m.%Y')
                daterange <- seq(curMin, curMax, 'days')
                data <- data[as.Date(data$dat) %in% daterange, ]
                
                text <- paste(data$value, collapse = ' ')
                myCorpus = Corpus(VectorSource(text))
                myCorpus = tm_map(myCorpus, content_transformer(tolower))
                myCorpus = tm_map(myCorpus, removePunctuation)
                myCorpus = tm_map(myCorpus, removeNumbers)
                myCorpus = tm_map(myCorpus, removeWords,
                                  c(stopwords('SMART'), 
                                    stopwords('en'), 
                                    stopwords('german'), 
                                    'thy', 'thou', 'thee', 'the', 'and', 'but'))
                myDTM = TermDocumentMatrix(myCorpus,
                                           control = list(minWordLength = 1))
                m = as.matrix(myDTM)
                sort(rowSums(m), decreasing = TRUE)
        } else {
                matrix()
        }
}

currDataSelection <- reactive({
        closeAlert(session, 'myDataStatus')
        data <- repoData(app_id)
        if(nrow(data) == 0) {
                createAlert(session, 'dataStatus', alertId = 'myDataStatus',
                            style = 'warning', append = FALSE,
                            title = 'Keine Daten im gewählten Zeitfenster',
                            content = 'Für das ausgewählte Zeitfenster sind keine Daten vorhanden.')
                data <- data.frame()
        } else {
                data$dat <- as.Date(data$date)
                dataMin <- min(data$dat, na.rm=TRUE)
                dataMax <- max(data$dat, na.rm=TRUE)
                curMin <- as.Date(input$dateRange[1], '%d.%m.%Y')
                curMax <- as.Date(input$dateRange[2], '%d.%m.%Y')
                daterange <- seq(curMin, curMax, 'days')
                data <- data[as.Date(data$dat) %in% daterange, ]
                if(nrow(data) == 0){
                        createAlert(session, 'dataStatus', alertId = 'myDataStatus',
                                    style = 'warning', append = FALSE,
                                    title = 'Keine Daten im gewählten Zeitfenster',
                                    content = 'Für das ausgewählte Zeitfenster sind keine Daten vorhanden.')
                }
        }
        data
})

wordcloud_rep <- repeatable(wordcloud)

output$tagCloud <- renderPlot({
        v <- getTermMatrix()
        if(length(v) > 1){
                wordcloud_rep(names(v), v,
                              scale=c(4,0.5),
                              min.freq = input$freq, 
                              max.words= input$max,
                              colors=brewer.pal(8, "Dark2"))
        }
})

output$goal_list <- DT::renderDataTable({
        data <- currDataSelection()
        if(nrow(data) > 0) {
                data$zeit <- as.Date(data$date)
                data <- data[, c('date', 'value')]
                colnames(data) <- c('Datum', 'Ziel')
                DT::datatable(data,
                              selection = 'none',
                              options = list(language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/German.json')))
        } else {
                data.frame()
        }
})
