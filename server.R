# server.R

library(shiny)
library(datasets)
library(ggplot2)
library(randomForest)
data(iris)

shinyServer(function(input, output) {
    
    # Summary and structure of iris data
    output$summary <- renderPrint({
        summary(iris)
    })
    
    output$str <- renderPrint({
        str(iris)
    })
    
    output$zhead <- renderPrint({
        head(iris)
    })
        
    #  Prediction model using Random Forests with variable Number of trees to grow (ntree=input$numTree)
    output$predict <- renderPrint({
        inData <- sample(2, nrow(iris),  replace = TRUE, prob=c(0.8, 0.2))
        irisRF <- randomForest(Species ~ ., ntree=input$numTree, data=iris[inData == 1,])
        print(irisRF)
        
    })
    
    # Error plot from Random Forests prediction model on iris data with variable number of trees input usingslider.
    output$errorPlot <- renderPlot({
        inData <- sample(2, nrow(iris),  replace = TRUE, prob=c(0.8, 0.2))
        irisRF <- randomForest(Species ~ ., ntree=input$numTree, data=iris[inData == 1,])
        layout(matrix(c(1,2),nrow=1), width=c(4,1)) 
        par(mar=c(5,5,5,0))
        plot(irisRF, main="Trees vs Error Plot")
        plot(c(0,1),type="n", axes=F, xlab="", ylab="")
        legend("topright", colnames(irisRF$err.rate),col=1:4,cex=1.5, lwd=1,  fill=1:4)
        
    })
     
    #  Reactive inputs :  plot header, title for Data Plot
    plotHeader <- reactive({
        paste("Plot :", input$feature_1, 'vs', input$feature_2)
    })
    
    output$caption <- renderText({
        plotHeader()
    })
    
    # Data Plot from the selected features of raido buttons inputs
    output$plot <- renderPlot({
        ggplot(iris, aes_string(x=input$feature_1,  y=input$feature_2)) +
            scale_color_manual(values = c("red", "green", "blue")) +
            geom_point(aes(color = Species, shape = Species), size=3)
    })
    
    # Plot each feature against another in one figure:
    output$subPlot <- renderPlot({
    pairs(iris[1:4], main = "Iris Data Subplots", pch = 21,
          bg = c("red", "green", "blue")[unclass(iris$Species)])
    })
       
})

