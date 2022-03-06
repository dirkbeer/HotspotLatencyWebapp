#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("plotHotspotLatencies.R")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Hotspot P2P Response Latency"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(position = "right",
        sidebarPanel(width=0),
        mainPanel(
           plotOutput("latencyPlot"),
           plotOutput("latencyPlot_hist"),
           width=12
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$latencyPlot <- renderPlot({
        plotHotspotLatencies()
    })

    output$latencyPlot_hist <- renderPlot({
        plotHotspotLatencies_hist()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
