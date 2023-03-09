library(tidyverse)

df <- read_csv('case1Data.txt', na = "NaN")
glimpse(df)

df |> 
  rename_with(function(x) sub(pattern = " ", replacement = "", x=x)) |> 
  names()

write_csv(df, file = "raw.csv")
