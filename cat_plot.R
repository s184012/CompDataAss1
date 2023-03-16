library(tidyverse)
library(GGally)
library(patchwork)
library(ggcorrplot)

imp_data <- read_csv("imputed_data.csv")
raw_data <- read_csv("raw.csv")
raw_new <- read_csv("raw_new.csv")

plot1 <- imp_data |> 
    select(starts_with('C')) |>
    pivot_longer(
        cols=everything(),
        names_to = 'Categories',
        values_to = 'value'
    ) |> 
    ggplot(aes(x=Categories, fill = value)) +
    geom_bar()

plot2 <- raw_data |> 
    select(starts_with('C')) |>
    pivot_longer(
        cols=everything(),
        names_to = 'Categories',
        values_to = 'value'
    ) |> 
    ggplot(aes(x=Categories, fill = value)) +
    geom_bar()

plot1 + plot2 + plot_layout(guides = 'collect')

# predictors <-
raw_new <- raw_new |> 
  mutate(
    data = 'new'
  )

raw_data |> 
  select(-y) |> 
  mutate(
    data = 'old'
  ) |> 
  rbind(raw_new) |> 
  colnames()



num_plot <- raw_data |> 
  select(starts_with('x')) |>
  pivot_longer(
    cols=everything(),
    names_to = 'Variable',
    values_to = 'value'
  ) |> 
  group_by(Variable) |> 
  summarise(
    nas = sum(is.na(value)),
    not_nas = sum(!is.na(value))
  ) |> 
  pivot_longer(
    cols=c(nas, not_nas),
    names_to = 'Category',
    values_to = 'Count'
  ) |> 
  ggplot(aes(x=Variable, y=Count, fill = Category)) +
  geom_col()

num_plot

cor = cor(imp_data)
cor.p <- cor_pmat(cor)
plt.figure(figsize=(16, 6))
heatmap = sns.heatmap(dataframe.corr(), vmin=-1, vmax=1, annot=True, cmap='BrBG')
heatmap.set_title('Correlation Heatmap', fontdict={'fontsize':18}, pad=12);
