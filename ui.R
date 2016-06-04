# Setup and config ========================================
saved_url <- '#'

# Shiny UI ================================================
shinyUI(
        navbarPage(
                uiOutput('hdrImageLink'),
                id="page", collapsible=TRUE, inverse=FALSE,
                windowTitle=paste0(appTitle, ' | OwnYourData'), 
                tabPanel(appTitleStatus,
                         tabAppStatusUI()),
                tabPanel('Datenquellen',
                         tabAppSourceUI()),
                tabPanel('Gespeicherte Daten',
                         tabAppStoreUI()),
                navbarMenu('Infos',
                         tabPanel(HTML(paste0("Version</a></li><li><a href=\"https://github.com/OwnYourData/app-",
                                              appName,
                                              "/blob/master/README.md\">Anleitung")),
                                  fluidRow(
                                          column(1),
                                          column(10,
                                            sidebarLayout(
                                                    sidebarPanel(
                                                            initStore("store", "oydStore"),
                                                            tags$script('setInterval(avoidIdle, 5000);
                                                                        function avoidIdle() {
                                                                        var number = Math.random();
                                                                        Shiny.onInputChange("myData", number);
                                                                        };'),
                                                            p('Support: ', 
                                                              a(href='mailto:support@ownyourdata.eu', 
                                                                'support@ownyourdata.eu')),
                                                            p('Bugtracking: ',
                                                              a(href=paste0('https://github.com/OwnYourData/app-',
                                                                            appName, 
                                                                            '/issues'),
                                                                "Github")),
                                                            hr(),
                                                            p('entwickelt von ',
                                                              a(href="https://www.ownyourdata.eu",
                                                                'https://OwnYourData.eu')),
                                                            p('MIT Lizenz, 2016')),
                                                    mainPanel(
                                                            h2('akutelle Version: 0.3.0'),
                                                            htmlOutput('upgradeLink'),
                                                            hr(),
                                                            h3('Versionsverlauf'),
                                                            p(strong('Version 0.3.0')),
                                                            p('erstes Release')))
                         )))),
                footer=div(
                        fluidRow(
                                column(1),
                                column(10, hr())),
                        fluidRow(
                                column(1),
                                column(5, style="margin-top:-20px",
                                       helpText('mit ', icon("heart", lib = "glyphicon"), ' von ', 
                                                a(href='https://www.ownyourdata.eu', 'OwnYourData.eu'))),
                                column(5, style="margin-top:-20px",
                                       helpText(a(href='mailto:support@ownyourdata.eu', 'kontaktiere uns'), 'bei Fragen oder Anregungen',
                                                style="float:right;"))
                        )
                )
))
