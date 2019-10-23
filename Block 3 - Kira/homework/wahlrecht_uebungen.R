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

#Wo "xxx" steht, sollt ihr etwas selbst ausfüllen

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
    html_nodes("xxx") %>% 
    #Link URL extrahieren
    xxx
    #Link wieder vervollständigen
    paste0("http://www.wahlrecht.de/umfragen/",.)

#  1.2 Zweite Ebene: Liste aller vorheriger Zeitabschnitte auf den Unterseiten scrapen
#Leere Liste erstellen
links2

#Gescrapte Links durchgehen
for(i in 1:xxx){
    links2[[i]] = read_html(xxx) %>%
        #Links (a) im Paragraphen (p) mit der Klasse (navi) finden
        xxx
        #Link URL extrahieren
        #Link wieder vervollständigen
}

#Vektoren in Liste zu einem Vektor machen (wie bind_rows für data frames)
links2 = unlist(links2)

#Nur die behalten, die eine (Jahres-)Zahl in der URL haben. Tipp: regex für "Irgendeine Zahl von 0-9"
keep = grepl("xxx", links2)
#Links subsetten, sodass nur die aus "keep" übrigbleiben
links2 = xxx

#Aktuelle Links und vorherige Zeiträume zu einem Vektor verbinden (optional: alphabetisch sortieren)
links = xxx
#KONTROLLE: length(links) = 56

#Aufräumen
rm(i, keep, links1, links2)


#### 2. Eine Seite testweise scrapen ####
#########################################

## Teste mit erstem Link (http://www.wahlrecht.de/umfragen/allensbach.htm)

#2.1 Quellcode einlesen
tmp = xxx

#2.2 Quellcode filtern, 2.3 In R-Datenstruktur umwandeln
wahlrecht = tmp %>%
    #Große Tabelle mit Umfrageergebnissen finden
    xxx
    #In R-Struktur umwandeln: Tabelle als Data Frame speichern. TIPP: Achte auf Argumente "fill", "header" und "dec"
    html_table(xxx) %>% 
    #Spaltennamen sauber machen mit "clean_names" aus Paket "janitor"
    xxx
#KONTROLLE: 80 Zeilen, 12 Spalten

#Institutsnamen aus der Überschrift extrahieren
institut = xx
    #Überschrift-Element finden
    #In Text umwandeln
#KONTROLLE: "Allensbach (Institut für Demoskopie)"

#Institut als Spalte anfügen
wahlrecht$institut = institut



##### 3. Alle Seiten im Loop scrapen ######
###########################################

#3.1 Leere Liste erstellen
liste = xxx

#3.2 "for"-Schleife durch alle Elemente von "links"
for(xxx){
    #Statusmeldung für die Konsole
    xxx
    
    #3.3 Infos scrapen wie in 2
    
    #Datensatz in i-tem Element von Liste abspeichern
    xxx
    
}
#Aufräumen
rm(i, tmp, institut)

#Kleine "wahlrecht"-Datensätze zu einem großen Datensatz namens "wahlrecht" zusammenbinden. Tipp: bind_rows
wahlrecht = xxx
#KONTROLLE: 4542 Zeilen, 22 Spalten

# Sichten
#Spaltennamen
xxx
#Struktur
xxx

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
#Kriterium: Eintrag in Spalte "cdu_csu" beginnt mit einer Zahl. Tipp: regex für "Am Anfang der Zeile irgendeine Zahl"
keep = grepl("xxx", xxx)
#Zeilen filtern in "wahlrecht"
wahlrecht = xxx
#KONTROLLE: 4443 Zeilen (oder paar mehr, weil schon wieder neue Umfragen hinzugefügt wurden), 22 Spalten

#2. Alle leeren Einträge zu echten NAs machen ####
#Tipp: convert_to_NA. Warnung "'convert_to_NA' is deprecated." ignorieren.
wahlrecht = xxx

#3. Alle Spalten rausfiltern, in denen keine Daten stehen ####
#Tipp: remove_empty
wahlrecht = xxx
#KONTROLLE: 4443 Zeilen (oder paar mehr), 20 Spalten

#4. Datumsangaben in eine Spalte sammeln ####
#Datumsangaben sind entweder in "x" oder in "datum"
#Wenn "datum" NA ist, füge Eintrag von x ein, sonst behalte Eintrag. Tipp: ifelse()
wahlrecht$datum = xxx

#Spalte x entfernen
wahlrecht = xxx
#KONTROLLE: 4443 Zeilen (oder paar mehr), 19 Spalten

#5. Datum in richtiges Datum umwandeln ####
#Tipp: as.Date
#Die allermeisten Einträge haben das Format TT.MM.YYYY. Die, die das nicht haben, haben kein exaktes Datum eingetragen, die ignorieren wir für diese Übung
wahlrecht$datum = xxx

#Wie viele Datumseinträge sind jetzt NA?
wahlrecht$datum %>% is.na %>% table
#KONTROLLE: 49 NAs

#6. Befragte-Spalte in Zahl umwandeln ####
#Alles, was keine Zahl ist, durch nichts ersetzen, und dann in Zahl umwandeln. Tipp: regex "\\D"
wahlrecht$befragte = xxx
#Werte unter 100 entfernen, da ist beim konvertieren was schief gegangen. Tipp: ifelse
wahlrecht$befragte = xxx

#7. Datensatz von breit zu schmal umbauen, sodass die Parteien alle in einer Spalte stehen ####
wahlrecht = gather(wahlrecht, xxx)
#KONTROLLE: 66645 Zeilen (oder paar mehr), 6 Spalten


#8. Prozentzahlen umwandeln in richtige Zahlen ####
wahlrecht$ergebnis = wahlrecht$ergebnis %>% 
    #Prozentzeichen entfernen
    xxx
    #Komma durch Punkt ersetzen
    xxx
    #In Zahl umwandeln
    xxx
#NAs liegen daran, dass da an manchen Stellen "-" stand

#9. Spaltenreihenfolge ändern, Spalte "Zeitraum" weglassen ####
wahlrecht = select(xxx)

#10. Sortiere nach Institut, dann absteigend nach Datum ####
wahlrecht = xxx

#11. Datensatz abspeichern als CSV ####
xxx

#CHALLENGE MODE: Schritte 1-10 in einer Pipe
#Stand von vor dem Cleaning wieder laden
load("wahlrecht.RData")
