## Make Data for the Book

library(tidyverse)
library(gutenbergr)

wuthering_heights <- gutenberg_download(768, meta_fields = "title")

wuthering_heights <- wuthering_heights %>%
  slice(7:11) %>%
  mutate(id = paste0("0", 1:5)) %>%
  select(id, text)

wuthering_heights %>%
  pwalk(
    ~write_file(x = .y, path = paste0("./data/texts/", .x, ".txt"))
    )

## Read in
library(tidytext)

all_texts <- list.files("./data/texts", full.names = TRUE)

map_dfr(all_texts, ~{
  tibble(txt = read_file(.x),
         id = .x)
})

map_dfr(all_texts,
       ~ tibble(txt = read_file(.x)) %>%
         mutate(filename = basename(.x)) %>%
         unnest_tokens(word, txt))






write_file("hello", "./data/texts/test.txt")


wuthering_heights %>%
  mutate(text = str_replace_all(text, "", "\\n"))

pull(wuthering_heights, text) %>% 
  str_c(collapse = " ") %>%
  str_split(pattern = "\\.|\\?|\\!")


wuthering_heights %>%
  slice()