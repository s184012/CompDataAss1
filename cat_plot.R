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
    data = 'case1Data_Xnew.txt'
  )

raw_data |> 
  select(-y) |> 
  mutate(
    data = 'case1Data.txt'
  ) |> 
  rbind(raw_new) |> 
  mutate(
    across(-data, ~ if_else(is.na(.x), "NA", "Not NA"))
  ) |> 
  pivot_longer(
    cols= -data,
    names_to = 'Variable',
    values_to = 'Category'
  ) |> 
  mutate(
    Variable = str_split_i(Variable, "_", i = 1)
  ) |> 
  group_by(data, Variable) |> 
  summarise(
    na_count = sum(Category == "NA") / n(),
    not_na_count = sum(Category == "Not NA") / n()
  ) |> 
  pivot_longer(
    cols = c(na_count, not_na_count),
    names_to = 'Category',
    values_to = 'Prop'
  ) |> 
  
  ggplot(aes(x=Variable, y=Prop, fill=Category)) +
  geom_col() +
  facet_wrap(vars(data)) |> 
  scale_y_continuous(labels = labe



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

summary(raw_data)


raw_data |> 
  pivot_longer(
    cols = starts_with('x'),
    names_to = 'Variables',
    values_to = 'Values'
  ) |> 
  mutate(
    Variables = 
    Variables = fct_reorder(Variables, )
  ) |> 
  ggplot(aes(x=Values, color=Variables)) +
  geom_boxplot()

raw_data |> 
  ggplot(aes(sample = y)) +
  geom_qq() +
  geom_qq_line()
