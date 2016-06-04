tabAppStatusItemsUI <- function(){
        tabsetPanel(type='tabs',
                tabPanel('Wort Wolke', 
                         plotOutput(outputId = 'plotCloud', height = '300px'))
        )
}
