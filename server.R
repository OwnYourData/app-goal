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
{
        "name":"Extensions",
        "identifier":"eu.ownyourdata.extension",
        "type":"external",
        "description":"OYD app extensions",
        "permissions":["eu.ownyourdata.extension:read",
                       "eu.ownyourdata.extension:write",
                       "eu.ownyourdata.extension:update",
                       "eu.ownyourdata.extension:delete"]
}
ew0KICAgICAgICAibmFtZSI6IkV4dGVuc2lvbnMiLA0KICAgICAgICAiaWRlbnRpZmllciI6ImV1Lm93bnlvdXJkYXRhLmV4dGVuc2lvbiIsDQogICAgICAgICJ0eXBlIjoiZXh0ZXJuYWwiLA0KICAgICAgICAiZGVzY3JpcHRpb24iOiJPWUQgYXBwIGV4dGVuc2lvbnMiLA0KICAgICAgICAicGVybWlzc2lvbnMiOlsiZXUub3dueW91cmRhdGEuZXh0ZW5zaW9uOnJlYWQiLA0KICAgICAgICAgICAgICAgICAgICAgICAiZXUub3dueW91cmRhdGEuZXh0ZW5zaW9uOndyaXRlIiwNCiAgICAgICAgICAgICAgICAgICAgICAgImV1Lm93bnlvdXJkYXRhLmV4dGVuc2lvbjp1cGRhdGUiLA0KICAgICAgICAgICAgICAgICAgICAgICAiZXUub3dueW91cmRhdGEuZXh0ZW5zaW9uOmRlbGV0ZSJdDQp9
'

