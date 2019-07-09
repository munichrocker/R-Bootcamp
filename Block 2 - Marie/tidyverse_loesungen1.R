## Tidyverse Übungsblock 1
# Wenn nötig, installiere und lade die Pakete tidyverse und magrittr.
#install.packages("tidyverse", "magrittr")
library(tidyverse);library(magrittr)

# Lies den Datensatz "bestand_kraftstoffarten.csv" aus dem Daten-Ordner ein.
data <- read.csv("Daten/bestand_kraftstoffarten.csv", sep=";")
# Checke (zb über Klick auf den Datensatz im Environment-Window oder auf den Pfeil daneben) ob alles richtig eingelesen ist. 
# Bessere im Zweifel nach (Seperator richtig gesetzt, Encoding richtig, sind alle zahlen auch als Zshlen erkannt worden?).

#Füge dem Datensatz eine neue Spalte hinzu mit dem Bestand an umweltfreundlicheren Autos / Autos mit alternativen Antrieben.
data %<>% mutate(oeko = Hybrid.insgesamt + Elektro) # Hier beachten: sum() gibt dir die Gesamtsumme über alle Zeilen! Daher +.

# Speichere eine Kopie des Datensatzes ab und bringe ihn ins Tidy Data Format. Nutze dafür die tidyr-Funktion gather.
# Welche Spalten sind hier die Schlüsselspalten, die wir in eine neue Spalte überführen wollen?
tidy_data <- data %>% gather(key = Kraftstoff, value = Bestand, 3:9)

# Berechne den Anteil der jeweiligen Kraftstoffart am Gesamtbestand 
# je Zulassungsbezirk und füge sie dem Datensatz als neue Spalte hinzu.
tidy_data %<>% mutate(Bestand_rel = Bestand / Insgesamt)

# Erstelle eine Rangliste der am häufigsten vorkommenden Kraftstoffarten in Deutschland. Tipp: Dafür musst du
# den Datensatz erstmal auf die Bestandssumme je Kraftstoffart zusammenfassen.
tidy_data %>% group_by(Kraftstoff) %>% summarize(Bestand = sum(Bestand)) %>% arrange(desc(Bestand))

# Erstelle eine Rangliste der Zulassungsbezirke mit dem größten Öko-Auto-Anteil. 
# Tipp: Das Rezept ist filtern, gruppieren, sortieren, slicen
tidy_data %>% filter(Kraftstoff %in% "oeko") %>% group_by(Zulassungsbezirk) %>% arrange(desc(Bestand_rel)) 

# Erstelle eine Rangliste der Zulassungsbezirke mit dem größten Diesel-Auto-Anteil. 
tidy_data %>% filter(Kraftstoff %in% "Diesel") %>% group_by(Zulassungsbezirk) %>% arrange(desc(Bestand_rel)) 

# Berechne den Anteil der verschiedenen Kraftstoffarten am Gesamtbestand in Deutschland
tidy_data %>% group_by(Kraftstoff) %>% summarize(Anteil = sum(Bestand) / sum(Insgesamt)) %>% arrange(desc(Anteil))

# Wie viele Autos gibt es in Deutschalnd insgesamt?
tidy_data %>% summarize(sum(Insgesamt))

# Erstelle je Kraftstoffart eine Liste mit den Zulassungebezirken, in denen sie den größten und niedrigsten Anteil haben.
# Tipp: Du kannst beim filtern %in% benutzen und einen Vektor mit Werten, von denen einer zutreffen soll.
tidy_data %>% group_by(Kraftstoff) %>% filter(Bestand %in% c(max(Bestand), min(Bestand)))

# Challenge: Uns interessieren die Kraftstoffanteile je Bundesland. Dafür müssten wir irgendwie nach Bundesland gruppieren können.
# Die Nummer vor dem zulassungsbezirksnamen kann uns helfen: Die ersten beiden Zeichen geben uns die ID des Bundeslandes an.
# Thüringer Zulassungsbezirke beginnen mit einer 16, Zulassungsbezirke aus Bayern mit eine 09. 
# Sieh dir die Funktion ?substring an (oder google "r get first two characters of string") und erstelle eine neue ID-Spalte mit den 
# ersten beiden Ziffern des Zulassungsbezirks. Nach dieser kannst du dann gruppieren. 
# Bonus: Erstelle einen Lookup-Table und ersetze die ID durch den Bundesländernamen. Als Hilfe kannst dafür auch 
# nach "Bundesland ID" googlen.
# Und: weil's am Ende besser aussieht: Überführt euer Ergebnis wieder ins wide Format.
tidy_data %<>% mutate(ID = substring(Zulassungsbezirk, 1, 2))
tidy_data %>% group_by(ID, Kraftstoff) %>% summarize(Anteil = sum(Bestand) / sum(Insgesamt)) %>% spread(Kraftstoff, Anteil)

install.packages("qdapTools");library(qdapTools) # P.S.: Das geht auch anders, nutzt einfach die Methode, die ihr bei Bene gelernt habt.

lookup <- c("01" = "Schleswig-Holstein",
            "02" = "Hamburg",
            "03" = "Niedersachsen",
            "04" = "Bremen",
            "05" = "Nordrhein-Westfalen",
            "06" = "Hessen",
            "07" = "Rheinland-Pfalz",
            "08" = "Baden-Württemberg",
            "09" = "Bayern",
            "10" = "Saarland",
            "11" = "Berlin",
            "12" = "Brandenburg",
            "13" = "Mecklenburg-Vorpommern",
            "14" = "Sachsen",
            "15" = "Sachsen-Anhalt",
            "16" = "Thüringen")

tidy_data$Bundesland <- lookup(unlist(tidy_data$ID), key.match = data.frame(keyName=names(lookup), value=lookup, row.names=NULL))

tidy_data %>% group_by(Bundesland, Kraftstoff) %>% summarize(Anteil = sum(Bestand) / sum(Insgesamt)) %>% spread(Kraftstoff, Anteil)

# Was möchtest du noch herausfinden? Überlege dir ein paar eigene tidyverse-Ketten.
