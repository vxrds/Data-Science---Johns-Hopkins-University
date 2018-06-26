library(shiny)

# Define UI for word prediction model
shinyUI(fluidPage(title="", 
    titlePanel(HTML("<p style='width:100%;text-align:center;color:brown'><u>SwiftKey - Predict Word</u></p>"),
               windowTitle = "SwiftKey - Predict Word"), 
    fluidRow(
        tags$br(),
        column(3), 
        column(6, 
               tags$div(
                    style = "width:100%;text-align:center", 
                    h4("Start typing your text below"), 
                    tags$textarea(id = 'txtInput', placeholder = 'Type here', rows = 4, cols = 50), 
                    HTML('<script type="text/javascript">txtInput.focus();</script>'), 
                    tags$br(), 
                    #tags$button(id = "btn1", type = "button", style = "width:125px;height:35px"), 
                    #tags$button(id = "btn2", type = "button", style = "width:125px;height:35px"), 
                    #tags$button(id = "btn3", type = "button", style = "width:125px;height:35px"), 
                    HTML("<div id='buttons'>"), 
                    uiOutput("placeHolder1", inline = T), 
                    uiOutput("placeHolder2", inline = T), 
                    uiOutput("placeHolder3", inline = T), 
                    HTML("</div>"), 
                    ""
               ), 
               tags$br(), 
               tags$div(
                   style = "width:100%;text-align:center", 
                   HTML("<u>Test Cases</u><br/>(copy/paste one of the lines from below)<br/><br/>"), 
                   HTML("United States of <br/>"), 
                   HTML("Our first African American president Barack <br/>"), 
                   HTML("I'm too tired to watch a movie now. I might fall <br/>"), 
                   HTML("When you were in Holland you were like 1 inch away from me but you hadn't time to take a <br/>"), 
                   HTML("Who else is attending Washington real estate summit <br/>"), 
                   HTML("Ohhhhh #PointBreak is on tomorrow. Love that lm and haven't seen it in quite some <br/>"), 
                   HTML("Employees will begin to pay more for their health insurance when <br/>"), 
                   HTML("The court noted that we do not need to start over from <br/>"), 
                   HTML("Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my <br/>"), 
                   HTML("ND winter is too harsh during <br/>"), 
                   HTML("Nobody carries cash anymore, so limiting sales to those who have cash may eat away at your <br/>"), 
                   HTML("Every inch of you is perfect from the bottom to the <br/>"), 
                   HTML("You're the reason why I smile everyday. Can you follow me please? It would mean the <br/>")
               )
        ), 
        column(3)
    )
)
)
