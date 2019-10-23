#### Skript initialisieren ###
setwd("")

#Wir probieren mal das Paket aus, was Patrick Stotz erwähnt hat
install.packages("janitor")
library(janitor)
library(rvest)
library(tidyverse)

#### Wichtige Funktionen ####
?read_html         #Quelltext einlesen
?html_node         #HTML-Element finden
?html_nodes        #HTML-Elemente finden (mehrere)
?html_table        #HTML-Tabelle in Data Frame konvertieren
?html_text         #Text aus HTML-Element extrahieren
?html_attr         #HTML-Attribut als Text extrahieren


#### Ziel ####
#Liste aller Sonntagsfrage-Ergebnisse seit 1998 pro Umfrageinstitut
#Quelle: http://www.wahlrecht.de/umfragen/index.htm

# Rezept:
# 1. Linkliste erstellen
#  1.1 Erste Ebene: Liste aller Umfrageinstitut-Links scrapen (http://www.wahlrecht.de/umfragen/allensbach.htm usw.) 
#  1.2 Zweite Ebene: Liste aller vorheriger Zeitabschnitte auf den Unterseiten scrapen (http://www.wahlrecht.de/umfragen/allensbach/2013.htm usw.)
# 2. Eine Seite mit Umfrageergebnissen testweise scrapen
# 3. Alle Unterseiten im Loop scrapen
# 4. Datensatz säubern


##### 1. Linkliste erstellen ######
###################################

#  1.1 Erste Ebene: Liste aller Umfrageinstitut-Links scrapen
links1 = read_html("http://www.wahlrecht.de/umfragen/index.htm") %>%
      #Links (a) im table header (th) mit der Klasse (in) finden
      html_nodes("th.in>a") %>% 
      #Link URL extrahieren
      html_attr("href") %>% paste0("http://www.wahlrecht.de/umfragen/",.)

#  1.2 Zweite Ebene: Liste aller vorheriger Zeitabschnitte auf den Unterseiten scrapen
#Leere Liste erstellen
links2 = vector("list", length = length(links1))
#Links durchgehen
for(i in 1:length(links1)){
    links2[[i]] = read_html(links1[i]) %>%
            #Links (a) im Paragraphen (p) mit der Klasse (navi) finden
            html_nodes("p.navi>a") %>%
            #Link URL extrahieren
            html_attr("href") %>% paste0("http://www.wahlrecht.de/umfragen/",.)
}

#Vektoren in Liste zu einem Vektor machen (wie bind_rows für data frames)
links2 = unlist(links2)

#Nur die behalten, die eine (Jahres-)Zahl in der URL haben
keep = grepl("[0-9]", links2)
links2 = links2[keep]

#Aktuelle Links und vorherige Zeiträume verbinden, alphabetisch sortieren
links = c(links1, links2) %>% sort
#KONTROLLE: length(links) = 56

#Aufräumen
rm(i, keep, links1, links2)


#### 2. Eine Seite testweise scrapen ####
#########################################

## Teste mit erstem Link (http://www.wahlrecht.de/umfragen/allensbach.htm)

#2.1 Quellcode einlesen
tmp = read_html(links[1])

#2.2 Quellcode filtern, 2.3 In R-Datenstruktur umwandeln
wahlrecht = tmp %>%
  #Große Tabelle mit Umfrageergebnissen finden
  html_node("table.wilko") %>%
  #In R-Struktur umwandeln: Tabelle als Data Frame speichern. TIPP: Achte auf Argumente "fill", "header" und "dec"
  html_table(fill = TRUE, header = TRUE, dec=",") %>% 
  #Spaltennamen sauber machen mit "clean_names" aus Paket "janitor"
  clean_names()
#KONTROLLE: 80 Zeilen, 12 Spalten

#Institutsnamen aus der Überschrift extrahieren
institut = tmp %>%
    #Überschrift-Element finden
    html_node("td.title>h1") %>%
    #In Text umwandeln
    html_text()
#KONTROLLE: "Allensbach (Institut für Demoskopie)"

