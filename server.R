# OYD: Tägliches Ziel - last update:2016-05-27
# Manifest for goal app ================================
'
encode with https://www.base64encode.org/
{
        "name":"Goal App",
        "identifier":"eu.ownyourdata.goal",
        "type":"external",
        "description":"track your daily goal (aka Thiels One Thing)",
        "permissions":["eu.ownyourdata.goal:read",
                       "eu.ownyourdata.goal:write",
                       "eu.ownyourdata.goal:update",
                       "eu.ownyourdata.goal:delete",
                       "eu.ownyourdata.scheduler:read",
                       "eu.ownyourdata.scheduler:write",
                       "eu.ownyourdata.scheduler:update",
                       "eu.ownyourdata.scheduler:delete",
                       "eu.ownyourdata.scheduler.email_config:read",
                       "eu.ownyourdata.scheduler.email_config:write",
                       "eu.ownyourdata.scheduler.email_config:update",
                       "eu.ownyourdata.scheduler.email_config:delete"]
}
ew0KICAgICAgICAibmFtZSI6IkdvYWwgQXBwIiwNCiAgICAgICAgImlkZW50aWZpZXIiOiJldS5vd255b3VyZGF0YS5nb2FsIiwNCiAgICAgICAgInR5cGUiOiJleHRlcm5hbCIsDQogICAgICAgICJkZXNjcmlwdGlvbiI6InRyYWNrIHlvdXIgZGFpbHkgZ29hbCAoYWthIFRoaWVscyBPbmUgVGhpbmcpIiwNCiAgICAgICAgInBlcm1pc3Npb25zIjpbImV1Lm93bnlvdXJkYXRhLmdvYWw6cmVhZCIsDQogICAgICAgICAgICAgICAgICAgICAgICJldS5vd255b3VyZGF0YS5nb2FsOndyaXRlIiwNCiAgICAgICAgICAgICAgICAgICAgICAgImV1Lm93bnlvdXJkYXRhLmdvYWw6dXBkYXRlIiwNCiAgICAgICAgICAgICAgICAgICAgICAgImV1Lm93bnlvdXJkYXRhLmdvYWw6ZGVsZXRlIiwNCiAgICAgICAgICAgICAgICAgICAgICAgImV1Lm93bnlvdXJkYXRhLnNjaGVkdWxlcjpyZWFkIiwNCiAgICAgICAgICAgICAgICAgICAgICAgImV1Lm93bnlvdXJkYXRhLnNjaGVkdWxlcjp3cml0ZSIsDQogICAgICAgICAgICAgICAgICAgICAgICJldS5vd255b3VyZGF0YS5zY2hlZHVsZXI6dXBkYXRlIiwNCiAgICAgICAgICAgICAgICAgICAgICAgImV1Lm93bnlvdXJkYXRhLnNjaGVkdWxlcjpkZWxldGUiLA0KICAgICAgICAgICAgICAgICAgICAgICAiZXUub3dueW91cmRhdGEuc2NoZWR1bGVyLmVtYWlsX2NvbmZpZzpyZWFkIiwNCiAgICAgICAgICAgICAgICAgICAgICAgImV1Lm93bnlvdXJkYXRhLnNjaGVkdWxlci5lbWFpbF9jb25maWc6d3JpdGUiLA0KICAgICAgICAgICAgICAgICAgICAgICAiZXUub3dueW91cmRhdGEuc2NoZWR1bGVyLmVtYWlsX2NvbmZpZzp1cGRhdGUiLA0KICAgICAgICAgICAgICAgICAgICAgICAiZXUub3dueW91cmRhdGEuc2NoZWR1bGVyLmVtYWlsX2NvbmZpZzpkZWxldGUiXQ0KfQ==
'

