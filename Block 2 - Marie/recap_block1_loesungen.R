## Recap der wichtigsten Inhalte aus dem ersten Block

# Erstelle einen Vector mit den Zahlen von 1 bis 20
1:20 # oder
c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)

# Erstelle einen Vektor mit den Zahlen von 1 bis 20, wobei sich jede Zahl direkt doppeln soll. 
# Tipp: Sieh dir die Funktion rep an.
rep(1:20, each=2)

# Lies den Datensatz ew19.csv ein, speicher ihn in der Programmierumgebung als benannten Dataframe ab.
ew19 <- read.csv("Daten/ew19.csv", sep=";")
# Kurzer Check über das Environment-Window: Passen alle Namen, 
# ist alles richtig eingelesen (integer, factor, characters, Trennzeichen richtig gesetzt, utf-8)? 

# Lass dir nur die ersten sechs Zeilen ausgeben. Sieh dir dazu beispielsweise die Hilfeseite der Funktion head an.
head(ew19) # Hier gibt es mehrere Möglichkeiten: Die Funktion head, oder Indizes benutzen
ew19[1:6,]

# Lass dir nur die letzten drei Zeilen ausgeben
tail(ew19, n=3) # Wieder mehrere Möglichleiten: tail ist das Gegenstück zu head
ew19[(nrow(ew19)-2):nrow(ew19),] # Wer nicht nachgucken will, welche Indizes die letzten drei Zeilen 
# genau haben, kann das mit nrow programmatisch lösen. Die Funktion gibt die Anzahl Zeilen eines Datensatzes aus.

# Berechne die Gesamtanzahl der Nichtwähler in Deutschland. Tipp: Nutze die Funktion sum.
sum(ew19$Wahlberechtigte)-sum(ew19$Wähler)

# Wie hoch war der Wähleranteil in ganz Deustchland?
sum(ew19$Wähler)/sum(ew19$Wahlberechtigte)

# Füge eine neue Spalte mit dem relativen Wahlergebnis der SPD zum Datensatz hinzu. Benutze dafür den Dollar-Operator.
# Tipp: Das relative Wahlergebnis ergibt sich aus der Division von den Stimmen und den gültigen Stimmen.
ew19$SPD_rel <- ew19$SPD/ew19$Gültige.Stimmen

# Sortiere den Datensatz absteigend nach den Stimmenanteilen der SPD und überschreib den Variablennamen 
# mit dem neu geordneten Datensatz. Tipp: Sieh dir die Funktion order an
ew19 <- ew19[order(ew19$SPD_rel, decreasing = T),]

# Transformiere die relativen Ergebnisse in prozentuale mit zwei Nachkommastellen. Tipp: Sie dir die Funktion round an.
ew19$SPD_rel <- round(100*ew19$SPD_rel, 2) # Multiplikation mit 100, dann round mit 2 Nachkommastellen

# Was war das höchste und was das niedrigste Ergebnis der SPD? Welches Ergebnis hatten sie in Deutschland?
min(ew19$SPD_rel)
max(ew19$SPD_rel)
100*(sum(ew19$SPD) / sum(ew19$Gültige.Stimmen)) # Gesamtergebnis in Deutschland

# In welchem Wahlgebiet / Kreis hatte die SPD ihr höchstes, wo ihr niedrigstes Ergebnis?
ew19[ew19$SPD_rel == min(ew19$SPD_rel),] # Indizierung mit logischem Vergleich
ew19[ew19$SPD_rel == max(ew19$SPD_rel),]

# In wie vielen Kreisen hatte die SPD ein Ergebnis über dem Gesamtergebnis?
# Tipp: Filtere den Datensatz auf die Zeilen, welche die Bedingung erfüllen. Benutze dann die Funktion nrow.
d_spd <- 100*(sum(ew19$SPD) / sum(ew19$Gültige.Stimmen))
nrow(ew19[ew19$SPD_rel > d_spd,])

#Schmeiß die Spalte mit den prozentualen Werten der SPD nochmal aus dem Datensatz raus.
# Dafür gibt es mehrere Möglichkeiten. Zb.:
ew19 <- ew19[-ncol(ew19)] # Wir können die Spalte exkludieren
ew19$SPD_rel <- NULL # Wir können die Spalte auf "NULL" setzen

# Challenge: Berechne für alle weiteren Parteien die prozentualen Werte und füge sie als neue Spalte hinzu.
# Benutze dafür zB eine for-Schleife
for(i in 8:47){ # For-Schleife über alle Spalten mit Parteiergebnissen (Spalten 8 bis 47)
  ew19[ncol(ew19)+1] <- round(100*(ew19[i]/ew19$Gültige.Stimmen), 2) # Neue Spalte mit der Nummer ncol+1
  colnames(ew19)[ncol(ew19)] <- paste0(colnames(ew19)[i], "_rel")
}

# exportiere den Datensatz in den Ordner "Daten" mit einem neuen Namen
write.csv(ew19, "Daten/ew19_rel.csv")

# Last but not least: Installiere und lade das Paket "tidyverse"
install.packages("tidyverse")
library(tidyverse)