#Institut als Spalte anfügen
wahlrecht$institut = institut


 
##### 3. Alle Seiten im Loop scrapen ######
###########################################

#3.1 Leere Liste erstellen
liste = vector("list", length = length(links))

#3.2 "for"-Schleife durch alle Elemente von "links"
for(i in 1:length(links)){
      #Statusmeldung
      if(i %% 10 == 0){ cat(i, "von", length(links), "\n") }
    
      #3.3 Infos scrapen wie in 2
      #Quellcode schonmal einlesen
      tmp = read_html(links[i])
      
      #Tabelle mit Umfrageergebnissen scrapen
      wahlrecht = tmp %>%
          #Große Tabelle mit Umfrageergebnissen finden
          html_node("table.wilko") %>%
          #In R-Struktur umwandeln: Tabelle als Data Frame speichern.
          html_table(fill = TRUE, header = TRUE, dec=",") %>% 
          #Spaltennamen sauber machen mit "clean_names" aus Paket "janitor"
          clean_names()
      
      #Institutsnamen aus der Überschrift extrahieren
      institut = tmp %>%
          #Überschrift-Element finden
          html_node("td.title>h1") %>%
          #In Text umwandeln
          html_text()

      #Institut als Spalte anfügen
      wahlrecht$institut = institut
      
      #Datensatz in i-tem Element von Liste abspeichern
      liste[[i]] = wahlrecht
      
}
#Aufräumen
rm(i, tmp, institut)

#Kleine "wahlrecht"-Datensätze zu einem großen Datensatz namens "wahlrecht" zusammenbinden. Tipp: bind_rows
wahlrecht = bind_rows(liste)
#KONTROLLE: 4542 Zeilen, 22 Spalten

# Sichten
#Spaltennamen
names(wahlrecht)
#Struktur
str(wahlrecht)


#Speichern
save.image("wahlrecht.RData")
#Diesen Stand könnt ihr wieder abrufen mit load("wahlrecht.RData")


##### 4. Säubern ######
#######################

#Zielstruktur: datum, institut, befragte, partei, ergebnis

#Rezept:
#1. Alle Zeilen rausfiltern, die keine Umfrageergebnisse enthalten
#2. Alle leeren Einträge zu echten NAs machen
#3. Alle Spalten rausfiltern, in denen keine Daten stehen
#4. Datumsangaben in eine Spalte sammeln
#5. Datum in richtiges Datum umwandeln
#6. Befragte-Spalte in Zahl umwandeln
#7. Datensatz von breit zu schmal umbauen, sodass die Parteien alle in einer Spalte stehen
#8. Prozentzahlen umwandeln in richtige Zahlen
#9. Spaltenreihenfolge ändern, Spalte "Zeitraum" weglassen
#10. Sortiere nach Institut, dann absteigend nach Datum
#11. Datensatz abspeichern

# Erst mal als einzelne Schritte. Wer danach noch Lust hat:
# CHALLENGE MODE: Mache Schritte 1-10 in einer einzigen Pipe

#1. Alle Zeilen rausfiltern, die keine Umfrageergebnisse enthalten ####
#Kriterium: Eintrag in Spalte "cdu_csu" beginnt mit einer Zahl
keep = grepl("^[0-9]", wahlrecht$cdu_csu)
wahlrecht = wahlrecht[keep,]
#KONTROLLE: 4443 Zeilen (oder paar mehr, weil schon wieder neue Umfragen hinzugefügt wurden), 22 Spalten

#2. Alle leeren Einträge zu echten NAs machen ####
#Tipp: convert_to_NA. Warnung "'convert_to_NA' is deprecated." ignorieren.
wahlrecht = convert_to_NA(wahlrecht, "")


#3. Alle Spalten rausfiltern, in denen keine Daten stehen ####
wahlrecht = remove_empty(wahlrecht, "cols")
#KONTROLLE: 4443 Zeilen (oder paar mehr), 20 Spalten


#4. Datumsangaben in eine Spalte sammeln ####
#Datumsangaben sind entweder in "x" oder in "datum"
#Wenn "datum" NA ist, füge Eintrag von x ein, sonst behalte Eintrag. Tipp: ifelse()
wahlrecht$datum = ifelse(is.na(wahlrecht$datum), wahlrecht$x, wahlrecht$datum)

