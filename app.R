library(shiny)
library(ggplot2)
bf <- read.csv(file="BlackFriday.csv", header=TRUE, sep=",")

# Define UI for application that plots features of movies 
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions 
  sidebarLayout(
    
    # Inputs
    sidebarPanel(
      
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
                  selected = "Age")
    ),
    
    # Outputs
    mainPanel(
      plotOutput(outputId = "boxplot")
    )
  )
)

# Define server function required to create the scatterplot
server <- function(input, output) {
  
  # Create scatterplot object the plotOutput function is expecting
  output$boxplot <- renderPlot({
    ggplot(data = bf, aes_string(x = input$x, y = input$y,fill=input$z)) +
      geom_boxplot()
  })
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)