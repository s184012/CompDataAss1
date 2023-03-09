library(tidyverse)

df <- read_csv('case1Data.txt', na = "NaN")
glimpse(df)

raw <- df |> 
  rename_with(function(x) sub(pattern = " ", replacement = "", x=x)) |> 
  names()

write_csv(raw, file = "raw.csv")
