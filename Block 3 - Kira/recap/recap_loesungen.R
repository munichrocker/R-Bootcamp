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
getwd()
setwd("path/to/your/folder") #Shortcut: Ctrl/Strg + Shift + H
# Ohne Working Directory: R geht davon aus,
# dass wir uns im Standard-Ordner befinden 


#### Lesen und Schreiben ####

# Datensätze einlesen
?read.csv #Hilfeseite aufrufen
ew19 = read.csv("ew19.csv", fileEncoding = "utf-8", stringsAsFactors = F, sep = ";") # immer schön das Encoding prüfen!


# Datensatz speichern
write.csv(ew19, file = "ew19_copy.csv", row.names = FALSE)


#### Datenstrukturen ####

# Data Frames ##
# Tabellenförmige Datensätze

ew19     # Datensatz in Konsole anzeigen
?names() # Spaltennamen-Übersicht
?nrow()  # Anzahl der Zeilen
?head()  # Nur die ersten 6 Zeilen anzeigen lassen. FRAGE: Wie können wir uns die ersten *10* Zeilen ausgeben lassen?
?str()   # Struktur vom Datensatz in der Konsole anzeigen
?View()  # Datensatz als filter- und sortierbare Tabelle öffnen
# Tipp: Auf den Spaltennamen hovern,
# um Infos über die Spalte zu bekommen!

# In data frames ist jede Spalte ein *Vektor*

# So baut man data frames selbst:
df = data.frame(col1 = 1:5, col2 = vec, col3 = c("a", "b", "c", "d", "e"))
# Alle Spalten müssen die gleiche Länge haben!

# Vektoren ##
# Reihen von Zahlen
vec = c(1, 2, 3, 4, 5)  # c() für "concatenate"
vec = 6:10             # Vektor aus allen Zahlen zwischen der ersten und der zweiten in Einer-Schritten.

# Listen ##

l = list(vec, df, 3, "item 4")
l[1]      #Erstes Element (als Liste mit Länge 1)
l[[1]]    #Erstes Element (keine Liste  mehr)
l[c(1,3)] #Erstes und drittes element


#### Suchen & Finden ####
# Hinweis: Die meisten Programmiersprachen beginnen bei 0 mit dem zählen. R beginnt bei 1.

vec[2]              # Zweites Element von "vec". Das zwischen den eckigen Klammern nennt man "Index"
ew19[1,3]           # Erste Zeile, dritte Spalte
# Data Frames haben zwei Dimensionen, deshalb brauchen wir zwei Indizes, um ein Element zu finden
ew19[,2]            # Nimm nur die zweite Spalte

#FRAGE: Was bewirken wohl die folgenden Zeilen?
ew19[3,]          # 3. Zeile, alle Spalten
ew19[,2:4]        # alle Zeilen, 2. bis 4. Spalte, also Spalten 2,3,4
ew19[c(15,55),]   # Zeilen 15 und 55, alle Spalten

# Noch einfacher: Der Dollar-Operator

ew19$kreisname               # Eine Spalte mit dem Namen ansteuern mittels $-Operator. Das Resultat ist ein Vektor
# FRAGE: Wie bekomme ich mithilfe des Dollar-Operators wohl das dritte Element von den Kreisnamen?
ew19$kreisname[3]

#### Rechnen mit Datensätzen ####

ew19$Groko = ew19$Union + ew19$SPD     # Mit Spalten kann man auch rechnen!

# AUFGABE: Füge eine neue Spalte hinzu namens "Gruene.anteil", die den Stimmanteil der Grünen wiedergibt.
#          ACHTUNG: Welche Spalten brauchst du dafür?
ew19$Gruene.anteil = ew19$Gruene / ew19$gueltige

# Einige hilfreiche Funktionen

sum()    # Summe ausrechnen 
mean()   # Arithmetisches Mittel
median() # Median
max()    # Maximum
min()    # Minimum
#NA konstruieren

# Wie viele Einwohner haben die Landkreise zusammen? Ergibt diese Zahl Sinn?
sum(ew19$einwohner)

# Wie viele Einwohner hat ein Landkreis im Durchschnitt?
mean(ew19$einwohner)

# Was ist der höchste Grünen-Wähler-Anteil?
max(ew19$Gruene.anteil)

# In welcher Zeile steht der Landkreis mit dem höchsten Anteil an Grünen-Wählern?
# Tipp: ?which.max()
which.max(ew19$Gruene.anteil)

# Wie heißt dieser Landkreis?
ew19$kreisname[which.max(ew19$Gruene.anteil)]


#### Einfache Grafiken ####

# Punkte oder Linien
plot(ew19$junge, ew19$alte)

# Balken
barplot(ew19$einwohner[1:10], names.arg = ew19$kreisname[1:10])

# Macht eine Grafik mit Punkten:

# Anteil junger Leute vs. Anteil Grünen-Stimmen
plot(ew19$junge, ew19$Gruene.anteil)

