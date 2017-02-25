# layout for section "Source"
# last update: 2016-10-06

# source("uiSourceItemConfig.R")

appSource <- function(){
        fluidRow(
                column(12,
                       # uiOutput('desktopUiSourceItemsRender')
                       tabsetPanel(
                               type='tabs',
                               tabPanel('Email', br(),
                                        fluidRow(
                                                column(2,
                                                       img(src='email.png',width='100px')),
                                                column(10,
                                                       helpText('Wenn du hier deine Emailadresse eingibst, erhältst du jeden Tag eine Email mit der Frage nach deinem täglichen Ziel.'),
                                                       textInput('goalEmail', 'Emailadresse:'),
                                                       actionButton('saveGoalEmail', 'Speichern',
                                                                    icon('save')),
                                                       actionButton('cancelGoalEmail', 
                                                                    'Emailversand beenden',
                                                                    icon('trash')),
                                                       br(), br(), uiOutput('goalEmailStatus')
                                                )
                                        )
                               )
                       )
                )
        )
}

# constants for configurable Tabs
# defaultSrcTabsName <- c('SrcTab1', 'SrcTab2')
# 
# defaultSrcTabsUI <- c(
#         "
#         tabPanel('SrcTab1',
#                 textInput(inputId=ns('defaultSourceInput1'), 
#                         'Eingabe1:'),
#                 htmlOutput(outputId = ns('defaultSourceItem1'))
#         )
#         ",
#         "
#         tabPanel('SrcTab2',
#                 textInput(inputId=ns('defaultSourceInput2'), 
#                         'Eingabe2:'),
#                 htmlOutput(outputId = ns('defaultSourceItem2'))
#         )
#         "
# )
# 
# defaultSrcTabsLogic <- c(
#         "
#         output$defaultSourceItem1 <- renderUI({
#                 input$defaultSourceInput1
#         })
#         ",
#         "
#         output$defaultSourceItem2 <- renderUI({
#                 input$defaultSourceInput2
#         })
#         "
# )
