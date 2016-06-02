library(shiny)
library(shinyStore) # https://github.com/trestletech/shinyStore

# Global variables can go here
n <- 200


# Define the UI
ui <- bootstrapPage(
        initStore("store", "oydStore"),
        numericInput('n', 'Number of obs', n),
        textInput("text", "Input:"),
        actionButton("save", "Save", icon("save")),
        plotOutput('plot'),
        
        # javascript code to send data to shiny server
        # https://ryouready.wordpress.com/2013/11/20/sending-data-from-client-to-server-and-back-using-shiny/
        tags$script('
                setInterval(avoidIdle, 5000);
                function avoidIdle() {
                        var number = Math.random();
                        Shiny.onInputChange("myData", number);
                };
        ')
        
)


# Define the server code
server <- function(input, output, session) {
        output$plot <- renderPlot({
                hist(runif(input$n))
        })
        
        observe({
                if (input$save <= 0){
                        # On initialization, set the value of the text editor to the current val.
                        updateTextInput(session, "text", value=isolate(input$store)$text)
                        return()
                }
                updateStore(session, "text", isolate(input$text))
        })
}

# Return a Shiny app object
shinyApp(ui = ui, server = server)