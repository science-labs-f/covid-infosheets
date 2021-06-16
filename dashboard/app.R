#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Risico-baten van de SARS-Cov-2 tests"),

    # Sidebar with a slider input and output definitions
    sidebarLayout(
        
        #Sidebar panel for inputs
        sidebarPanel(
            h2("Instellingen"),
            # Input: Numeric entry for number of obs to view ----
            numericInput(inputId = "prevalence",
                         label = "Voorkomen van coronavirus per 1000 mensen:",
                         value = 5)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    
}

# Run the application 
shinyApp(ui = ui, server = server)
