# .______         .______     ______     ______   .___________.  ______     ___      .___  ___. .______   
# |   _  \        |   _  \   /  __  \   /  __  \  |           | /      |   /   \     |   \/   | |   _  \  
# |  |_)  |       |  |_)  | |  |  |  | |  |  |  | `---|  |----`|  ,----'  /  ^  \    |  \  /  | |  |_)  | 
# |      /        |   _  <  |  |  |  | |  |  |  |     |  |     |  |      /  /_\  \   |  |\/|  | |   ___/  
# |  |\  \----.   |  |_)  | |  `--'  | |  `--'  |     |  |     |  `----./  _____  \  |  |  |  | |  |      
# | _| `._____|   |______/   \______/   \______/      |__|      \______/__/     \__\ |__|  |__| | _|      
#   
#   .___  ___.   ______    _______   __    __   __          ____                                            
# |   \/   |  /  __  \  |       \ |  |  |  | |  |        |___ \                                           
# |  \  /  | |  |  |  | |  .--.  ||  |  |  | |  |          __) |                                          
# |  |\/|  | |  |  |  | |  |  |  ||  |  |  | |  |         |__ <                                           
# |  |  |  | |  `--'  | |  '--'  ||  `--'  | |  `----.    ___) |                                          
# |__|  |__|  \______/  |_______/  \______/  |_______|   |____/                                           
#   

# Alt + Shift + K zeigt alle verfügbaren Keyboard Shortcuts an

#### MODUL 1: BASICS ####

# Working Directory ####
# FRAGE: Was ist momentan das working directory?
# AUFGABE: Setze es auf den Ordner, in dem der Datensatz liegt

#Tipp: Shortcut Ctrl/Strg + Shift + H


#### Lesen und Schreiben ####

# Datensätze einlesen
# AUFGABE: Lies den Datensatz "ew19.csv" ein uns speichere ihn in der Variable "ew19". Was für Einstellungen musst du dabei überprüfen?


# Datensatz speichern
# AUFGABE: Schreibe ew19 in eine Datei namens "ew19_copy.csv"



#### Datenstrukturen ####

# Data Frames ##
# FRAGE: Was ist ein Data Frame?


# AUFGABE: Verschafft euch eine Überblick über ew19. Lasst euch dafür anzeigen:
# - Alle Spaltennamen
# - Die Anzahl Zeilen (und Spalten)
# - Die ersten paar Einträge
# - Die Struktur, mit ein paar Infos zu jeder Spalte
# - Eine filter- und durchsuchbare Vorschautabelle

# FRAGE: Was für Fragestellungen könnte man mit diesem Datensatz beantworten?

# FRAGE: Wie baut man einen data frame selbst?


# Vektoren ##
# FRAGE: Was ist ein Vektor?

# AUFGABE: Erstellt einen Vektor mit den Zahlen 1, 2 und 3
# AUFGABE: Erstellt einen Vektor mit den Zahlen 42 bis 121


# Listen ##
# FRAGE: Was ist eine Liste?

# AUFGABE: Erstellt eine Liste möglichst verschiedener Elemente

# Tipp:
liste[1]   #gibt das erste ELement einer Liste aus, aber immer noch in der Listenstruktur
liste[[1]] #gibt das erste ELement ohne Liste drumherum aus

# FRAGE: Was haben listen und Data Frames in R miteinander zu tun?

#### Suchen & Finden ####
# Hinweis: Die meisten Programmiersprachen beginnen bei 0 mit dem zählen. R beginnt bei 1.

# AUFGABE: Lasst euch von ew19 nur ... anzeigen. Dollar-Operator gilt nicht
# - Das Element in der erste Zeile, dritte Spalte
# - Nur die zweite Spalte
# - Nur die *Einträge* in der zweiten Spalte, als Vektor ohne Spaltenname und Zeilennummern
# - Nur dir dritte Zeile, aber alle Spalten
# FRAGE: Was bewirken wohl die folgenden Zeilen?
ew19[,2:4]
ew19[c(15,55),]

# FRAGE: Wie bekomme ich mithilfe des Dollar-Operators wohl das dritte Element von den Kreisnamen?


#### Rechnen mit Datensätzen ####

# AUFGABE: Füge eine neue Spalte hinzu namens "Gruene.anteil", die den Stimmanteil der Grünen wiedergibt.
#          ACHTUNG: Welche Spalten brauchst du dafür?

