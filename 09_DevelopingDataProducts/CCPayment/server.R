library(shiny)
library(plotly)
library(scales)

shinyServer(function(input, output) {

    calcPayments <- reactive({
        nPrincipal <- as.numeric(input$sldBalance)
        nInterest <- as.numeric(input$sldInterest)
        sMinimum <- input$lstMinimum
        nFixed <- as.numeric(input$lstFixed)
        nAdditional <- as.numeric(input$sldAdditional)

        bDone <- FALSE
        nPayments <- 0
        nPrincipal2 <- 0.00
        nInterest2 <- 0.00
        nPrincipalPaid <- 0.00
        nInterestPaid <- 0.00
        nPrincipalRemaining <- nPrincipal
        aTable <- NULL
        nMinimum <- 1

        if (sMinimum == "Interest + 2%"){
            nMinimum <- 2
        } else if (sMinimum == "Interest + 3%"){
            nMinimum <- 3
        } else if (sMinimum == "Interest + 4%"){
            nMinimum <- 4
        } else if (sMinimum == "Interest + 5%"){
            nMinimum <- 5
        } else if (sMinimum == "Interest + 6%"){
            nMinimum <- 6
        } else if (sMinimum == "Interest + 7%"){
            nMinimum <- 7
        } else if (sMinimum == "Interest + 8%"){
            nMinimum <- 8
        } else if (sMinimum == "Interest + 9%"){
            nMinimum <- 9
        }
                
        while (bDone == FALSE)
        {
            nPrincipal2 <- round(nPrincipalRemaining * (nMinimum / 100), 2)
            nInterest2 <- round(nPrincipalRemaining * (nInterest / 100 / 12), 2)
            
            if ((nPrincipal2 + nAdditional) < nPrincipalRemaining)
            {
                nPrincipal2 <- nPrincipal2 + nAdditional
            }
            
            if ((nPrincipal2 + nInterest2) < nFixed)
            {
                if ((nPrincipal2 + nInterest2) < nPrincipalRemaining)
                {
                    if (nPrincipalRemaining > nFixed)
                    {
                        nPrincipal2 <- nFixed - nInterest2
                    }
                    else
                    {
                        nPrincipal2 <- nPrincipalRemaining
                    }
                }
            }
            
            nPayments <- round((nPayments + 1), 0)
            nPrincipalPaid <- nPrincipalPaid + nPrincipal2
            nInterestPaid <- nInterestPaid + nInterest2
            nPrincipalRemaining <- nPrincipalRemaining - nPrincipal2
            
            aTable <- rbind(aTable, c(nPayments, (nPrincipal2 + nInterest2), nPrincipal2, nInterest2, 
                                      nPrincipalPaid, nInterestPaid, nPrincipalRemaining))
            colnames(aTable) <- c("Month", "Payment", "Principal", "Interest", 
                                  "Principal.Paid", "Interest.Paid", "Remaining.Balance")
            
            if (nPrincipalRemaining < 0.01)
            {
                bDone = TRUE
            }
        }

        as.data.frame(aTable)
    })
    
    output$ccText <- renderText({
        dfPayments <- calcPayments()
        paste("<h3>It would take", nrow(dfPayments), "months to payoff the balance.</h3>")
    })
    
    output$ccPlot <- renderPlotly({
        dfPayments <- calcPayments()
        p1 <- plot_ly(dfPayments, x = dfPayments$Month) %>% 
            add_trace(y = dfPayments$Payment, name="Monthly Payment", mode = "lines", type = "scatter")
        
        p2 <- plot_ly(dfPayments, x = dfPayments$Month) %>% 
            add_trace(y = dfPayments$Principal.Paid, name="Principal Paid", mode = "lines", type = "scatter") %>% 
            add_trace(y = dfPayments$Interest.Paid, name="Interest Paid", mode = "lines", type = "scatter") %>% 
            add_trace(y = dfPayments$Remaining.Bal, name="Bal. Remaining", mode = "lines", type = "scatter")
        
        subplot(p1 %>% layout(showlegend = FALSE), p2) %>% 
            layout(xaxis = list(title = 'Month'), yaxis = list(title = 'Total $'))
    })
    
    output$dfBreakdown <- renderDataTable({
        dfPayments <- calcPayments()
        dfPayments$Payment <- dollar(dfPayments$Payment)
        dfPayments$Principal <- dollar(dfPayments$Principal)
        dfPayments$Interest <- dollar(dfPayments$Interest)
        dfPayments$Principal.Paid <- dollar(dfPayments$Principal.Paid)
        dfPayments$Interest.Paid <- dollar(dfPayments$Interest.Paid)
        dfPayments$Remaining.Balance <- dollar(dfPayments$Remaining.Balance)
        dfPayments
    })
})
