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


# Datensatz kennenlernen:
## Welche Informationen haben wir?
View(table)
str(table)
glimpse(table)
names(table)
summary(table)

## Ist der Datensatz vollständig?
table %>%
  filter_all(any_vars(is.na(.)))

## Welche Anomalien gibt es?
## - 1956 gab keine Gewinnerpunktzahl und keinen Zweitplatzierten
## - 1969 gab es vier Gewinner und keinen Zweitplatzierten
## - 1991 gab es keinen Punktunterschied zwischen Erst- und Zweitplatzierten (Entscheidung durch Münzwurf)
table %>%
  group_by(Year) %>%
  filter(n() > 1)

## Was gibt es noch zu klären, bevor du mit der Analyse beginnst?
## - Ist die Datenquelle (Wikipedia) vertrauenswürdig
## - Sind die Daten vollständig und korrekt
## - Sind die Daten (untereinander) vergleichbar


# Daten analysieren
## Welche Länder haben am häufigsten gewonnen?
table %>%
  group_by(Winner) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

### ... oder noch einfacher
table %>%
  count(Winner, sort = TRUE)

## Welches Land war am häufigsten Zweiter (“runner-up”)?
table %>%
  group_by(`Runner-up`) %>%
  drop_na() %>%
  summarise(count = n()) %>%
  arrange(desc(count))

### ... oder noch einfacher
table %>%
  count(`Runner-up`, sort = TRUE) %>%
  drop_na()

## Lieder in welcher Sprache haben am häufigsten gewonnen?
table %>%
  group_by(Language) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

### ... oder noch einfacher
table %>%
  count(`Language`, sort = TRUE)

## Welches Land hat mit der höchsten Punktzahl gewonnen?
table %>%
  filter(!is.na(Points)) %>%
  arrange(desc(Points)) %>%
  filter(Points %in% range(Points))

### ... oder noch einfacher
table %>%
  arrange(desc(Points)) %>%
  slice(1)

### ... oder noch einfacher
table %>%
  filter(Points == max(table$Points, na.rm = TRUE))

### ... oder noch einfacher
table %>%
  top_n(1, Points)

## Was war der durchschnittliche Punkteabstand zum Zweitplatzierten?
table %>%
  filter(!is.na(`Runner-up`) & !is.na(Margin)) %>%
  summarise(mean = mean(Margin))

### ... oder noch einfacher
mean(table$Margin, na.rm = T)


# Warum sind alle Analysen der Punktzahl problematisch?
## - Das Bewertungssystem hat sich über die Jahre geändert und die Punktzahlen sind nicht vergleichbar


# Was könnte man noch analysieren?
## - Gibt es einen Heimvorteil?
## - Wie viele Gewinner singen in der Sprache ihres Heimatlands (Kategorisierung der Landessprache erforderlich)
## - Um was geht es in den Liedern (zusätzliche Daten erforderlich)
## - Gewinnen mehr Männer oder Frauen den Wettbewerb? Hast sich das im Lauf der Zeit verändert? (zusätzliche Daten erforderlich)
## - Gewinnen Einzelpersonen oder Gruppen den Wettbewerb? (zusätzliche Daten erforderlich)


# Du bist heute verantwortlicher Redakteur: Was ist hier die erzählenswerte Geschichte?
## - Bester Vorschlag: Launige Geschichte über den ewigen zweitplatzierten England. Wahrer Grund für den Brexit?
## - Eine schöne Statistiksammlung „Alles was Sie über den ESC wissen müssen“ geht im Zweifelsfall immer

## Wie würdest du die Geschichte (visuell?) aufbereiten
## - Hängt stark von der Geschichte ab: Einfache Balkendiagramme und vielleicht eine Karte?