# FRAGEN:
# - Wie viele Einwohner haben die Landkreise zusammen? Ergibt diese Zahl Sinn?
# - Wie viele Einwohner hat ein Landkreis im Durchschnitt?
# - Was ist der höchste Grünen-Wähler-Anteil?
# - In welcher Zeile steht der Landkreis mit dem höchsten Anteil an Grünen-Wählern?
# - Wie heißt dieser Landkreis?

#### Einfache Grafiken ####

# Punkte oder Linien
plot(ew19$junge, ew19$alte)

# Balken
barplot(ew19$einwohner[1:10], names.arg = ew19$kreisname[1:10])

# AUFGABE: Erstellt einen Scatterplot: Anteil junger Leute vs. Anteil Grünen-Stimmen


#### MODUL 2: TIDYVERSE ####

install.packages("tidyverse")   # Paket installieren, falls noch nicht passiert
library(tidyverse)              # Paket laden


#### dplyr #### 
# Wie gemacht für Datenanalyse

### Wichtigste Funktionen: ###
?filter()          # Filtern
?mutate()          # Neue Spalten berechnen
?group_by()        # Nach Werten gruppieren
?summarize()       # Nach Gruppen zusammenfassen (Pivot-Tabellen in gut)
?arrange()         # Sortieren
?left_join()       # Datensätze mergen (SVERWEIS in gut)
?`%>%`             # Pipe operator: Mehrere Funktionen hintereinander ausführen. Shortcut: Strg + Shift + M


### dplyr-Basics ###

# AUFGABE: Füge mit dplyr zwei Spalten zu ew19 hinzu:
# - "nichtwähleranteil": Anteil Nichtwähler im Wahlkreis
# - "AFD.Anteil": Anteil Zweitstimmen für die AfD

# AUFGABE: Mit piping: Füge erst die beiden Spalten aus der Aufgabe zuvor hinzu und sortiere dann *absteigend* nach AfD-Anteil


### "group_by" und "summarize":  Pivot-Tabellen auf Speed ###

# AUFGABE: Erstelle "ew19_bl" mit den Spalten:
# - bundesland
# - Grüne.anteil: Anteil Zweistimmen für die Grünen
# - einkommen: Durchschnittseinkommen des Bundeslandes
ew19_bl

# AUFGABE: Erstelle ein Scatterplot: Gruene.Anteil gegen Einkommen
# FRAGE: Was erkennt man hier?

# ÜBUNG: Osten und Westen ##
osten = c("Brandenburg", "Sachsen-Anhalt", "Sachsen", "Mecklenburg-Vorpommern", "Thüringen")
# AUFGABE: Füge eine neue Spalte zum Datensatz ew19_bl hinzu, die sagt: Liegt dieses Bundesland im Osten oder im Westen?

# AUFGABE Fügt eine neue Spalte namens "farbe" hinzu: Falls Spalte "osten" == TRUE, dann "darkgreen", falls FALSE, aann "blue"
# AUFGABE: Erstelle ein Scatterplot: Gruene.Anteil gegen Einkommen, eingefärbt nach Osten oder Westen 

# BONUS: Mache die Übung "Osten und Westen" für ew19 mit allen Wahlkreisen


#### tidyr ####

### Wichtie Funktionen: ##
?gather()   #Datensatz umbauen: Von breit zu schmal --> Spalten in Zeilen transponieren
?spread()   #Umgekehrt: Von schmal zu breit --> Zeilen in Spalten transponieren
#Konzept tidy Data: Jede Spalte ist ein Merkmal. Jede Zeile ist ein Datenpunkt und enthält Infos zu jedem Merkmal.

#ZIEL:      Wir wollen alle Stimmanteile bequem auf einmal ausrechnen.
#Das heißt: Wir brauchen einen Datensatz mit den Spalten: Wahlkreis, Partei, Anteil Stimmen, Anzahl Stimmen
#Problem:   Die Parteien sind momentan eigene Spalten, und wir wollen die Anteile nicht einzeln ausrechnen
#Also:      "Schmaler" Datensatz (wenig Spalten) statt "Breiter Datensatz" (viele Spalten)

#Der Einfachheit halber: Behalten wir einmal nur die Spalten mit den Zweitstimmen pro Partei.
ew19_tidy = ew19[,c(1:3, 11:17)] #Alle überflüssigen Infos weglassen
names(ew19_tidy) #Probe: Schauen, welche Spalten noch da sind


### AUFGABE: Baue aus ew19_tidy einen Datensatz mit den Spalten:
### Wahlkreis, Partei, Anzahl Stimmen, Anteil Stimmen


# Happy coding!


