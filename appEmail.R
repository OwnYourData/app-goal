# application specific email handling
# last update: 2017-02-08

setGoalEmailStatus <- function(msg){
        output$goalEmailStatus <- renderUI(msg)
}

observeEvent(input$saveGoalEmail, {
        email <- input$goalEmail
        if(validEmail(email)){
                app <- currApp()
                schedulerEmail <- getPiaSchedulerEmail(app)
                goal_fields <- list(
                        date='Date.now',
                        value='line_1(String)'
                )
                goal_structure <- list(
                        repo              = app_id,
                        repoName          = 'Tägliches Ziel',
                        fields            = goal_fields)
                replace <- list(
                        pia_url = app[['url']],
                        app_key = app[['app_key']],
                        app_secret = app[['app_secret']])
                parameters <- list(
                        Rscript_reference = 'last3goals',
                        Rscript_repo      = scriptRepo,
                        replace           = replace)
                response_structure <- list(
                        goal_structure
                )
                if(length(schedulerEmail) == 0) {
                        writeSchedulerEmail(
                                app,
                                appTitle,
                                email,
                                'Dein heutiges Ziel',
                                goalEmailText,
                                '0 6 * * *',
                                response_structure,
                                parameters=parameters)
                        setGoalEmailStatus('der Versand täglicher Emails wurde erfolgreich eingerichtet')
                } else {
                        writeSchedulerEmail(
                                app,
                                appTitle,
                                email,
                                'Dein heutiges Ziel',
                                goalEmailText,
                                '0 6 * * *',
                                response_structure,
                                parameters=parameters,
                                id=schedulerEmail[['id']])
                        setGoalEmailStatus('die Emailadresse wurde erfolgreich aktualisiert')
                }
        } else {
                setGoalEmailStatus('Fehler: ungültige Emailadresse, die Eingabe wurde nicht gespeichert')
        }
})

observeEvent(input$cancelGoalEmail, {
        app <- currApp()
        if(length(app) > 0){
                schedulerEmail <- getPiaSchedulerEmail(app)
                if(length(schedulerEmail) == 0) {
                        setGoalEmailStatus('derzeit sind tägliche Emails nicht eingerichtet')
                        updateTextInput(session, 'goalEmail', value='')
                } else {
                        repo_url <- itemsUrl(app[['url']], schedulerKey)
                        deleteItem(app, repo_url, schedulerEmail[['id']])
                        updateTextInput(session, 'goalEmail', value='')
                        setGoalEmailStatus('der Versand täglicher Emails wurde beendet')
                }
        }
})
