library(flextable)
library(openxlsx)

mytab <- read.xlsx("./data/Portfolio.xlsx",colNames = TRUE, fillMergedCells = TRUE)
ft1 <- flextable(mytab) |>
  width(width = c(2.5, 1, 1.2)) |> 
  merge_v(j = "Property") |>
  mk_par(j = 2, part = "header", value = as_paragraph(" ")) |>
  align(j = 3, align = "right", part = "all")
