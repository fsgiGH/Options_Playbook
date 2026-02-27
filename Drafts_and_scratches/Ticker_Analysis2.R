library(dplyr)

tickers <- read.csv2("./data/tickers.csv", header = TRUE, sep = ",", dec = ".")

tickers <- tickers |> 
  mutate(range = IV.max - IV.min) |> 
  mutate(avg = (IV.min + IV.max)/2)

vix <- tickers |> 
  filter(Ticker == "VIX")

vix_range <- vix$IV.max - vix$IV.min
vix_avg <- (vix$IV.min + vix$IV.max) / 2

low_iv_low_range <- tickers |> 
  filter(avg < vix_avg & range < vix_range)

low_iv_high_range <- tickers |> 
  filter(avg < vix_avg & range > vix_range)

high_iv_low_range <- tickers |> 
  filter(avg > vix_avg & range < vix_range)

high_iv_high_avg <- tickers |> 
  filter(avg > vix_avg & range > vix_range)

Avg_IV <- c("Avg. < VIX", "Avg. > VIX")

LowAvLowRange <- paste(low_iv_low_range$Ticker, collapse = "<br>")
LowAvHighRange <- paste(low_iv_high_range$Ticker, collapse = "<br>")
HighAvgLowRange <- paste(high_iv_low_range$Ticker, collapse = "<br>")
HighAvgHighRange <- paste(high_iv_high_avg$Ticker, collapse = "<br>")

LA <- c(LowAvLowRange, LowAvHighRange)
HA <- c(HighAvgLowRange, HighAvgHighRange)

df <- data.frame(Avg_IV, LA, HA)
colnames(df) <- c("", "Range < VIX", "Range > VIX")

df |> kable(excape = F)


