#### Skript aufsetzen ####
setwd("")
library(tidyverse)

osten = c("Brandenburg", "Sachsen-Anhalt", "Sachsen", "Mecklenburg-Vorpommern", "Thüringen")
ew19 = read.csv("../recap/ew19.csv", fileEncoding = "utf-8", stringsAsFactors = F, sep = ";") %>% 
    mutate(Gruene.anteil = Gruene / gueltige,
           osten = bundesland %in% osten,
           farbe = ifelse(osten, "orange", "blue"))

#plot: Anteil junge Menschen vs Anteil Grünen-Wähler*innen
plot(ew19$junge, ew19$Gruene.anteil)

#### Korrelation ####
#Korrelationskoeffizient: Wie stark ist der lineare Zusammenhang?
cor(ew19$junge, ew19$Gruene.anteil)
#0.65: Es gibt einen positiven linearen Zusammenhang, aber er ist nicht sonderlich stark
#will heißen: Die Daten könnten durch eine Linie beschrieben werden, aber die Punkte würden insgesamt doch deutlich davon abweichen 


#### Regression ####

#Regression: Wie sieht der lineare Zusammenhang genau aus?
#Will heißen: Welche Gerade ("Trendlinie") beschreibt die Daten am besten?
mod = lm(ew19$Gruene.anteil ~ ew19$junge)

#Hilfreiche Angaben zu dem Modell
summary(mod)

#Wichtig davon: Bestimmtheitsmaß
summary(mod)$r.squared
#ist gleich das Quadrat vom Korrelationskoeffizient

#Trendlinie einzeichnen
abline(mod, col = "orange")


#### Übung ####
#Scatterplot: Grüne-Anteil gegen Einkommen
plot(ew19$einkommen, ew19$Gruene.anteil, col = ew19$farbe)

#AUFGABE: Osten und Westen ##
#Erstelle einen gefilterten Datensatz mit nur den westlichen/östlichen Bundesländern
tmp = ew19 %>% filter(!osten)
# Erstelle einen Scatterplot: Grüne-Anteil gegen Einkommen, nur für die westlichen/östlichen Bundesländer
plot(tmp$einkommen, tmp$Gruene.anteil)
# Berechne den Korrelationskoeffizienten für nur die westlichen/östlichen Bundesländer
cor(tmp$einkommen, tmp$Gruene.anteil)

# Zeichne die Regressionslinie für nur die westlichen Bundesländer ein
mod = lm(tmp$Gruene.anteil ~ tmp$einkommen)
abline(mod, col = "orange")
# Was ist das Bestimmtheitsmaß dieses Modells?
summary(mod)$r.squared

# FRAGE: Was für Schlüsse zieht ihr daraus für eine Datengeschichte?


#### Hypothesentests ####

#Hier im Kurs rauchen 2, 7 rauchen nicht
journalisten = c(rep(TRUE, 2), rep(FALSE, 7))

#T-Test machen
t = t.test(journalisten,      #Daten-Vektor
           alternative = "greater", #Wie sieht unsere H1 aus?
           mu = 0.3,          #Was ist der Mittelwert, falls H0 stimmt?
           conf.level = 0.95) #Was soll das Konfidenzintervall für den H1-Mittelwert sein?

#Ist der p-Wert kleiner als unser gewünschtes Signifikanzniveau?
t$p.value <= 0.05
#Falls TRUE: H0 ablehnen, falls FALSE: H0 behalten