tabAppStatusItemsExtUI <- function(){
        # eval(parse(text="tabPanel('Extension',
        #          textInput('extInput', 'Input:'),
        #            actionButton('extButton', 'Button'),
        #            htmlOutput('extOutput'))")),
        if(TRUE){
                eval(parse(text="
                        tabPanel('Extension',
                                textInput('extInput', 'Input:'),
                                actionButton('extButton', 'Button'),
                                htmlOutput('extOutput')),
                        tabPanel(icon('cog'),
                                p('config here'))
                "))
        } else {
                eval(parse(text="
                        tabPanel(icon('cog'),
                                p('config here'))
                "))
        }
}