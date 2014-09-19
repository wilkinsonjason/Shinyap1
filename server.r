library(shiny)
data(HairEyeColor)

shinyServer(
    function(input,output){
        eyepredictdf <- reactive({
            #Creates filtered data frame for later plotting and finding max
            if(input$sexchoice == "Male") newdf <- HairEyeColor[, , 1]
            if(input$sexchoice == "Female") newdf <- HairEyeColor[, , 2]
            X <- input$hcol  
            newdf <- t(newdf)
            newdf2 <- newdf[,eval(X)]
            newdf2 <- newdf2/ sum(newdf2)
            newdf2 <- round(newdf2, digits = 2)
            newdf2
            
        })
    
        maxeye <- reactive({max(eyepredictdf())})

        namemax <- reactive({names(eyepredictdf())[which(eyepredictdf() == maxeye())]})
    
        output$oid1 <- renderText({input$hcol})
        output$oid2 <- renderText({input$sexchoice})
    
        output$predictionprob <- renderText({
            if(input$goButton == 0)
                return()
            isolate({
                maxeye()
            })
        })  
    
        output$predictionname <- renderText({
            if(input$goButton == 0)
                return()
            isolate({
                namemax()
            })
        })  
    
        output$haireyeplot <- renderPlot({
            if(input$goButton == 0)
                return()
            isolate({
                barplot(eyepredictdf(), col = c("brown", "cornflowerblue", "gold4", "yellowgreen"),
                    main = "Eye Color Probability")
                text(x= c(.75, 1.9, 3.1 , 4.25 ), y= .02, cex = 1.1, 
                    labels=as.character(eyepredictdf()[1:4]), col = "White")
            })
        })
    }    
)
