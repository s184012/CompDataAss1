library(tidyverse)

df <- read_csv('case1Data.txt', na = "NaN")
df2 <- read_csv('case1Data_Xnew.txt', na = "NaN")
glimpse(df)

raw <- df |> 
  rename_with(function(x) sub(pattern = " ", replacement = "", x=x))

raw_new <- df2 |> 
  rename_with(function(x) sub(pattern = " ", replacement = "", x=x))

write_csv(raw, file = "raw.csv")
write_csv(raw_new, file = "raw_new.csv")
