# last update: 2016-06-07

# Default Values ==========================================
# Sys.setenv('EXTAPP_URL' = 'http://127.0.0.1:8080')
# Sys.setenv('EXTAPP_ID' = 'eu.ownyourdata.extension')
# Sys.setenv('EXTAPP_SECRET' = '7Y34nnlyxCVF0y4skqg4')
extensionUrl <- Sys.getenv('EXTAPP_URL')
extensionId <- Sys.getenv('EXTAPP_ID')
extensionSecret <- Sys.getenv('EXTAPP_SECRET')

statTabUiHeader <- "tabsetPanel(type='tabs',"
statTabUiFooter <- ")"
statTabUiItemHeader <- "tabPanel('"
statTabUiItemInter <- "',"
statTabUiItemFooter <- ")"
statTabUiConfig <- "
        tabPanel(icon('cog'),
                 br(),
                fluidRow(
                        column(3,
                                selectInput('extStatusList', 
                                        'Vorhandene Darstellungen:',
                                        statTabUiList,
                                        multiple=TRUE, selectize=FALSE),
                                actionButton('delExtStatusList', 'Entfernen', icon('trash'))),
                        column(8,
                                selectInput('extStatusView',
                                        'Quelle:',
                                        c('SAM'='sam', 'Github'='github', 'Lokal'='local'),
                                        selectize=FALSE),
                                conditionalPanel(
                                        condition = 'input.extStatusView == \"sam\"',
                                        selectInput('extStatusListSam',
                                                'Auswahl:',
                                                c('Visual #1', 'Visual #2'),
                                                multiple=TRUE, selectize=FALSE),
                                        actionButton('addExtStatusItemSam', 'Hinzufügen', icon('plus'))),
                                conditionalPanel(
                                        condition = 'input.extStatusView == \"github\"',
                                        textInput('extStatusItemGithub',
                                                'Pfad:'),
                                        helpText('Im angegebenen Verzeichnis werden die Dateien oyd.json, sub_ui.R und sub_server.R ausgelesen.')),
                                conditionalPanel(
                                        condition = 'input.extStatusView == \"local\"',
                                        textInput('extStatusItemName',
                                                'Name:'),
                                        tags$label('Ansicht (ui.R):'),
                                        br(),
                                        tags$textarea(id='extStatusItemUi',
                                                rows=5, cols=80),
                                        br(),
                                        tags$label('Logik (server.R):'),
                                        br(),
                                        tags$textarea(id='extStatusItemLogic',
                                                rows=5, cols=80),
                                        br(),
                                        actionButton('addExtStatusItem', 'Hinzufügen', icon('plus')),
                                        actionButton('updateExtStatusItem', 'Aktualisieren', icon('edit'))
                                )
                        )
                )
        )
"

# Get Data ================================================
readExtItems <- function(repo_app){
        extRepo <- getRepo(extensionUrl, extensionId, extensionSecret)
        extUrl <- itemsUrl(extensionUrl, extensionId)
        extItems <- readItems(extRepo, extUrl)
        extItems[extItems$app == repo_app, ]
}

buildStatTabUI <- function(defaultStatTabUI, extStatTabUI){
        customStatTabUi <- ','
        if(nrow(extStatTabUI)>0) {
                customStatTabUi <- paste(
                        apply(
                                extStatTabUI,
                                1,
                                function(x)
                                        paste(
                                                statTabUiItemHeader,
                                                x['name'],
                                                statTabUiItemInter,
                                                x['ui'],
                                                statTabUiItemFooter)
                        ),
                        collapse = ', '
                )
                customStatTabUi <- paste(',', customStatTabUi, ',')
        }
        paste(
                statTabUiHeader,
                defaultStatTabUI,
                customStatTabUi,
                statTabUiConfig,
                statTabUiFooter
        )
}