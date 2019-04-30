### Vektoren

# Definiere den Vektor petra. Er enthält die Zahlen von 10 bis 1 in absteigender Reihenfolge:
petra <- c(10:1)

# Prüfe, welche Klasse der Vektor hat:
class(petra)

# Lasse Dir die fünfte Stelle von Petra ausgeben, und speichere Sie in die Variable petra_fuenf
petra_fuenf <- petra[5]

# Filtere petra, Dir sollen nur noch die Elemente angezeigt werden, die durch 2 ohne Rest teilbar sind. Speichere sie in die variable petra_gerade
petra_gerade <- petra[petra %% 2 == 0]


##
##
## Vektoren 2
##
##


# Für dich wird hier ein Vektor definiert:
fcb_goal_diff <- c(Hoffenheim = 2, Stuttgart = 3, Leverkusen = -2, Schalke = 2, Augsburg = 1, Hertha = 1, Gladbach = 4, Mainz = 6, Freiburg = 0, Dortmund = 5, Duesseldorf = 3)

# Lasse Dir die Struktur von fcb_goal_diff anzeigen. Er ist ein Vektor mit Namen: Die jeweiligen gegnerischen Mannschaften.
str(fcb_goal_diff)

# Lass Dir dir die Verteilung der Ergebnisse als Histogramm anzeigen. Nutze dafür `hist()`:
hist(fcb_goal_diff)

# Du solltest sehen: Die meisten Ergebnisse liegen zwischen 0 und 2. Stimmt das? Hilfreich ist bei Verteilungen von Werten die Funktion `summary()`. Probiere es aus:
summary(fcb_goal_diff)

# Das Ergebnis von summary() zeigt: Im Median gewinnen die Bayern mit zwei Toren Vorsprung. Aber wann haben Sie mit mehr als 3,5 Toren gewonnen? Filtere den Vektor so, dass Su die Antwort bekommst - und schreibe das Ergebnis in fcb_high_victories. Gib die Variable dann aus:
fcb_high_victories <- fcb_goal_diff[fcb_goal_diff >= 3.5]
fcb_high_victories


# Gladbach, Mainz und Dortmund also. Aber wann haben die Bayern verloren oder unentscheiden gespielt? Finde es heraus und schreibe das Ergebnis in fcb_lost_tie. Gib die Variable dann aus:
fcb_lost_tie <- fcb_goal_diff[fcb_goal_diff <= 0]
fcb_lost_tie


##
##
## Von Vektor zum Dataframe
##
##


# Du möchtest einen Dataframe erstellen, in der in der ersten Spalte die Gegner des FCB stehen. Ziehe dafür die Namen aus `fcb_goal_diff` - und speichere Sie in die Variable namen_fcb.
namen_fcb <- names(fcb_goal_diff)

# Welchen Typ hat der Vektor namen_fcb?
class(namen_fcb)

# Füge jetzt namen_fcb und fcb_goal_diff zum Dataframe df_fcb_diff zusammen. Gib als zusätzliche Argumente ein: `row.names = NULL` und `stringsAsFactors = FALSE`. 
df_fcb_diff <- data.frame(namen_fcb, fcb_goal_diff, row.names = NULL, stringsAsFactors = FALSE)

# Super, es gibt einen Dataframe. Aber die Spaltennamen sind noch sehr wenig aussagekräftig. Ändere die Spaltennamen von df_fcb_diff in `c("gegner", "tordifferenz")`:
names(df_fcb_diff) <- c("gegner", "tordifferenz")

# Damit wir die Werte in der richtigen Reihenfolge plotten können, müssen wir die Gegner als Factor definieren. Die Reihenfoolge der Levels muss die sein, die wir später plotten wollen (das erste Spiel des Jahres als erstes, das letzte als letztes)
df_fcb_diff$gegner <- factor(df_fcb_diff$gegner, levels = df_fcb_diff$gegner)

# Plotte jetzt die Tordifferenz:
plot(df_fcb_diff)

# ------------------------------------------

## Listen
##
### Kurzer Exkurz zu Listen
##
##

# Für Dich wurde die liste_bla vordefiniert:
liste_bla <- list(1:3, c("a", "b"), c(TRUE, FALSE, TRUE, TRUE), c(2.3, 5.9, 11.9))

# Zeige die Struktur von `liste_bla` an:
str(liste_bla)

# Subsetting in Listen: Greife auf das Element zu, dasden Wert 11.9 hat. Speichere es in value_list_bla
value_list_bla <- liste_bla[[4]][3]

# Wandle die Liste jetzt in den Vektor `bla_vector` um:
bla_vector <- unlist(liste_bla)

# ------------------------------------------

## Dataframes
##

# Jetzt wollen wir mit einem Dataframe arbeiten. Das Thema: Oktoberfest in München. 

# Zunächst laden wir die beiden Dateien: `df_besucher` und `df_bierpreise`. Die Funktionen und die Links sind bereits definiert, gib nur noch die Variablen ein.
df_besucher <- read.csv("https://www.opengov-muenchen.de/dataset/8d6c8251-7956-4f92-8c96-f79106aab828/resource/56a0c3c8-c2ea-4b42-bbd2-21cb72d80803/download/oktoberfestbierkonsum19852017.csv")
df_bierpreise <- read.csv("https://www.opengov-muenchen.de/dataset/8d6c8251-7956-4f92-8c96-f79106aab828/resource/52fda541-c4dd-4eb6-8f2a-84ca24ffe775/download/oktoberfestbierpreis19852017.csv")

# Lass Dir von beiden Datensätzen head() und tail() anzeigen.
head(df_besucher)
tail(df_besucher)

head(df_bierpreise)
tail(df_bierpreise)

