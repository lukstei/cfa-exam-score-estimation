library(shinydashboard)
library(ggplot2)

exams = list(
  "2016 Level I" = c(
  "Alternative Investments" = 10,
  "Corporate Finance" = 17,
  "Derivatives" = 12,
  "Economics" = 24,
  "Equity Investments" = 24,
  "Ethical & Professional Standards" = 36,
  "Financial Reporting & Analysis" = 48,
  "Fixed Income Investments" = 24,
  "Portfolio Management" = 17,
  "Quantitative Methods" = 28
),
"2016 Level II" = c(
  "Alternative Investments" = 18,
  "Corporate Finance" = 36,
  "Derivatives" = 36,
  "Economics" = 36,
  "Equity Investments" = 54,
  "Ethical & Professional Standards" = 36,
  "Financial Reporting & Analysis" = 72,
  "Fixed Income Investments" = 36,
  "Portfolio Management" = 18,
  "Quantitative Methods" = 18
))


server <- function(input, output) {
  output$radios <- renderUI({
    categories = exams[[input[['exam']]]]
    lapply(1:length(categories), function(i) radioButtons(paste0("cat-", i), names(categories[i]), selected = "3",
                                                                   c("<=50%" = "1", "51%-70%" = "2", ">70%" = "3"),
                                                                   inline = T)
    )
  })

  output$hist <- renderPlot({
    categories = exams[[input[['exam']]]]

    if(!is.null(input[[paste0('cat-1')]])) {
      samples = sapply(1:length(categories), function(i) {
        max = categories[i]
        cat = names(categories[i])
        selection = input[[paste0('cat-', i)]]


        bounds = switch(selection,
                        "1" = c(0, 0.5),
                        "2" = c(0.50001, 0.7),
                        "3" = c(0.70001, 1)) * max
        runif(10000, floor(bounds[1]), ceiling(bounds[2]))
      })

      points = apply(samples, 1, sum)

      output$range <- renderText(sprintf("The 90%% interval for your score is %.1f%% and %.1f%%.", quantile(points / sum(categories), 0.05) * 100, quantile(points / sum(categories), 0.95) * 100))

      ggplot(data.frame(f=points / sum(categories) * 100), aes(f)) +
        geom_histogram(aes(y = ..density..), bins = 10) +
        labs(x="Percentage", y=NULL)
    }
  })
}


ui <- dashboardPage(
  dashboardHeader(
    title = "CFA Exam Score Estimation"
  ),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    tags$head(HTML("<script type='text/javascript' src='js/hoge.js'></script>")),
    fluidRow(
      column(width = 7,
             box(width = NULL,
                 p(
                   class = "text-muted",
                   paste("Note: This app is not affiliated with CFA Institute.")
                 )
             ),
             box(width = NULL, solidHeader = TRUE,
                 plotOutput("hist", height = 500)
             ),
             verbatimTextOutput("range")
      ),
      column(width = 5,
             box(width = NULL, status = "warning",
                 selectizeInput(
                   'exam', 'Exam', choices = names(exams)
                 ),
                 uiOutput("radios")
             )
      )
    )
  )
)

shinyApp(ui = ui, server = server)