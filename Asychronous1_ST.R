library(shiny)
library(dplyr)

# -----------------------------
# POPULATION DATA (Sampling-2)
# -----------------------------
population <- data.frame(
  id = 1:20,
  value = c(45,38,52,41,48,43,55,39,47,42,
            50,44,46,40,53,37,49,41,51,36),
  subgroup = rep(paste("Group", 1:5), each = 4)
)

# -----------------------------
# UI
# -----------------------------
ui <- fluidPage(
  
  titlePanel("Sampling 2: Sample Size Determination & Experimental Design"),
  
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("n",
                  "Sample Size (n):",
                  min = 2, max = 10, value = 5),
      
      selectInput("grp",
                  "Select Subgroup:",
                  choices = c("All", unique(population$subgroup))),
      
      numericInput("bias",
                   "Sampling Bias:",
                   value = 0, min = 0),
      
      numericInput("cost",
                   "Cost per Observation:",
                   value = 50, min = 1),
      
      numericInput("time",
                   "Time per Observation (minutes):",
                   value = 5, min = 1)
    ),
    
    mainPanel(
      verbatimTextOutput("summary"),
      plotOutput("meanPlot"),
      plotOutput("designPlot"),
      tableOutput("allocationTable")
    )
  )
)

# -----------------------------
# SERVER
# -----------------------------
server <- function(input, output) {
  
  data_used <- reactive({
    if (input$grp == "All") {
      population
    } else {
      filter(population, subgroup == input$grp)
    }
  })
  
  results <- reactive({
    data <- data_used()
    
    true_mean <- mean(data$value)
    sample_vals <- sample(data$value, input$n, replace = FALSE)
    est_mean <- mean(sample_vals) + input$bias
    
    list(
      true_mean = true_mean,
      est_mean = est_mean,
      bias = est_mean - true_mean,
      total_cost = input$n * input$cost,
      total_time = input$n * input$time,
      data = data
    )
  })
  
  # -----------------------------
  # TEXT SUMMARY
  # -----------------------------
  output$summary <- renderText({
    r <- results()
    paste(
      "True Population Mean :", round(r$true_mean, 3), "\n",
      "Estimated Mean       :", round(r$est_mean, 3), "\n",
      "Sampling Bias        :", round(r$bias, 4), "\n",
      "Total Survey Cost    :", r$total_cost, "\n",
      "Total Survey Time    :", r$total_time, "minutes"
    )
  })
  
  # -----------------------------
  # MEAN DISTRIBUTION PLOT
  # -----------------------------
  output$meanPlot <- renderPlot({
    data <- results()$data
    hist(data$value,
         col = "lightblue",
         main = "Population Distribution",
         xlab = "Observed Values")
    abline(v = mean(data$value), col = "red", lwd = 2)
  })
  
  # -----------------------------
  # DESIGN OF EXPERIMENT PLOT
  # -----------------------------
  output$designPlot <- renderPlot({
    plot(results()$total_cost,
         results()$total_time,
         pch = 19,
         col = "blue",
         xlab = "Total Cost",
         ylab = "Total Time",
         main = "Experimental Design: Cost vs Time")
  })
  
  # -----------------------------
  # ALLOCATION TABLE
  # -----------------------------
  output$allocationTable <- renderTable({
    data.frame(
      Sample_Size = input$n,
      Cost_per_Observation = input$cost,
      Time_per_Observation = input$time,
      Total_Cost = results()$total_cost,
      Total_Time_Minutes = results()$total_time
    )
  })
}

# -----------------------------
# RUN APP
# -----------------------------
shinyApp(ui = ui, server = server)