# Shiny Server ============================================
shinyServer(function(input, output, session) {

        output$upgradeLink <- renderText({
                renderUpgrade(session)
        })
        
        output$hdrImageLink <- renderUI({
                tags$div(
                        tags$a(href=input$store$pia_url, 
                               tags$img(height="25px", 
                                        src="data:image/png;base64,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")),
                        tags$a(href=input$store$pia_url, "Christoph's PIA")
                )
        })
        
        observe({
                if(!is.null(input$localStore)){
                        if (input$localStore <= 0){
                                # On initialization, set the value to the current val
                                updateTextInput(session, "pia_url", value=isolate(input$store)$pia_url)
                                updateTextInput(session, "app_key", value=isolate(input$store)$app_key)
                                updateTextInput(session, "app_secret", value=isolate(input$store)$app_secret)
                                return()
                        }
                }
                updateStore(session, "pia_url", isolate(input$pia_url))
                updateStore(session, "app_key", isolate(input$app_key))
                updateStore(session, "app_secret", isolate(input$app_secret))
        })
        
        observeEvent(input$p1next, ({
                updateCollapse(session, 'collapse', 
                               open = 'PIA',
                               style = list(
                                       "Willkommen" = 'info',
                                       'PIA' = 'primary',
                                       'Fertig' = 'info'))
        }))
        observeEvent(input$p2prev, ({
                updateCollapse(session, 'collapse', 
                               open = 'Willkommen',
                               style = list(
                                       "Willkommen" = 'primary',
                                       'PIA' = 'info',
                                       'Fertig' = 'info'))
        }))
        observeEvent(input$p2next, ({
                updateStore(session, "pia_url", isolate(input$modalPiaUrl))
                updateStore(session, "app_key", isolate(input$modalPiaId))
                updateStore(session, "app_secret", isolate(input$modalPiaSecret))
                updateTextInput(session, "pia_url", value=isolate(input$modalPiaUrl))
                updateTextInput(session, "app_key", value=isolate(input$modalPiaId))
                updateTextInput(session, "app_secret", value=isolate(input$modalPiaSecret))
                updateCollapse(session, 'collapse', 
                               open = 'Fertig',
                               style = list(
                                       "Willkommen" = 'info',
                                       'PIA' = 'info',
                                       'Fertig' = 'primary'))
        }))
        observeEvent(input$p3prev, ({
                updateCollapse(session, 'collapse', 
                               open = 'PIA',
                               style = list(
                                       "Willkommen" = 'info',
                                       'PIA' = 'primary',
                                       'Fertig' = 'info'))
        }))
        observeEvent(input$p3close, ({
                toggleModal(session, 'initConfig', toggle = "toggle")
        }))
        
        observeEvent(input$buttonVisual, {
                output$displayVisual <- renderText('0')
                output$displaySource <- renderText('')
                output$displayStore <- renderText('')
        })
       
        observeEvent(input$buttonSource, {
                output$displayVisual <- renderText('')
                output$displaySource <- renderText('0')
                output$displayStore <- renderText('')
        })
        
        observeEvent(input$buttonStore, {
                output$displayVisual <- renderText('')
                output$displaySource <- renderText('')
                output$displayStore <- renderText('0')
        })
        
        output$displayVisual <- reactive({
                output$displayVisual <- renderText('0')
                output$displaySource <- renderText('')
                output$displayStore <- renderText('')
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
                                                vector()
                                        }
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
        
        currDataSelect <- function(){
                data <- currData()
                if(nrow(data) == 0) {
                        data.frame()
                } else {
                        data$dat <- as.POSIXct(data$date, 
                                               format='%Y-%m-%d')
                        dataMin <- min(data$dat, na.rm=TRUE)
                        dataMax <- max(data$dat, na.rm=TRUE)
                        curMin <- as.Date(input$dateRange[1], '%d.%m.%Y')
                        curMax <- as.Date(input$dateRange[2], '%d.%m.%Y')
                        daterange <- seq(curMin, curMax, 'days')
                        data[as.Date(data$dat) %in% daterange, ]
                }
        }
        
        observe({
                if(!is.null(input$dateSelect)){
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
                }
        })
        
        saveData <- function(repo, date, value){
                if(!is.null(date) & length(all.equal(repo, logical(0)))>1){
                        piaData <- currData()
                        existData <- piaData[piaData$date == date, ]
                        existData <- existData[complete.cases(existData), ]
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
                                if(!is.na(value) & !is.null(value) & value != 'NA' & nchar(as.character(value))>2){
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
        eval(parse(text = statTabLogic))
        # getTermMatrix <- function() {
        #         data <- currDataSelect()
        #         data$dat <- as.POSIXct(data$date, 
        #                                format='%Y-%m-%d')
        #         dataMin <- min(data$dat, na.rm=TRUE)
        #         dataMax <- max(data$dat, na.rm=TRUE)
        #         curMin <- as.Date(input$dateRange[1], '%d.%m.%Y')
        #         curMax <- as.Date(input$dateRange[2], '%d.%m.%Y')
        #         daterange <- seq(curMin, curMax, 'days')
        #         data <- data[as.Date(data$dat) %in% daterange, ]
        #         
        #         text <- paste(data$value, collapse = ' ')
        #         myCorpus = Corpus(VectorSource(text))
        #         myCorpus = tm_map(myCorpus, content_transformer(tolower))
        #         myCorpus = tm_map(myCorpus, removePunctuation)
        #         myCorpus = tm_map(myCorpus, removeNumbers)
        #         myCorpus = tm_map(myCorpus, removeWords,
        #                           c(stopwords('SMART'), 
        #                             stopwords('en'), 
        #                             stopwords('german'), 
        #                             'thy', 'thou', 'thee', 'the', 'and', 'but'))
        #         myDTM = TermDocumentMatrix(myCorpus,
        #                                    control = list(minWordLength = 1))
        #         m = as.matrix(myDTM)
        #         sort(rowSums(m), decreasing = TRUE)
        # }
        # 
        # terms <- function(){
        #         withProgress({
        #                 setProgress(message = 'Processing corpus...')
        #                 getTermMatrix()
        #         })
        # }
        # 
        # wordcloud_rep <- repeatable(wordcloud)
        # 
        # plotData <- function(){
        #         data <- currDataSelect()
        #         if(nrow(data) > 0) {
        #                 v <- terms()
        #                 save(v, file='tmpTerms.RData')
        #                 if(length(v) > 0){
        #                         wordcloud_rep(words=names(v), 
        #                                       freq=v, 
        #                                       scale=c(4,0.5),
        #                                       max.words=input$maxWords,
        #                                       colors=brewer.pal(8, 'Dark2'))
        #                 } else {
        #                         createAlert(session, 'noData', 'noDataAlert', style='info', title='Keine Daten vorhanden',
        #                                     content='Erfasse Datensätze oder abonniere ein periodisches Email zur Datensammlung.', append=FALSE)
        #                 }
        #         } else {
        #                 createAlert(session, 'noData', 'noDataAlert', style='info', title='Keine Daten vorhanden',
        #                             content='Erfasse Datensätze oder abonniere ein periodisches Email zur Datensammlung.', append=FALSE)
        #         }
        # }
        # 
        # output$plotCloud <- renderPlot({
        #         input$dataSheet
        #         input$dateRange
        #         plotData()
        # })
        #-----------------------------

        getTermMatrixMobile <- function() {
                data <- currData()
                data$dat <- as.POSIXct(data$date, 
                                       format='%Y-%m-%d')
                dataMin <- min(data$dat, na.rm=TRUE)
                dataMax <- max(data$dat, na.rm=TRUE)
                curMin <- as.Date(input$dateRange[1], '%d.%m.%Y')
                curMax <- as.Date(input$dateRange[2], '%d.%m.%Y')
                daterange <- seq(curMin, curMax, 'days')
                #data <- data[as.Date(data$dat) %in% daterange, ]
                
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
        }
        
        termsMobile <- function(){
                withProgress({
                        setProgress(message = 'Processing corpus...')
                        getTermMatrixMobile()
                })
        }
        
        plotDataMobile <- function(){
                data <- currData()
                if(nrow(data) > 0) {
                        v <- termsMobile()
                        if(length(v) > 0){
                                wordcloud_rep(names(v), v, scale=c(4,0.5), min.freq=1,
                                              max.words=input$maxWords,
                                              colors=brewer.pal(8, 'Dark2'))
                        } else {
                                createAlert(session, 'noData', 'noDataAlert', style='info', title='Keine Daten vorhanden',
                                            content='Erfasse Datensätze oder abonniere ein periodisches Email zur Datensammlung.', append=FALSE)
                        }
                } else {
                        createAlert(session, 'noData', 'noDataAlert', style='info', title='Keine Daten vorhanden',
                                    content='Erfasse Datensätze oder abonniere ein periodisches Email zur Datensammlung.', append=FALSE)
                }
        }
        
        
        output$plotCloudMobile <- renderPlot({
                input$dataSheet
                input$dateRangeMobile
                plotDataMobile()
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

# Extensions ==============================================
        observe({
                if(!is.null(input$addExtStatusItem)){
                        input$addExtStatusItem
                        extName <- ''
                        extUi <- ''
                        extLogic <- ''
                        isolate({
                                extName <- input$extStatusItemName
                                extUi <- input$extStatusItemUi
                                extLogic <- input$extStatusItemLogic })
                        if(!is.null(extName)){
                                if(extName != ''){
                                        extRepo <- getRepo(extensionUrl, extensionId, extensionSecret)
                                        extUrl <- itemsUrl(extensionUrl, extensionId)
                                        data <- list(app=repo_app, 
                                                     type='status',
                                                     name=extName,
                                                     ui=extUi,
                                                     logic=extLogic)
                                        writeRecord(extRepo, extUrl, data)
                                        extItems <- readExtItems(repo_app)
                                        if(nrow(extItems) > 0){
                                                statTabUiList <- extItems[extItems$type == 'status', 'name']
                                                statTabUI <<- buildStatTabUI(
                                                        defaultStatTabUI,
                                                        extItems[extItems$type == 'status', c('name', 'ui')])
                                                statTabLogic <<- paste(
                                                        defaultStatTabLogic, 
                                                        paste(extItems[extItems$type == 'status', 'logic']))
                                                
                                                output$statusItemsUI <- renderUI(
                                                        eval(parse(text = paste0(
                                                                "tagList(",
                                                                statTabUI,
                                                                ")"))))
                                                eval(parse(text = extLogic))
                                        }
                                        
                                }
                        }
                }
        })
        
        output$statusItemsUI <- renderUI(
                eval(parse(text = paste0(
                        "tagList(",
                        statTabUI,
                        ")")))
        )
})