# Shiny Server ============================================
shinyServer(function(input, output, session) {
        output$upgradeLink <- renderText({
                renderUpgrade(session)
        })
        
        observe({
                if (input$localStore <= 0){
                        # On initialization, set the value of the text editor to the current val.
                        updateTextInput(session, "pia_url", value=isolate(input$store)$pia_url)
                        updateTextInput(session, "app_key", value=isolate(input$store)$app_key)
                        updateTextInput(session, "app_secret", value=isolate(input$store)$app_secret)
                        return()
                }
                updateStore(session, "pia_url", isolate(input$pia_url))
                updateStore(session, "app_key", isolate(input$app_key))
                updateStore(session, "app_secret", isolate(input$app_secret))
        })
        
# Survey specific functions ==============================
        currRepo <- reactive({
                url <- input$pia_url
                app_key <- input$app_key
                app_secret <- input$app_secret
                if(is.null(url) |
                   is.null(app_key) | 
                   is.null(app_secret)) {
                        vector()
                } else {
                        if((nchar(url) > 0) & 
                           (nchar(app_key) > 0) & 
                           (nchar(app_secret) > 0)) {
                                getRepo(url, app_key, app_secret)
                        } else {
                                url <- input$store$pia_url
                                app_key <- input$store$app_key
                                app_secret <- input$store$app_secret
                                if((nchar(url) > 0) & 
                                   (nchar(app_key) > 0) & 
                                   (nchar(app_secret) > 0)) {
                                        getRepo(url, app_key, app_secret)
                                } else {
                                        vector()
                                }
                        }
                }
        })

        currData <- function(){
                repo <- currRepo()
                if(length(repo) > 0) {
                        url <- itemsUrl(repo[['url']], 
                                        paste0(repo[['app_key']]))
                        piaData <- readItems(repo, url)
                } else {
                        piaData <- data.frame()
                }
                piaData
        }
        
        observe({
                switch(input$dateSelect,
                       '1'={ updateDateRangeInput(session, 'dateRange',
                                                  start = as.Date(Sys.Date()-7),
                                                  end = as.Date(Sys.Date())) },
                       '2'={ updateDateRangeInput(session, 'dateRange',
                                                  start = as.Date(Sys.Date() - months(1)),
                                                  end = as.Date(Sys.Date())) },
                       '3'={ updateDateRangeInput(session, 'dateRange',
                                                  start = as.Date(Sys.Date() - months(2)),
                                                  end = as.Date(Sys.Date())) },
                       '4'={ updateDateRangeInput(session, 'dateRange',
                                                  start = as.Date(Sys.Date() - months(6)),
                                                  end = as.Date(Sys.Date())) },
                       '5'={ updateDateRangeInput(session, 'dateRange',
                                                  start = as.Date(paste(year(Sys.Date()),'1','1',sep='-')),
                                                  end = as.Date(paste(year(Sys.Date()),'12','31',sep='-'))) },
                       '6'={ updateDateRangeInput(session, 'dateRange',
                                                  start = as.Date(Sys.Date() - months(12)),
                                                  end = as.Date(Sys.Date())) },
                       {})
        })
        
        saveData <- function(repo, date, value){
                if(!is.null(date) & length(all.equal(repo, logical(0)))>1){
                        piaData <- currData()
                        existData <- piaData[piaData$date == date, ]
                        data <- list(date=date, 
                                     value=value)
                        url <- itemsUrl(repo[['url']], 
                                        paste0(repo[['app_key']]))
                        if (nrow(existData) > 0) {
                                if(is.na(value) | is.null(value) | value == 'NA'){
                                        deleteRecord(repo, url, existData$id)
                                } else {
                                        updateRecord(repo, url, data, existData$id)
                                }
                        } else {
                                if(!is.na(value) & !is.null(value) & value != 'NA'){
                                        writeRecord(repo, url, data)
                                }
                        }
                }                
        }
        
# Survey specific output fields ==========================
        values = reactiveValues()
        setHot = function(x) values[["dataSheet"]] = x
        
        observe({
                if(!is.null(input$dataSheet))
                        values[["dataSheet"]] <- hot_to_r(input$dataSheet)
        })
        
        output$exportCSV <- downloadHandler(
                filename = paste0(appName, '.csv'),
                content = function(file) {
                        write.csv(values[["dataSheet"]], file)
                }
        )
        
        observe({
                newRecords <- values[["dataSheet"]]
                if (!is.null(newRecords)) {
                        oldRecords <- currData()
                        if(nrow(oldRecords)>0) {
                                oldRecords <- oldRecords[,c('date', 'value')]
                        } else {
                                oldRecords <- as.data.frame(matrix(NA, ncol=2, nrow=1))
                        }
                        colnames(oldRecords) <- c('Datum', 'Ziel')
                        oldRecords$Datum <- as.Date(oldRecords$Datum)
                        oldRecords$Ziel <- as.character(oldRecords$Ziel)

                        # check new and updated records
                        repo <- currRepo()
                        updatedRecords <- sqldf('SELECT * FROM newRecords EXCEPT SELECT * FROM oldRecords')
                        if(nrow(updatedRecords)>0){
                                for(i in 1:nrow(updatedRecords)){
                                        rec <- updatedRecords[i,]
                                        if(!is.na(rec[1])){
                                                if(!(is.na(rec$Datum) | (as.character(rec$Datum) == ''))) {
                                                        if(is.na(rec$Ziel)) {
                                                                saveData(repo,
                                                                         rec$Datum,
                                                                         NA)
                                                        } else {
                                                                saveData(repo, 
                                                                         rec$Datum,
                                                                         rec$Ziel)
                                                        }
                                                }
                                        }
                                }
                        }
                        
                        # check for deleted records
                        deletedRecords <- sqldf('SELECT * FROM oldRecords EXCEPT SELECT * FROM newRecords')
                        if(nrow(deletedRecords) > 0) {
                                for(i in 1:nrow(deletedRecords)){
                                        rec <- deletedRecords[i,]
                                        saveData(repo, rec$Datum, NA)
                                }
                        }
                }
        })
        
        output$dataSheet = renderRHandsontable({
                if (!is.null(input$dataSheet)) {
                        DF = hot_to_r(input$dataSheet)
                        DF <- DF[!is.na(DF$Datum),]
                        if(nrow(DF) == 0){
                                DF <- data.frame(
                                        Datum = as.Date(Sys.Date()),
                                        Ziel = '')
                        } else {
                                DF <- rbind(DF, c(NA, NA))       
                        }
                        colnames(DF) <- c('Datum', 'Ziel')
                } else {
                        DF <- currData()
                        if(nrow(DF)>0){
                                DF <- DF[,c('date', 'value')]
                                DF <- DF[!is.na(DF$date),]
                                DF <- rbind(DF, c(NA, NA))
                        } else {
                                DF <- data.frame(
                                        Datum = as.Date(Sys.Date()),
                                        Ziel = '')
                        }
                        colnames(DF) <- c('Datum', 'Ziel')
                        DF$Datum <- as.Date(DF$Datum)
                        DF$Ziel <- as.character(DF$Ziel)
                }
                setHot(DF)
                if(nrow(DF)>20) {
                        rhandsontable(DF, useTypes=TRUE, height=400) %>%
                                hot_table(highlightCol=TRUE, highlightRow=TRUE,
                                          allowRowEdit=TRUE)
                } else {
                        rhandsontable(DF, useTypes=TRUE) %>%
                                hot_table(highlightCol=TRUE, highlightRow=TRUE,
                                          allowRowEdit=TRUE)
                }
        })
        
        # from http://shiny.rstudio.com/gallery/word-cloud.html
        getTermMatrix <- function() {
                data <- currData()
                data$dat <- as.POSIXct(data$date, 
                                       format='%Y-%m-%d')
                dataMin <- min(data$dat, na.rm=TRUE)
                dataMax <- max(data$dat, na.rm=TRUE)
                curMin <- as.Date(input$dateRange[1], '%d.%m.%Y')
                curMax <- as.Date(input$dateRange[2], '%d.%m.%Y')
                daterange <- seq(curMin, curMax, 'days')
                data <- data[as.Date(data$dat) %in% daterange, ]
                
                text <- paste(data$value, collapse = " ")
                myCorpus = Corpus(VectorSource(text))
                myCorpus = tm_map(myCorpus, content_transformer(tolower))
                myCorpus = tm_map(myCorpus, removePunctuation)
                myCorpus = tm_map(myCorpus, removeNumbers)
                myCorpus = tm_map(myCorpus, removeWords,
                                  c(stopwords("SMART"), 
                                    stopwords("en"), 
                                    stopwords("german"), 
                                    "thy", "thou", "thee", "the", "and", "but"))
                myDTM = TermDocumentMatrix(myCorpus,
                                           control = list(minWordLength = 1))
                m = as.matrix(myDTM)
                sort(rowSums(m), decreasing = TRUE)
        }
        
        terms <- function(){
                        withProgress({
                                setProgress(message = "Processing corpus...")
                                getTermMatrix()
                        })
        }
        
        wordcloud_rep <- repeatable(wordcloud)
        
        plotData <- function(){
                if(first) {
                        if(grepl('.herokuapp.com', session$clientData$url_hostname)) {
                                internetAlert(session, 'https://www.ownyourdata.eu/apps/')
                        }
                        first <<- FALSE                  
                }
                closeAlert(session, 'noDataAlert')
                data <- currData()
                if(nrow(data) > 0) {
                        v <- terms()
                        wordcloud_rep(names(v), v, scale=c(4,0.5),
                                      max.words=input$maxWords,
                                      colors=brewer.pal(8, "Dark2"))
                } else {
                        createAlert(session, 'noData', 'noDataAlert', style='info', title='Keine Daten vorhanden',
                                    content='Erfasse Datensätze oder abonniere ein periodisches Email zur Datensammlung.', append=FALSE)
                }
        }

        output$plotCloud <- renderPlot({
                input$dataSheet
                input$refreshBtn
                input$dateRange
                plotData()
        })
        
        output$repititionStats <- renderText({
                "text"
        })
        
        output$current_token <- renderText({
                repo <- currRepo()
                if (length(repo) == 0) {
                        '<strong>Token:</strong> nicht verfügbar'
                } else {
                        paste0('<strong>Token:</strong><br><small>', 
                               repo[['token']], '</small>')
                }
        })
        
        output$curr_records <- renderText({
                data <- currData()
                paste('<strong>Datensätze:</strong>',
                      nrow(data))
        })

# Email reminders =========================================        
        getLocalEmailConfig <- reactive({
                validEmailConfig <- FALSE
                server <- input$mailer_address
                port <- input$mailer_port
                user <- input$mailer_user
                pwd <- input$mailer_password
                if((nchar(server) > 0) & 
                   (nchar(port) > 0) & 
                   (nchar(user) > 0) & 
                   (nchar(pwd) > 0)) {
                        validEmailConfig <- TRUE
                }
                c('valid'=validEmailConfig,
                  'server'=server,
                  'port'=port,
                  'user'=user,
                  'pwd'=pwd)
        })
        
        emailConfigStatus <- function(repo){
                localMailConfig <- getLocalEmailConfig()
                piaMailConfig <- getPiaEmailConfig(repo)
                if (localMailConfig[['valid']]) {
                        # is there already a config in PIA?
                        if (length(piaMailConfig) > 0) {
                                # is it different?
                                if((localMailConfig[['server']] == piaMailConfig[['server']]) &
                                   (localMailConfig[['port']] == piaMailConfig[['port']]) &
                                   (localMailConfig[['user']] == piaMailConfig[['user']]) &
                                   (localMailConfig[['pwd']] == piaMailConfig[['pwd']])) {
                                        'config in sync'
                                } else {
                                        updateEmailConfig(repo, 
                                                          localMailConfig, 
                                                          piaMailConfig[['id']])
                                        'config updated'
                                }
                        } else {
                                writeEmailConfig(repo, localMailConfig)
                                'config saved'
                        }
                } else {
                        # is there already a config in PIA?
                        if (length(piaMailConfig) > 0) {
                                setEmailConfig(session, piaMailConfig)
                                'config loaded' # Mailkonfiguration von PIA gelesen
                        } else {
                                'not configured' # keine Mailkonfiguration vorhanden
                        }
                }
        }
        
        emailReminderStatus <- reactive({
                repo <- currRepo()
                if(length(repo) > 0){
                        piaMailConfig <- getPiaEmailConfig(repo)
                        piaSchedulerEmail <- getPiaSchedulerEmail(repo)
                        piaEmail <- ''
                        piaEmailId <- NA
                        if (length(piaMailConfig) == 0) {
                                'no mail config'
                        } else {
                                if (length(piaSchedulerEmail) > 0) {
                                        piaEmail <- piaSchedulerEmail[['email']]
                                        piaEmailId <-  piaSchedulerEmail[['id']]
                                }
                                localEmail <- as.character(input$email)
                                if(validEmail(localEmail)) {
                                        if (localEmail == piaEmail) {
                                                'email in sync'
                                        } else {
                                                goal_fields <- list(
                                                        date='Date.now',
                                                        value='line_1'
                                                )
                                                goal_structure <- list(
                                                        repo=repo_app,
                                                        fields=goal_fields
                                                )
                                                response_structure <- list(
                                                        goal_structure
                                                )
                                                content <- 'Was ist dein heutiges Ziel?'
                                                timePattern <- '0 7 * * *'
                                                if (piaEmail == '') {
                                                        writeSchedulerEmail(
                                                                repo,
                                                                localEmail,
                                                                content,
                                                                timePattern,
                                                                response_structure)
                                                        'email saved'
                                                } else {
                                                        updateSchedulerEmail(
                                                                repo,
                                                                localEmail,
                                                                content,
                                                                timePattern,
                                                                response_structure,
                                                                piaEmailId)
                                                        'email updated'
                                                }
                                        }
                                } else {
                                        if (nchar(localEmail) == 0) {
                                                if (piaEmail == '') {
                                                        'missing email'
                                                } else {
                                                        setSchedulerEmail(session, piaEmail)
                                                        'email loaded'
                                                }
                                        } else {
                                                'invalid email'
                                        }
                                }
                        }
                } else {
                        'no Pia'
                }
                
        })
        
        output$mail_config <- renderText({
                repo <- currRepo()
                if(length(repo) > 0){
                        retVal <- emailConfigStatus(repo)
                        switch(retVal,
                               'config in sync' = 'Benachrichtigungen via Email sind eingerichtet',
                               'not configured' = 'Benachrichtigungen via Email sind noch nicht konfiguiert',
                               'config saved'   = 'Emailkonfiguration in PIA gespeichert',
                               'config updated' = 'Emailkonfiguration in PIA aktualisiert',
                               'config loaded'  = 'Emailkonfiguration aus PIA geladen')
                } else {
                        'keine Verbindung zu PIA'
                }
        })
        
        output$email_status <- renderText({
                retVal <- emailReminderStatus()
                paste('<strong>Status:</strong>',
                      switch(retVal,
                             'no Pia'         = 'keine Verbindung zu PIA',
                             'no mail config' = 'Emailkonfiguration noch nicht vorhanden',
                             'missing email'  = 'fehlende Emailadresse',
                             'invalid email'  = 'ungültige Emailadresse',
                             'email loaded'   = 'Emailadresse aus PIA geladen',
                             'email in sync'  = 'periodische Email-Benachrichtigungen werden versandt',
                             'email saved'    = 'Emailadresse in PIA gespeichert',
                             'email updated'  = 'Emailadresse in PIA aktualisiert'))
        })
        
})
