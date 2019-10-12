#### Skript aufsetzen ####
setwd("")
library(tidyverse); library(rvest)


#### Zu scrapende Links sammeln ####

l = paste0("https://www.weltfussball.de/spielerliste/frauen-wm-2019-frankreich/nach-mannschaft/",1:12)


### Erste Seite testweise scrapen ####

#Erst mal kompletten source Code einlesen
soup = read_html(l[1])

#Tabelle mit Spielerinneninfos holen
tmp = soup %>% html_node("table.standard_tabelle") %>% html_table

#Link zu Spielerinnenprofil hinzufügen    
tmp$link = soup %>% html_nodes(".data .standard_tabelle td:nth-child(1) a") %>% html_attr("href")


#### Alle links zu Spielerinnenprofilen sammeln ####

# Leere Liste initialisieren
d = vector("list", length = length(l))

# Durch Links loopen mit for-Schleife
for(i in 1:length(l)){
    #Statusanzeige in der Konsole: Alle 5 Elemente eine Nachricht anzeigen
    if(i %% 5 == 0){ cat(i, "von ",length(l),"\n") }
  
    #Erst mal kompletten source Code einlesen
    soup = read_html(l[i])
    
    #Tabelle mit Spielerinneninfos holen
    tmp = soup %>% html_node("table.standard_tabelle") %>% html_table
    
    #Link zu Spielerinnenprofil hinzufügen    
    tmp$link = soup %>% html_nodes(".data .standard_tabelle td:nth-child(1) a") %>% html_attr("href")
    
    #In Liste abspeichern
    d[[i]] = tmp
    
}
# Aufräumen
rm(i,soup,tmp)

# Listenelemente zu einem großen data frame zusammenfassen
wwc = bind_rows(d)

# Daten abspeichern
save.image("data.RData")

#### Data cleaning ####

# NA-spalten entfernen
na = sapply(wwc, function(col){col %>% is.na %>% all})
wwc = wwc[,!na]

# Geburtsdatum: in Datum umwandeln
wwc$Geboren = as.Date(wwc$Geboren, format = "%d.%m.%y")

# Wie alt ist die jüngste Spielerin? Wie alt die älteste?
summary(wwc$Geboren)

# Höhe: 
# 1. " cm" entfernen
# 2. in Zahl umwandeln
wwc$Größe = gsub(" cm","", wwc$Größe) %>% as.numeric()

# Wie groß ist die durchschnittliche Spielerin?
mean(wwc$Größe, na.rm = T)
# Wie groß ist die durchschnittliche Spielerin nach Position?
wwc %>% group_by(Position) %>% summarise(Größe = mean(Größe, na.rm = T))

save.image("data.RData")

#### Zusätzliche Infos von Spielerinnenprofilen holen ####

# Linkliste erstellen
l = paste0("https://www.weltfussball.de",wwc$link)
#Neue Spalten initialisieren
wwc$club = NA; wwc$clubland = NA

# Eine Seite testweise scrapen ####
# Quelltext holen
tmp = read_html(l[1])
# - Name des Clubs, für den die Spielerin aktuell spielt
tmp %>% html_nodes("a b") %>% html_text
# - Land des Clubs, für den die Spielerin aktuell spielt
#Option 1
tmp %>% html_nodes(".dunkel div") %>% html_text %>% gsub("[\n\t]+ (\\w+)\t+.+$","\\1",.)
#Option 2
tmp %>% html_nodes(".dunkel div img") %>% html_attr("title")


# Durch Links loopen mit for-Schleife ####
for(i in 1:nrow(wwc)){
  #Statusanzeige in der Konsole: Alle 5 Elemente eine Nachricht anzeigen
  if(i %% 5 == 0){ cat(i, "von ",nrow(wwc),"\t", round( (i/nrow(wwc)) * 100),"%\n") } 
  
  # Quelltext holen
  tmp = read_html(l[i])
  
  #Testen: Existiert die Info, die wir brauchen, auf der Seite?
  exists = tmp %>% html_nodes(".dunkel div") %>% length
  #Falls sie existiert: Neue Infos in WWC-Datensatz eintragen. Sonst überspringen
  if(exists > 0){
    # Name des Clubs, für den die Spielerin aktuell spielt
    wwc$club[i] = tmp %>% html_nodes("a b") %>% html_text
    # Land des Clubs, für den die Spielerin aktuell spielt
    wwc$clubland[i] = tmp %>% html_nodes(".dunkel div img") %>% html_attr("title")
  }
};rm(i,tmp, exists)

save.image("data.RData")