#Erste Spalte entfernen
wahlrecht = wahlrecht[,-1]
#KONTROLLE: 4443 Zeilen (oder paar mehr), 19 Spalten

#5. Datum in richtiges Datum umwandeln ####
#Die allermeisten Einträge haben das Format TT.MM.YYYY. Die, die das nicht haben, haben kein exaktes Datum eingetragen, die ignorieren wir für diese Übung
wahlrecht$datum = as.Date(wahlrecht$datum, format = "%d.%m.%Y")

#Wie viele Datumseinträge sind jetzt NA?
wahlrecht$datum %>% is.na %>% table
#KONTROLLE: 49 NAs

#6. Befragte-Spalte in Zahl umwandeln ####
#Alles, was keine Zahl ist, entfernen. Tipp: "\\D"
wahlrecht$befragte = gsub("\\D", "", wahlrecht$befragte) %>% as.numeric
#Werte unter 100 entfernen, da ist beim konvertieren was schief gegangen. Tipp: ifelse
wahlrecht$befragte = ifelse(wahlrecht$befragte < 100, NA, wahlrecht$befragte)

#7. Datensatz von breit zu schmal umbauen, sodass die Parteien alle in einer Spalte stehen ####
wahlrecht = gather(wahlrecht, partei, ergebnis, c(1:7, 11:18))
#KONTROLLE: 66645 Zeilen (oder paar mehr), 6 Spalten


#8. Prozentzahlen umwandeln in richtige Zahlen ####
wahlrecht$ergebnis = wahlrecht$ergebnis %>% 
      #Prozentzeichen löschen
      gsub(" %","", .) %>% 
      #Komma durch Punkt ersetzen
      gsub(",",".", .) %>% 
      #In Zahl umwandeln
      as.numeric
#NAs liegen daran, dass da an manchen Stellen "-" stand

#9. Spaltenreihenfolge ändern, Spalte "Zeitraum" weglassen ####
wahlrecht = select(wahlrecht, datum, institut, befragte, partei, ergebnis)

#10. Sortiere nach Institut, dann absteigend nach Datum ####
wahlrecht = wahlrecht %>% arrange(institut, desc(datum))

#11. Datensatz abspeichern ####
write.csv(wahlrecht, "wahlumfragen.csv", row.names = F, na = "-")

#CHALLENGE MODE: Schritte 1-10 in einer Pipe
load("wahlrecht.RData")
wahlrecht = wahlrecht %>% 
  #1. Alle Zeilen rausfiltern, die keine Umfrageergebnisse enthalten
  filter(grepl("^[0-9]", wahlrecht$cdu_csu)) %>% 
  #2. Alle leeren Einträge zu echten NAs machen
  convert_to_NA("") %>% 
  #3. Alle Spalten rausfiltern, in denen keine Daten stehen
  remove_empty("cols") %>% 
  #4. Datumsangaben in eine Spalte sammeln + 5. Datum in richtiges Datum umwandeln
  mutate(datum = ifelse(is.na(datum), x, datum) %>% as.Date(format = "%d.%m.%Y")) %>% 
  select(-x) %>% 
  #6. Befragte-Spalte in Zahl umwandeln
  mutate(befragte = gsub("\\D", "", befragte) %>% as.numeric %>% ifelse(. < 100, NA, .)) %>% 
  #7. Datensatz von breit zu schmal umbauen, sodass die Parteien alle in einer Spalte stehen
  gather(partei, ergebnis, c(1:7, 11:18)) %>% 
  #8. Prozentzahlen umwandeln in richtige Zahlen
  mutate(ergebnis = ergebnis %>% gsub(" %","", .) %>% gsub(",",".", .) %>% as.numeric) %>% 
  #9. Spaltenreihenfolge ändern, Spalte "Zeitraum" weglassen
  select(datum, institut, befragte, partei, ergebnis) %>% 
  #10. Sortiere nach Institut, dann absteigend nach Datum
  arrange(institut, datum)


