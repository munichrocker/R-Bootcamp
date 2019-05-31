aufmaersche <- read.csv("rechtsextreme_aufmaersche.csv", stringsAsFactors = FALSE)

# *Fragen und Aufgaben für den Aufmärsche-Datensatz*
# 
# 1. Entfernt die Zeilen mit NAs in der TN.-Spalte.
aufmaersche <- na.omit(aufmaersche)

# 2. Wandelt die TN.-Spalte in Numeric um.
aufmaersche$TN. <- as.numeric(gsub(".", "", aufmaersche$TN., fixed = TRUE))

# 3. Bei welcher Demo gab es die meisten Teilnehmer?
aufmaersche[order(aufmaersche$TN., decreasing = TRUE),]
# -> Am besten mit View() zu sehen

# 4. Bei welcher die wenigsten?
aufmaersche[order(aufmaersche$TN., decreasing = FALSE),]

# 5. Wie viele Teilnehmer hatten Demos in Chemnitz?
sum(aufmaersche[aufmaersche$Ort == "Chemnitz", ]$TN.)

# 6. Entfernt die "\n" aus der Spalte Ort mit gsub() (Hinweis: funktioniert mit RegEx (nicht `fixed = TRUE`), für optionale Zeichen könnt ihr `(Zeichen)?`verwenden.)
aufmaersche$Ort <- gsub("(-)?\n", "", aufmaersche$Ort, fixed = T)
table(aufmaersche$Ort)

# 7. Verfahrt ebenso mit den Veranstaltern der Demos. Zählt mit table() die Veranstalter.
aufmaersche$Veranstalter <- gsub("(-)?\n", " ", aufmaersche$Veranstalter, fixed = F)
table(aufmaersche$Veranstalter)

# 8. Wie viele Demos gab es in Ost-, wie viele in Westdeutschland? (Hilfreiche Funktion: `aufmaersche$Ost_West <- ifelse(aufmaersche$Land %in% c("NW", "RP", "HH", "NI"), TRUE, FALSE)`)
aufmaersche$Ost_West <- ifelse(aufmaersche$Land %in% c("NW", "RP", "HH", "NI"), FALSE, TRUE)
table(aufmaersche$Ost_West)

# 9. Wie viele Teilnehmer hatten die Demos in Ost-, bzw. Westdeutschland in der Summe?
xtabs(TN. ~ Ost_West, aufmaersche)
# Oder: 
aggregate(TN. ~ Ost_West, aufmaersche, sum)

# 10. Wie viele Teilnehmer hatten alle Demos im Schnitt?
mean(aufmaersche$TN., na.rm = TRUE)
