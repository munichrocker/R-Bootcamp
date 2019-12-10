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

## Was gibt es noch zu klären, bevor du mit der Analyse beginnst?


# Daten analysieren
## Welche Länder haben am häufigsten gewonnen?
winners <- table %>%
  group_by(Winner) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

barplot(
  winners$count,
  names.arg = winners$Winner,
  las = 2,
  ylab = "Erstplatzierungen",
  main = "Welche Länder haben am häufigsten gewonnen?"
)

## Welches Land war am häufigsten Zweiter (“runner-up”)?
runner_ups <- table %>%
  group_by(`Runner-up`) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

barplot(
  runner_ups$count,
  names.arg = runner_ups$`Runner-up`,
  las = 2,
  ylab = "Zweitplatzierungen",
  main = "Welches Land war am häufigsten Zweiter?"
)

## Lieder in welcher Sprache haben am häufigsten gewonnen?
languages <- table %>%
  group_by(Language) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

barplot(
  languages$count,
  names.arg = languages$`Language`,
  las = 2,
  ylab = "Anzahl",
  main = "Lieder in welcher Sprache haben am häufigsten gewonnen?"
)

## Welches Land hat mit der höchsten Punktzahl gewonnen?
highest_score <- table %>%
  filter(!is.na(Points)) %>%
  arrange(desc(Points))

barplot(
  highest_score$Points,
  names.arg = highest_score$Winner,
  las = 2,
  ylab = "Punktzahl",
  main = "Welches Land hat mit der höchsten Punktzahl gewonnen?"
)

## ... oder noch einfacher
table %>%
  top_n(1, Points)

## Was war der durchschnittliche Punkteabstand zum Zweitplatzierten?
table %>%
  filter(!is.na(`Runner-up`) & !is.na(Margin)) %>%
  summarise(mean = mean(Margin))

## Warum sind alle Analysen der Punktzahl problematisch?

## Was könnte man noch analysieren?

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

# Du bist heute verantwortlicher Redakteuer:
## Was ist hier die erzählenswerte Geschichte?

## Wie würdest du die Geschichte (visuell?) aufbereiten
