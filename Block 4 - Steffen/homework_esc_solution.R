# Pakete installieren und laden
## install.packages(c("rvest", "dplyr"))
library(rvest);
library(dplyr);


# Daten vorbereiten
## HTML-Code der Webseite laden: https://stekhn.de/esc/esc_winners.html
website <- read_html("https://stekhn.de/esc/esc_winners.html")

## Tabelle aus dem HTML-Code in ein Data-Frame oder Tibble umwandeln
table <- website %>%
  html_node("table") %>%
  html_table(fill = TRUE)

# Datensatz kennenlernen:
## Welche Informationen haben wir?
names(table)
glimpse(table)

## Ist der Datensatz vollständig?
table %>% filter(is.na(Points))

## Welche Anomalien gibt es?
table %>%
  group_by(Year) %>%
  filter(n() > 1)

hist.default(table$Points)

plot(table$Points, type = "l")

## Was gibt es noch zu klären, bevor du mit der Analyse beginnst?


# Daten analysieren
## Welche Länder haben am häufigsten gewonnen?
table %>%
  group_by(Winner) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

## Welches Land war am häufigsten Zweiter (“runner-up”)?
table %>%
  group_by(`Runner-up`) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

## Lieder in welcher Sprache haben am häufigsten gewonnen?
table %>%
  group_by(Language) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

## Welches Land hat mit der höchsten Punktzahl gewonnen?
table %>%
  filter(!is.na(Points)) %>%
  arrange(desc(Points)) %>%
  filter(Points %in% range(Points))

## ... oder noch einfacher
table %>%
  top_n(1, Points)

## Was war der durchschnittliche Punkteabstand zum Zweitplatzierten?
table %>%
  filter(!is.na(`Runner-up`) & !is.na(Margin)) %>%
  summarise(mean = mean(Margin))

## Warum sind alle Analysen der Punktzahl problematisch?

## Was könnte man noch analysieren?


# Du bist heute verantwortlicher Redakteuer:
## Was ist hier die erzählenswerte Geschichte?

## Wie würdest du die Geschichte (visuell?) aufbereiten

