## set working folder
setwd("Z:\\F\\Data Science\\Coursera\\RStudioWork\\C05\\W1")

## read data
dataPayment <- read.csv("./payments.csv")

## filter data
dataPayment <- dataPayment[dataPayment$Provider.State=="NY",]

# check data
# head(dataPayment)

#Make a plot that answers the question: what is the relationship 
#between mean covered charges (Average.Covered.Charges) and 
#mean total payments (Average.Total.Payments) in New York?

## regression model
model <- lm(formula = Average.Total.Payments ~ Average.Covered.Charges, data = dataPayment)

## plot 1
plot(x=dataPayment$Average.Covered.Charges, 
     y=dataPayment$Average.Total.Payments, 
     xlab = "Average Covered Charges ($)", 
     ylab = "Average Total Payments ($)", 
     main = "Realtionship of Covered Charges & Total Payments in NY"
)

## regression line
abline(reg = model, lwd = 2)

# export to PDF
dev.copy2pdf(file = "plot1.pdf", width=6, height=6)



## Plot2 panel
dataPayment <- read.csv("./payments.csv")
par(mfrow = c(6,6), oma = c(3,3,4,1), mar = rep(2,4), pin = c(0.93,0.7))

for (sState in levels(dataPayment$Provider.State))
{
    for (sDefinition in levels(dataPayment$DRG.Definition))
    {
        dl <- subset(dataPayment, DRG.Definition == sDefinition & Provider.State == sState)
        with(dl, 
             plot(
                 x=Average.Covered.Charges, xlab = "", 
                 y=Average.Total.Payments, ylab = "", 
                 pch = 20, xaxt='n', yaxt='n', cex = 0.5, 
                 main = paste0(sState, "(", substr(sDefinition, 1, 3), ")")
             )
        )
        abline(reg = lm(formula = Average.Total.Payments ~ Average.Covered.Charges, data = dl), lwd = 1, lty = 1)
        Corr <- with(dl, cor(Average.Covered.Charges, Average.Total.Payments))
        mtext(paste0("corr=", round(Corr,3)), side=4, line=0.5, cex=0.75)
    }
}
mtext("Mean Covered Charges", side = 1, outer = TRUE, line = 1)
mtext("Mean Total Payments", side = 2, outer = TRUE, line = 1)
mtext("Relationship between Mean Covered Charges and Mean Total Payments
      by State and Medical Condition", side = 3, outer = TRUE, font = 2, line = 1)

# export to PDF
dev.copy2pdf(file = "plot2.pdf", paper = "a4r", width = 0, height = 0)

# close device
dev.off()
