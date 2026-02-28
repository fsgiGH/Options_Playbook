library(kableExtra)

data <- data.frame(
  Measure = c("IV Rank", "IV Percentile"),
  Formula = c("(current IV -- min IV) / (max IV -- min IV)", 
              "\\% days with IV < today"),
  Sensitivity = c("Extreme peaks", "Distribution"),
  Better.for = c("Identify absolute extremes", 
                 "Really understand whether today it is \"high\" or \"low\"")
)

tbl <- kable(data, 
      format = "latex", 
      booktabs = TRUE,
      linesep = "\\hline") %>%
  kable_styling(full_width = T, latex_options = c("hold_position"))

