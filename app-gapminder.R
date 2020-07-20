library(purrr)
library(gapminder)

gapminder <- gapminder %>%
  filter(country %in% c("United States", "Canada", "Mexico"))

gapminder %>%
  nest(-country) %>%
  pwalk(~write_csv(x = .y, path = paste0("./data/gapminder/", .x, ".csv")))

## Read-in

files <- list.files("./data/gapminder", full.names = TRUE)

combined <- map_dfr(files, read_csv)

## Compelex

combined <- map_dfr(files, ~{
  read_csv(.x) %>%
    mutate(file = .x)
})

