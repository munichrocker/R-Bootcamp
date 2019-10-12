#### Skript aufsetzen ####
setwd("")
library(tidyverse); library(rvest)


#### Zu scrapende Links sammeln ####
# Grund-URL: "https://www.weltfussball.de/spielerliste/frauen-wm-2019-frankreich/nach-mannschaft/1"
# Kreiere Vektor "l" mit Links zu allen Seiten der Tabelle
l


### Erste Seite testweise scrapen ####

#Erst mal kompletten source Code einlesen
soup

#Tabelle mit Spielerinneninfos holen
tbl

#Link zu Spielerinnenprofil hinzufügen    
tbl$link


#### Alle links zu Spielerinnenprofilen sammeln ####

# Leere Liste initialisieren
d

# Durch Links loopen mit for-Schleife
# 1. Optional: Statusanzeige in der Konsole
# 2. Infos holen, wie oben
# 3.In Liste abspeichern

# Listenelemente zu einem großen data frame namens "wwc" zusammenfassen
wwc

# Daten abspeichern
save.image("data.RData")

#### Data cleaning ####

# NA-spalten entfernen
na = sapply(wwc, function(col){col %>% is.na %>% all})
#wwc filtern: Nur Spalten behalten, wo na == FALSE ist

# Geburtsdatum: in Datum umwandeln
# Tipp: ?as.Date

# FRAGE: Wie alt ist die jüngste Spielerin? Wie alt die älteste?

# Höhe: 
# 1. " cm" entfernen. Tipp: ?gsub
# 2. in Zahl umwandeln

# FRAGE: Wie groß ist die durchschnittliche Spielerin?
# FRAGE: Wie groß ist die durchschnittliche Spielerin *nach Position*?

# Daten abspeichern
save.image("data.RData")


#### Zusätzliche Infos von Spielerinnenprofilen holen ####

# Linkliste erstellen. Tipp: wwc$link benutzen

#Neue Spalten initialisieren
wwc$club = NA; wwc$clubland = NA

# Eine Seite testweise scrapen ####

# Quelltext holen

# Gewünschte Elemente scrapen:
# - Name des Clubs, für den die Spielerin aktuell spielt
# - Land des Clubs, für den die Spielerin aktuell spielt


# Durch Links loopen mit for-Schleife ####
for(i in 1:nrow(wwc)){
  #Statusanzeige in der Konsole: Alle 5 Elemente eine Nachricht anzeigen. Diesmal mit Prozentangabe
  if(i %% 5 == 0){ cat(i, "von ",nrow(wwc),"\t", round( (i/nrow(wwc)) * 100),"%\n") } 
  
  # Quelltext holen
  # Infos holen, wie oben
  # Direkt in wwc-Datensatz abspeichern
  
}

save.image("data.RData")
