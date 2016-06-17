# install.packages(c('shiny', 'shinyBS', 'RCurl', 'jsonlite', 'dplyr'), repos='https://cran.rstudio.com/')

# Libraries ===============================================
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

# Source Files ============================================
source("oyd_helper.R")
source("oyd_extension.R")
source("appStatus.R")
source("appSource.R")
source("appStore.R")

# General Variables =======================================
first <- TRUE

# from  http://stackoverflow.com/questions/11381673/detecting-a-mobile-browser
mobileCheck <- "(/(android|bb\\d+|meego).+mobile|avantgo|bada\\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino|android|ipad|playbook|silk/i.test(navigator.userAgent||navigator.vendor||window.opera)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\\-|your|zeto|zte\\-/i.test((navigator.userAgent||navigator.vendor||window.opera).substr(0,4)))"
isMobile <- mobileCheck
isDesktop <- paste0("!", mobileCheck)
# isDesktop <- mobileCheck
# isMobile <- paste0("!", mobileCheck)

# App-specific Variables ==================================
appName <- 'goal'
appTitle <- 'tägliches Ziel'
appTitleStatus <- 'Zielstatus'
repo_app <- 'eu.ownyourdata.goal'

# App-specific Extensions =================================
defaultStatTabUI <- "
        tabPanel('Wort Wolke', plotOutput(outputId = 'plotCloud', height = '300px'))
"
defaultStatTabLogic <- "
        getTermMatrix <- function() {
                data <- currDataSelect()
                data$dat <- as.POSIXct(data$date, 
                        format='%Y-%m-%d')
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
        }

        terms <- function(){
                withProgress({
                        setProgress(message = 'Processing corpus...')
                        getTermMatrix()
                })
        }

        wordcloud_rep <- repeatable(wordcloud)

        plotData <- function(){
                data <- currDataSelect()
                if(nrow(data) > 0) {
                        v <- terms()
                        if(length(v) > 0){
                                save(data, v, file='tmpData.RData')
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

        output$plotCloud <- renderPlot({
                input$dataSheet
                input$dateRange
                plotData()
        })
"

# Extension handling ======================================
extItems <- readExtItems(repo_app)
if(nrow(extItems) > 0){
        statTabUiList <- extItems[extItems$type == 'status', 'name']
        statTabUI <- buildStatTabUI(
                defaultStatTabUI,
                extItems[extItems$type == 'status', c('name', 'ui')])
        statTabLogic <- paste(
                defaultStatTabLogic, 
                paste(extItems[extItems$type == 'status', 'logic']))
} else {
        statTabUiList <- vector()
        statTabUI <- buildStatTabUI(
                defaultStatTabUI,
                data.frame())
        statTabLogic <- defaultStatTabLogic
}
