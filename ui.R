shinyUI(
   tagList(
        initStore("store", "oydStore"),
        tags$script('setInterval(avoidIdle, 5000);
                     function avoidIdle() {
                        var number = Math.random();
                        Shiny.onInputChange("myData", number);
                     };'),
        conditionalPanel(
                condition=(isDesktop),
                bsModal('initConfig', 'Assistent zur Konfiguration', 'launchDialog', size='large',
                        bsCollapse(id = "collapse", open = "Willkommen",
                                   bsCollapsePanel("Willkommen",
                                        "Dieser Assistent hilft dir dabei die App einzurichten. Klicke auf 'Weiter', um zum nächsten Schritt zu gelangen!",
                                        br(),br(),
                                        actionButton("p1next", "Weiter"),
                                        style = "primary"),
                                   bsCollapsePanel("PIA",
                                        "Trage hier die Verbindungdaten zu deiner PIA und den darin gespeicherten Daten ein. Du findest diese Informationen in der PIA im Menü 'Entitäten' unter 'Plugin'; gehe dort zur aktuellen App und klicke zum Anzeigen der Informationen auf 'Bearbeiten'.",
                                        br(),br(),
                                        textInput('modalPiaUrl', 'URL:'),
                                        textInput('modalPiaId', 'ID:'),
                                        textInput('modalPiaSecret', 'Secret:'),
                                        br(),
                                        actionButton('p2prev', 'Zurück'),
                                        actionButton('p2next', 'Speichern & Weiter'),
                                        style = "info"),
                                   bsCollapsePanel('Fertig', "Gratulation! Du hast alle notwendigen Einstellungen vorgenommen und kannst nun die App verwenden. Solltest du später eine Änderung vornehmen wollen, findest du alle Konfigurationsmöglichkeiten im Bereich 'Einstellungen'.",
                                        br(),br(),
                                        actionButton('p3prev', 'Zurück'),
                                        actionButton('p3close', 'Fertig'),
                                        style = "info")
                        )
                ),
                navbarPage(
                        uiOutput('hdrImageLink'),
                        id="page", collapsible=TRUE, inverse=FALSE,
                        windowTitle=paste0(appTitle, ' | OwnYourData'),
                        tabPanel(appTitle,
                                 fluidRow(
                                         column(1),
                                         column(10,
                                                tags$div(class='panel panel-default',
                                                         tags$div(class='panel-heading',
                                                                  tags$h3(class='panel-title pull-left', 'tägliches Ziel',
                                                                          style='font-size:200%'),
                                                                  tags$button(id='buttonStore', type='button',
                                                                              class='btn btn-default action-button pull-right',
                                                                              style='margin-left:5px',
                                                                              icon('table'), 'Gesammelte Daten'),
                                                                  tags$button(id='buttonSource', type='button',
                                                                              class='btn btn-default action-button pull-right',
                                                                              style='margin-left:5px',
                                                                              icon('cloud-download'), 'Datenquellen'),
                                                                  tags$button(id='buttonVisual', type='button',
                                                                              class='btn btn-default action-button pull-right',
                                                                              icon('line-chart'), 'Auswertungen'),
                                                                  tags$div(class='clearfix')

                                                         ),
                                                         tags$div(class='panel-body',
                                                                  conditionalPanel(
                                                                          condition = "output.displayVisual != ''",
                                                                          tabAppStatusUI()
                                                                  ),
                                                                  conditionalPanel(
                                                                          condition = "output.displaySource != ''",
                                                                          tabAppSourceUI()
                                                                  ),
                                                                  conditionalPanel(
                                                                          condition = "output.displayStore != ''",
                                                                          tabAppStoreUI()
                                                                  )
                                                         )
                                                )
                                         )
                                 )),
                        navbarMenu(icon('cog'),
                                 tabPanel(HTML(paste0("Version</a></li><li><a href=\"https://github.com/OwnYourData/app-",
                                                      appName,
                                                      "/blob/master/README.md\">Anleitung")),
                                          fluidRow(
                                                  column(1),
                                                  column(10,
                                                    sidebarLayout(
                                                            sidebarPanel(
                                                                    tags$script("$(window).load(function(){
                                                                                  if (localStorage['oydStore\\\\pia_url'] === undefined) {
                                                                                    $('#initConfig').modal('show');
                                                                                    $('button:contains(\"Close\")').html('Schließen');
                                                                                  }
                                                                                });"),
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
                                        column(5, style="margin:-14px 0 0 10px",
                                               a(href='https://www.ownyourdata.eu', img(src='oyd.jpg',width='65px')),
                                               div(htmlOutput('displayVisual'), style="color:white"),
                                               div(htmlOutput('displaySource'), style="color:white"),
                                               div(htmlOutput('displayStore'), style="color:white")),
                                        column(5,
                                               helpText(a(href='mailto:support@ownyourdata.eu', 'kontaktiere uns'), 'bei Fragen oder Anregungen',
                                                        style="float:right;margin-right:25px;"))
                                        )
                                )
                        )
                ),
        conditionalPanel(
                condition=(isMobile),
                navbarPage("Christoph's PIA", collapsible = TRUE,
                           tabPanel("Wortwolke",
                                    selectInput('dateSelect',
                                                label = 'Auswahl',
                                                choices = c('letzte Woche'='1',
                                                            'letztes Monat'='2',
                                                            'letzten 2 Monate'='3',
                                                            'letzten 6 Monate'='4',
                                                            'aktuelles Jahr'='5',
                                                            'letztes Jahr'='6',
                                                            'individuell'='7')),
                                    plotOutput(outputId = 'plotCloudMobile', height = '300px')),
                           tabPanel("PIA Einrichtung",
                                    h3('Authentifizierung'),
                                    textInput('pia_urlMobile', 'Adresse:'),
                                    textInput('app_keyMobile', 'Key:'),
                                    textInput('app_secretMobile', 'Secret:'),
                                    actionButton('localStoreMobile', 'Zugriffsinformationen speichern', icon('save')),
                                    hr(),
                                    htmlOutput('current_tokenMobile'),
                                    htmlOutput('current_recordsMobile')
                           )
                )        
        )
        )
)
