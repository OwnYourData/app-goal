# Global variables can go here
n <- 200


# Define the UI
ui <- bootstrapPage(
        numericInput('n', 'Number of obs', n),
        htmlOutput('myRandom'),
        plotOutput('plot'),
        
        # javascript code to send data to shiny server
        tags$script('
                setInterval(avoidIdle, 5000);
                function avoidIdle() {
                        var number = Math.random();
                        Shiny.onInputChange("myData", number);
                };
        ')
        
)


# Define the server code
server <- function(input, output) {
        output$plot <- renderPlot({
                hist(runif(input$n))
        })
        
        output$myRandom <- renderText({
                input$myData;
        })
}

# Return a Shiny app object
shinyApp(ui = ui, server = server)