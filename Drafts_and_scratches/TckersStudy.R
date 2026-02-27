library(dplyr)
library(ggplot2)

tickers <- read.csv2("./data/tickers.csv", header = TRUE, sep = ",", dec = ".")

sorted_levels_low <- tickers  |> 
  filter(Ticker != "VIX")  |> 
  arrange(IV.min)  |> 
  pull(Ticker)

sorted_levels_low <- c("VIX", sorted_levels_low)

df_sorted_low <- tickers  |> 
  mutate(Ticker = factor(Ticker, levels = sorted_levels_low)) |> 
  select(c(Ticker, IV.min, IV.max))

names(df_sorted_low) <- c("Ticker", "IV_min", "IV_max")

df_sorted_low <- df_sorted_low |> mutate(clr = 1)
df_sorted_low$clr[1] <-2

p_main <- ggplot(df_sorted_low, aes(y = Ticker)) +
  geom_segment(aes(x = IV_min, xend = IV_max, yend = Ticker, colour = as.factor(clr)),
               linewidth = 1) + 
  scale_color_manual(values = c("steelblue", "darkorange")) +
  scale_y_discrete(limits = rev) +
  labs(
    title = "52-Week Implied Volatility Ranges (Sorted by IV Low)",
    x = "Implied Volatility (%)",
    y = ""
  ) +
  geom_vline(xintercept = df_sorted_low$IV_min[1]) +
  geom_vline(xintercept = df_sorted_low$IV_max[1]) +
  theme_minimal(base_size = 6) +
  theme (legend.position="none")
p_main