# Jetzt wollen wir die beiden Datensätze verbinden. Dafür hast Du bereits die Funktion `cbind()` kennengelernt. Schreibe die verbundenen Datensätze in die Variable df_oktoberfest
df_oktoberfest <- cbind(df_besucher, df_bierpreise)

# Berechne jetzt die `summary` von df_oktoberfest, damit Du einen Überblick über die Verteilung der Werte bekommst.
summary(df_oktoberfest)

# Du möchtest jetzt auf einen Blick prüfe, welche Klassen die Spalten haben. Dafür können wir die Funktion `sapply` benutzen. Was musst Du in sapply als Argumente hinzufügen?
sapply(X = df_oktoberfest, FUN = class)


##
##
### Das Oktoberfest in Zahlen
##
## 

# In dieser Übung analysierst Du die Oktoberfest-Daten. Die beiden Datensätze sind als `df_oktoberfest` bereits für Dich geladen.

# Die Struktur des Datensatzes kennst Du ja schon. Lass uns herausfinden, in welchem Jahr am meisten Besucher kamen. Ordne den Datensatz so an, dass das Jahr mit den meisten Besuchern ganz oben steht. Speichere ihn in die Variable df_oktoberfest_besucher - und lasse sie dir anzeigen.
df_oktoberfest_besucher <- df_oktoberfest[order(df_oktoberfest$besucher_gesamt, decreasing = TRUE), ]
df_oktoberfest_besucher

# Hat der Besucherrekord etwa mit dem Bierpreis zu tun? Sortiere den Datensatz nach dem niedrigsten Bierpreis und speichere das Ergebnis in df_oktoberfest_bier. Gib die Variable dann wieder aus:
# Anmerkung zur Lösung: Na gut, in Wirklichkeit war das Fest eine Jubiläums-Wiesn: 175 Jahre Oktoberfest.
df_oktoberfest_bier <- df_oktoberfest[order(df_oktoberfest$bier_preis), ]
df_oktoberfest_bier


# Seit wann kostet die Mass Bier über 5 Euro? Filtere df_oktoberfest danach
df_oktoberfest[df_oktoberfest$bier_preis >= 5, ]

# Wichtigste Frage: Wie hat sich der Bierpreis entwickelt? (Spoiler: Nach oben)
# Nutze `plot()` mit dem Argument `type = "b"` und den Datensatz `df_oktoberfest`, um es herauszufinden:
plot(df_oktoberfest$jahr, df_oktoberfest$bier_preis, type = "b")

# -----------------------------

##
##
## If und else
##
##

# Schreibe einen If...else-Test, der die aktuelle Uhrzeit nutzt. Dafür kannst Du die Funktion `Sys.time()` verwenden, die die aktuelle Datum und Uhrzeit zurückgibt.

# Definiere die Variable `current_time` mit Sys.time()
current_time <- Sys.time()

# Ziehe mit der Funktion format() die Stunde aus dem Datum und speichere Sie als `current_hour`. Ein Beispiel: format(foo$start.time, format='%H:%M'). Achte auf die Klasse von current_hour - sie muss ein Numeric sein.
current_hour <- as.numeric(format(current_time, format='%H'))

# Schreibe einen if...else-Test, der je nach Uhrzeit "Guten Morgen" (0 bis 10 Uhr), "Guten Tag" (10 bis 16 Uhr) oder "Guten Abend" (16 bis 0 Uhr) printet.
if (current_hour >= 0 & current_hour <= 10) {
  print("GUten Morgen")
} else if (current_hour > 10 & current_hour <= 16) {
  print("Guten Tag")
} else {
  print("Guten Abend")
}

##
##
## Loops
##
##

# Schreibe einen For-Loop, der jeden Buchstaben von a bis z aus dem Vektor `letters` einzeln ausgibt
for (i in letters) {
  print(i)
}


##
##
## Eigene Funktionen
##
##

# Manchmal müssen wir eigene Funktionen schreiben, so wie in diesem Beispiel: Manchmal werden in Dataframes Listen gespeichert. Dann wird statt eines Vektors in einer Spalte eine Liste eingefügt. 
# Das ist erstmal unproblematisch - bis wir die Liste mit write.csv() speichern wollen. Wir wollen daher eine Funktion schreiben, die testet, ob eine Spalte eine Liste ist, und diese dann in einen Vektor umwandelt.
# Der Dataframe heißt in diesem Beispiel "tibble". Das ist eine Abwandlung.
# Für Dich wird der Dataframe `restaurants` definiert. Er besteht aus drei Spalten, davon zwei Listen:
# Falls Du die Library tibble nicht installiert hast, nutze diesen Befehl: 
# install.packages("tibble")
library(tibble)

restaurant_name <- c('Pizza Hut', 'KFC', 'McDonald`s')
oeffnungszeiten <- list(c("Montag: 5 - 24 Uhr", "Dienstag: 3 - 2 Uhr", "Mittwoch: 6 -24 Uhr")) 
services <- list(c("Fett", "Zucker", "Ungesund"))

restaurants <- tibble(restaurant_name, oeffnungszeiten, services)

# Schreibe eine Funktion `set_lists_to_chars`, die Du über die Spalten eines Dataframes laufen lässt. Wenn eine Spalte die Klasse "list" hat, dann nutze "unlist()" und "paste()", um aus der Liste einen Vektor zu erstellen. Und gib diesen Vektor am Ende der Funktion mit `return` zurück.

set_lists_to_chars <- function(x) {
  if(class(x) == 'list') {
    y <- paste(unlist(x[1]), sep='', collapse=', ')
  } else {
    y <- x 
  }
  return(y)
}

# Führe die Funktion dann mit lapply aus:
data.frame(lapply(restaurants, set_lists_to_chars), stringsAsFactors = F)
