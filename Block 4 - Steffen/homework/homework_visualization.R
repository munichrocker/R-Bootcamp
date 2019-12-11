# Pakete installieren und laden
## install.packages("tidyverse")
library(tidyverse)


# Daten vorbereiten
## HTML-Code der Webseite laden: https://stekhn.de/esc/esc_winners.html
website <- read_html("https://stekhn.de/esc/esc_winners.html")

## Tabelle aus dem HTML-Code in ein Data-Frame oder Tibble umwandeln
table <- website %>%
  html_node("table") %>%
  html_table(fill = TRUE, header = TRUE) %>%
  na_if("")

## Welche Anomalien gibt es?
hist.default(table$Points)

plot(table$Points, type = "s")

# Daten analysieren
## Welche Länder haben am häufigsten gewonnen?
winners <- table %>%
  count(Winner, sort = TRUE)

barplot(
  winners$n,
  names.arg = winners$Winner,
  las = 2,
  ylab = "Erstplatzierungen",
  main = "Welche Länder haben am häufigsten gewonnen?"
)

## Welches Land war am häufigsten Zweiter (“runner-up”)?
runner_ups <- table %>%
  count(`Runner-up`, sort = TRUE) %>%
  drop_na()

barplot(
  runner_ups$n,
  names.arg = runner_ups$`Runner-up`,
  las = 2,
  ylab = "Zweitplatzierungen",
  main = "Welches Land war am häufigsten Zweiter?"
)

## Lieder in welcher Sprache haben am häufigsten gewonnen?
languages <- table %>%
  count(`Language`, sort = TRUE)

barplot(
  languages$n,
  names.arg = languages$`Language`,
  las = 2,
  ylab = "Anzahl",
  main = "Lieder in welcher Sprache haben am häufigsten gewonnen?"
)

## Welches Land hat mit der höchsten Punktzahl gewonnen?
highest_score <- table %>%
  arrange(desc(Points))

barplot(
  highest_score$Points,
  names.arg = highest_score$Winner,
  las = 2,
  ylab = "Punktzahl",
  main = "Welches Land hat mit der höchsten Punktzahl gewonnen?"
)

## Wie hat sich die Punktezahl entwickelt?
plot(
  table$Year,
  table$Points,
  type = "S",
  main = "Wie hat sich die Punktezahl entwickelt?"
)

## Plot speichern
# pdf("filename.pdf")
# plot()
# dev.off()
