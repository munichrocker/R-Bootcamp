setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(tidyverse)

# theme_set(theme_bw())

data <- read_csv(
  "rechtsextreme_aufmaersche.csv",
  col_types = cols(
    .default = col_character(),
    Datum = col_date(format = "%d.%m.%Y"),
    Teilnehmer = col_integer()
  )
)
