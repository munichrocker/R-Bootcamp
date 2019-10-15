#### Skript aufsetzen ####
setwd("")
library(tidyverse)

osten = c("Brandenburg", "Sachsen-Anhalt", "Sachsen", "Mecklenburg-Vorpommern", "Thüringen")
ew19 = read.csv("../recap/ew19.csv", fileEncoding = "utf-8", stringsAsFactors = F, sep = ";")
#Füge zu ew19 folgende Spalten hinzu:
# - "Gruene.anteil": Anteil Grünen-Wähler
# - "osten": Liegt der Wahlkreis im Osten oder im Westen?
# - "farbe": Je nach Osten oder Westen ein unterschiedlicher Farbname

#Erstelle einen Scatterplot: Anteil junge Menschen vs Anteil Grünen-Wähler*innen

#### Korrelation ####
#Korrelationskoeffizient: Wie stark ist der lineare Zusammenhang
# zwischen dem Anteil junge Menschen und dem Anteil Grünen-Wähler*innen?
?cor
# Was sagt uns das?


#### Regression ####

#Regression: Wie sieht der lineare Zusammenhang genau aus?
#Will heißen: Welche Gerade ("Trendlinie") beschreibt die Daten am besten?
?lm
#Erstelle ein lineares modell mit y = Gruene.anteil und x = junge
#und speichere es in der Variable "mod"
mod

#Hilfreiche Angaben zu dem Modell
summary(mod)

#Wichtig davon: Bestimmtheitsmaß
summary(mod)$r.squared
#ist gleich das Quadrat vom Korrelationskoeffizient

#Trendlinie einzeichnen
abline(mod, col = "orange")


#### Übung ####
#Scatterplot: Grüne-Anteil gegen Einkommen, mit Farbe nach Bundesland


#AUFGABE: Osten und Westen ##
#Erstelle einen gefilterten Datensatz mit nur den westlichen/östlichen Bundesländern

# Erstelle einen Scatterplot: Grüne-Anteil gegen Einkommen, nur für die westlichen/östlichen Bundesländer

# Berechne den Korrelationskoeffizienten für nur die westlichen/östlichen Bundesländer


# Zeichne die Regressionslinie für nur die westlichen Bundesländer ein

# Was ist das Bestimmtheitsmaß dieses Modells?


# FRAGE: Was für Schlüsse zieht ihr daraus für eine Datengeschichte?


#### Hypothesentests ####

#Hier im Kurs rauchen 2, 7 rauchen nicht
journalisten = c(rep(TRUE, 2), rep(FALSE, 7))

#T-Test machen
t = t.test(journalisten,      #Daten-Vektor
           alternative = "greater", #Wie sieht unsere H1 aus?
           mu = 0.3,          #Was ist der Mittelwert, falls H0 stimmt?
           conf.level = 0.95) #Was soll das Konfidenzintervall für den H1-Mittelwert sein?

#Ist der p-Wert kleiner als unser gewünschtes Signifikanzniveau von 0.05?

#Falls TRUE: H0 ablehnen, falls FALSE: H0 behalten