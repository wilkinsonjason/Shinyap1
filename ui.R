library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Likely eye color given hair color and sex"),
    
    sidebarPanel(
        h5('Enter hair color and sex for related eye color prediction, and then hit Submit'),
        selectInput('hcol', 'Hair Color', c("Black", "Brown", "Red", "Blond")),
        selectInput('sexchoice','Sex', c('Male', 'Female')),
        actionButton("goButton" , "Submit")
    ),
  
    mainPanel(
        h4('Given that you chose'),
        verbatimTextOutput("oid1"),
        h4('and'),
        verbatimTextOutput("oid2"),
        h4('The most likely eye color(s) is:'),
        verbatimTextOutput("predictionname"),
        h4('with a probability of'),
        verbatimTextOutput("predictionprob"),
        plotOutput('haireyeplot')
    )
))  