library(shiny)
library(plotly)

shinyUI(fluidPage(
  titlePanel("Credit Card Payoff Calculator"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        sliderInput("sldBalance", "Current Balance: $", 100, 10000, 5000, 10),
        sliderInput("sldInterest", "Interest Rate: %", 1, 29.99, 7.99, 0.01),
        selectInput("lstMinimum", "Minimum Payment:",
                    c("Interest + 1%", "Interest + 2%", "Interest + 3%", 
                      "Interest + 4%", "Interest + 5%", "Interest + 6%", 
                      "Interest + 7%", "Interest + 8%", "Interest + 9%")
                    ),
        selectInput("lstFixed", "Fixed Payment on Low Balance: $", 
                    c(25, 30, 35, 40, 45, 50)), 
        sliderInput("sldAdditional", "Additional Monthly Payment: $", 0, 1000, 25, 5), 
        submitButton("Calculate"), 

        tags$div(tags$br()), 
        tags$div(tags$b(tags$u("Instructions"))), 
        tags$div(tags$br()), 
        tags$div(tags$b("Current Balance: $"), "- Total owed to the credit card company."), 
        tags$div(tags$br()), 
        tags$div(tags$b("Interest Rate: %"), "- Current APR for your balance."), 
        tags$div(tags$br()), 
        tags$div(tags$b("Minimum Payment: $"), "- Interest accrued during the billing cycle plus a % of the remaining balance."), 
        tags$div(tags$br()), 
        tags$div(tags$b("Fixed Payment on Low Balance: $"), "- Fixed amount of payment when the monthly payment falls below this number."), 
        tags$div(tags$br()), 
        tags$div(tags$b("Additional Monthly Payment: $"), "- Amount to pay on top of the required monthly payment."), 
        tags$div(tags$br()), 
        tags$div("Change any input above and click 'Calculate'. You'll see the results change on the right side including payoff months, charts, and detailed payment breakdown."), 
        tags$div(tags$br()), 
        tags$div("The first chart shows the trend of monthly payments decreasing as we make payments."), 
        tags$div(tags$br()), 
        tags$div("The second charts plots the trend of total amounts paid toward principal & interest and the remaining balance."), 
        tags$div(tags$br()), 
        tags$div(tags$b(tags$u("Calculations"))), 
        tags$div("p = credit card balance"), 
        tags$div("i = annual interest rate"), 
        tags$div("m = fraction of pincipal included in minimum payment"), 
        tags$div("a = additional payment toward balance"), 
        tags$div(tags$br()), 
        tags$div("Monthly Payment = p*(i/12/100) + p*(m/100) + a")
    ),
    
    # Show results
    mainPanel(
        htmlOutput("ccText"), 
        plotlyOutput("ccPlot"), 
        dataTableOutput("dfBreakdown")
    )
  )
))
