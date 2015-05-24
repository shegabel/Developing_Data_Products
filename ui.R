# ui.R

shinyUI(pageWithSidebar(
    
    # Title
    headerPanel("Iris Data Exploration, Visualization and Random Forests"),
    
    # Main Panel : content display     
    mainPanel(
        tabsetPanel(
            
            tabPanel("Summary", 
                     h3("Summary of iris data"),
                     verbatimTextOutput("summary"),
                     h3("Structure of iris data"),
                     verbatimTextOutput("str"),
                     h3("First 6 rows iris data"),
                     verbatimTextOutput("zhead")
                     ),            
            
            tabPanel("Prediction", 
                     h3("Prediction : Use the slider on the right side"),
                     verbatimTextOutput("predict"),
                     h4("Notice as the Number of Trees change using the Slider on the right side, 
                        the error rate and the values under the Confusion matrix change.")
                     ),
            
            tabPanel("Error Plot", 
                     h3("Plot Errors"),
                     plotOutput("errorPlot"),
                     h4("Error Estimates of Species and the Out-Of-Bag (OOB) error."),
                     h4("Notice as the Number of Trees change using the Slider on the right side, 
                        the errors plots change on the graph.")
                     ),
                        
            tabPanel("Features Plot", 
                     h3(textOutput("caption")),
                     plotOutput("plot"),
                     h3(""),
                     h4("Select two features under 'Plots' from the radio buttons on the Right Side Panel to see their scatter plot.")
                     ),
            
            tabPanel("Sub Plots", 
                     plotOutput("subPlot"),
                     h3(""),
                     h4("All subplots of length and width features of iris data in one figure")
            ),
            
            tabPanel("About", 
                     h4("This shiny app explores the iris data using R. It uses the Random Forests prediction model 
                        to estimate the error rates as the number of tress change from 100 to 500 in step 50. After learning the iris data, 
                        it predicts the type of iris flower species (setosa, versicolor, and virginica) from the given features 
                        (Sepal.Length Sepal.Width Petal.Length Petal. Width Species). As the number of trees input changes using the slider, 
                        the error rates and the accuracy of the prediction change. The app also helps visualize the iris data and error rates 
                        from the prediction using ggplot2 package and R's plot function. Shiny's reactive expression is also used in features 
                        input/output using radio buttons as input widget to plot two selected iris features data."),
                        h4(""),
                        h4("Usage:"),
                        h4("1. Use the Slider from the right side to change number of trees and see the results under 'Prediction' and
                           'Error Plot' tabs on top."),
                        h4("2. Choose two features under 'Plots' from the radio buttons on the Right Side Panel and see their plot 
                           under 'Features Plot' on top."),
                        h4(""),
                        helpText(a("Source Codes at github",  target="_blank",   href="https://github.com/shegabel/Developing_Data_Products")),
                        helpText(a("Application page at shinyapps",  target="_blank",  href="https://shegabel.shinyapps.io/ddProductsProject/"))
                     
                     )
            )
        ),

    
    # Sidebar Panel : interactive widgets
    sidebarPanel(
        h2("Interactive Inputs"),
        h3("Prediction"),
        h5("Click the 'Prediction' tab on the Main-top left panel."),
        h5("Choose the number of Trees or click the play icon for animation on the slider below."),
        h5("As the number of trees change, notice the ouputs on the left under 'Prediction' or 'Error Plot'."),
        
        # Slider: Number of Trees inputs
        sliderInput("numTree", "Trees:",  min=100, max=500, value=150, step=50,
                    animate=animationOptions(interval=1000, loop=FALSE)),        
        
        h3("Plots"),
        h4("Features Plot : Select two features to Plot:"),
        
        # Raido Buttons: Features inputs
        radioButtons("feature_1", "Feature Set 1 on x-axis", 
                     c("Petal Length" = "Petal.Length",
                       "Petal Width"  = "Petal.Width",
                       "Sepal Length" = "Sepal.Length",
                       "Sepal Width"  = "Sepal.Width"),
                     selected="Sepal.Length"
                     ),
        
        radioButtons("feature_2", "Feature Set 2 on y-axis:",
                     c("Petal Length" = "Petal.Length",
                       "Petal Width"  = "Petal.Width",
                       "Sepal Length" = "Sepal.Length",
                       "Sepal Width"  = "Sepal.Width")
                     )
        )
    )
)