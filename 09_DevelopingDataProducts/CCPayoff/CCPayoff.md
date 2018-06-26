Credit Card Payoff Calculator Using Shiny
========================================================
author: Vijay Ramanujam
date: February 23, 2018
autosize: true

<style>
.small-code pre code {
  font-size: 1em;
}
</style>
Introduction
========================================================
Credit card issuers are required to collect payments that pays down a borrower's principal over a reasonable period of time. Most issuers charge 1% of the principal amount, plus the monthly interest, plus any fees. There are a lot of online calculators that give you fixed payment amount every month once you specify the number of months to payoff the debt.

This Shiny app calculator differs from the above by giving you the absolute minimum payment amount needed to avoid any penalty by the card issuer, and the number of months needed to payoff the balance by fulfilling the issuer's conditions. This will be handy for people that can't guarantee to pay a fixed amount for a fixed number of months.

Information Required
========================================================
The following information is needed for this app to function.

- <b>Current Balance: $ (p)</b> - Total owed to the credit card company
- <b>Interest Rate: % (i)</b> - Current APR for your balance
- <b>Minimum Payment: $</b> - Interest accrued during the billing cycle plus a % of the remaining balance
- <b>Fixed Payment on Low Balance: $ (m)</b> - Fixed amount of payment when the monthly payment falls below this number
- <b>Additional Monthly Payment: $ (a)</b> - Amount to pay on top of the required monthly payment

The formula to calculate the monthly minimum payment - <b>p*(i/12/100) + p*(m/100) + a</b>

Payoff Table
========================================================
class: small-code
<font size="5">
Some part of the code is hidden, since the monthly payment calculation logic is over 50 lines.
</font>


```r
nPrincipal <- 5000 #(p)
nInterest <- 7.99 #(i)
sMinimum <- 1 #(m)
nFixed <- 25
nAdditional <- 20 #(a)
aTable <- NULL
```


```r
head(as.data.frame(aTable))
```

```
  Month Payment Principal Interest Principal.Paid Interest.Paid
1     1  103.29     70.00    33.29          70.00         33.29
2     2  102.13     69.30    32.83         139.30         66.12
3     3  100.97     68.61    32.36         207.91         98.48
4     4   99.83     67.92    31.91         275.83        130.39
5     5   98.70     67.24    31.46         343.07        161.85
6     6   97.58     66.57    31.01         409.64        192.86
  Remaining.Balance
1           4930.00
2           4860.70
3           4792.09
4           4724.17
5           4656.93
6           4590.36
```
</span>

Shiny App Screenshot
========================================================
![Screenshot] (./CCPayoff-figure/CCPayoff.png)
<font size="5">
Shiny app hosted at <https://vxrds.shinyapps.io/CCPayoffCalculator>

All source code and supporting documentation located at <https://github.com/vxrds/vxrds.github.io/tree/master/JHU%20-%20Data%20Science/09_DevelopingDataProducts/Week4>
</font>