# BONUS: Anteil junger Leute vs. *Anteil* Stimmen für AFD
plot(ew19$junge, ew19$AFD / ew19$gueltige)


#### MODUL 2: TIDYVERSE ####

install.packages("tidyverse")   # Paket installieren (Internetverbindung notwendig!)
library(tidyverse)              # Paket laden


#### dplyr #### 
# Wie gemacht für Datenanalyse

library(dplyr)
### Wichtigste Funktionen: ###
?filter()          # Filtern
?mutate()          # Neue Spalten berechnen
?group_by()        # Nach Werten gruppieren
?summarize()       # Nach Gruppen zusammenfassen (Pivot-Tabellen in gut)
?arrange()         # Sortieren
?left_join()       # Datensätze mergen (SVERWEIS in gut)

### Nichtwähler berechnen mit mutate
?mutate
ew19 = mutate(ew19, nichtwähler = wahlberechtigte - waehler)
#Man kann sogar mehrere neue Spalten hinzufügen

# AUFGABE:
# Füge eine Spalte hinzu namens "Nichtwähleranteil": "Nichtwähler" geteilt durch "Wahlberechtigte",
# und eine namens "AFD.Anteil": Zweitstimmen für die AfD geteilt durch die Gesamtanzahl gültiger Stimmen
ew19 = mutate(ew19,
               nichtwähleranteil = nichtwähler / wahlberechtigte, 
               AFD.anteil = AFD / gueltige)

#  Piping (%>%): Mehrere Funktionen hintereinander ausführen ##

# AUFGABE:
# Füge erst mit mutate() den Nichtwähler- und AfD-Anteil hinzu (wie in der Aufgabe zuvor)
# und sortiere dann absteigend nach AfD-Anteil.
ew19 = ew19 %>% 
      mutate(nichtwähleranteil = nichtwähler / wahlberechtigte, 
             AFD.anteil = AFD / gueltige) %>% 
      arrange(-AFD.anteil)

### "group_by" und "summarize":  Pivot-Tabellen auf Speed ###

# BEISPIEL: Was ist der Anteil Grünen-Wähler pro Bundesland? #
ew19_bl = ew19 %>% #Mit Originaldatensatz starten
            group_by(bundesland) %>% #Nach Bundesländern gruppieren
            summarize(Gruene = sum(Gruene), Gruene.anteil = Gruene / sum(einwohner),
                      einkommen = mean(einkommen)) %>% #Zusammenfassen: Berechnet Anteil Grünen-Wähler jeweils für die Bundesländer
            arrange(-Gruene) # Absteigend nach Anteil Grünen-Wähler sortieren

plot(ew19_bl$einkommen, ew19_bl$Gruene.anteil)
#FRAGE: Was erkennt man hier?

#AUFGABE: Osten und Westen ##

# Füge eine neue Spalte zum Datensatz hinzu, die sagt: Liegt dieser Wahlkreis im Osten oder im Westen?
osten = c("Brandenburg", "Sachsen-Anhalt", "Sachsen", "Mecklenburg-Vorpommern", "Thüringen")
ew19_bl$osten = ew19_bl$bundesland %in% osten

# Fügt eine neue Spalte für die Farbe hinzu: Falls Spalte "osten" == TRUE, dann "darkgreen", falls FALSE, "blue"
ew19_bl$color = ifelse(ew19_bl$osten, "darkgreen", "blue")
plot(ew19_bl$einkommen, ew19_bl$Gruene.anteil, col = ew19_bl$color)


#### tidyr ####
# Die Philosophie der sauberen Daten
library(tidyr)

### Wichtigste Funktionen: ##
?gather()   #Datensatz umbauen: Von breit zu schmal --> Spalten in Zeilen transponieren
?spread()   #Umgekehrt: Von schmal zu breit --> Zeilen in Spalten transponieren
#Konzept tidy Data: Jede Spalte ist ein Merkmal. Jede Zeile ist ein Datenpunkt und enthält Infos zu jedem Merkmal.

#ZIEL:      Wir wollen alle Stimmanteile bequem auf einmal ausrechnen.
#Das heißt: Wir brauchen einen Datensatz mit den Spalten: Wahlkreid, Partei, Anteil Stimmen, Anzahl Stimmen
#Problem:   Die Parteien sind momentan eigene Spalten, und wir wollen die Anteile nicht einzeln ausrechnen
#Also:      "Schmaler" Datensatz (wenig Spalten) statt "Breiter Datensatz" (viele Spalten)

#Der Einfachheit halber: Behalten wir einmal nur die Spalten mit den Zweitstimmen pro Partei.
ew19_tidy = ew19[,c(1:3, 11:17)] #Alle überflüssigen Infos weglassen
names(ew19_tidy) #Probe: Schauen, welche Spalten noch da sind


### AUFGABE: Baue aus ew19 einen Datensatz mit den Spalten:
### Wahlkreis, Partei, Anteil Stimmen, Anzahl Stimmen


# Happy coding!


