library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

bf <- read.csv(file="BlackFriday.csv", header=TRUE, sep=",")

nr<-nrow(bf)

# Define UI for application that plots features of movies 
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions 
  sidebarLayout(
    
    # Inputs
    sidebarPanel(
      
      HTML(paste("Enter a value between 1 and", nr)),
      
      numericInput(inputId = "n",
                   label = "Sample size:",
                   value = 30,
                   min=1,
                   max=nr,
                   step = 1),
      
      # Select variable for y-axis
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("User ID"="User_ID",
                              "Product ID"="Product_ID",
                              "Gender"="Gender",
                              "Age"="Age",
                              "Occupation"="Occupation",
                              "City Category"="City_Category",
                              "Stay in Currnet City"="Stay_In_Current_City_Years",
                              "MaritalStatus"="Marital_Status",
                              "Product Category 1"="Product_Category_1",
                              "Product Category 2"="Product_Category_2",
                              "Product Category 3"="Product_Category_3",
                              "Purchase"="Purchase"), 
                  selected = "User_ID"),
      # Select variable for x-axis
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("User ID"="User_ID",
                              "Product ID"="Product_ID",
                              "Gender"="Gender",
                              "Age"="Age",
                              "Occupation"="Occupation",
                              "City Category"="City_Category",
                              "Stay in Currnet City"="Stay_In_Current_City_Years",
                              "MaritalStatus"="Marital_Status",
                              "Product Category 1"="Product_Category_1",
                              "Product Category 2"="Product_Category_2",
                              "Product Category 3"="Product_Category_3",
                              "Purchase"="Purchase"), 
                  selected = "Product_Category_1"),
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("User ID"="User_ID",
                              "Product ID"="Product_ID",
                              "Gender"="Gender",
                              "Age"="Age",
                              "Occupation"="Occupation",
                              "City Category"="City_Category",
                              "Stay in Currnet City"="Stay_In_Current_City_Years",
                              "MaritalStatus"="Marital_Status",
                              "Product Category 1"="Product_Category_1",
                              "Product Category 2"="Product_Category_2",
                              "Product Category 3"="Product_Category_3",
                              "Purchase"="Purchase"),  
                  selected = "Age"),
    
      sliderInput(inputId = "alpha", 
                  label = "Alpha:", 
                  min = 0, max = 1, 
                  value = 0.5)
  ),
    
    # Outputs
    mainPanel(
      plotOutput(outputId = "boxplot"),
      DT::dataTableOutput(outputId = "bftable")
    )
  )
)


# Define server function required to create the scatterplot
server <- function(input, output) {
  
  # Create scatterplot object the plotOutput function is expecting
  output$boxplot <- renderPlot({
    ggplot(data = bf, aes_string(x = input$x, y = input$y,fill=input$z)) +
      geom_boxplot(alpha = input$alpha)
  })


  # Create data table
  output$bftable <- DT::renderDataTable({
  req(input$n)
  bf_sample <- bf %>%
    sample_n(input$n) %>%
    select(User_ID:Purchase)
  DT::datatable(data = bf_sample, 
                options = list(pageLength = 10), 
                rownames = FALSE)
})
}


# Create a Shiny app object
shinyApp(ui = ui, server = server)