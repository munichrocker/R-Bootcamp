## Hands on Tidyverse
# Erstmal installieren wir das tidyverse und magrittr


# Dann sehen wir uns das pipen an


# Einfaches Beispiel: Berechnen einer Summe




# Wir lesen wieder den Wahldatensatz von gestern ein


# Wir möchten ihn jetzt ins tidy / long format überführen. Ziel ist es, dass wir eine Spalte mit allen Parteinamen,
# und eine mit allen Stimmanzahlen haben. Alle anderen Spalten sollen bestehen bleiben.
# Wir benutzen den Befehl gather aus dem Paket tidyr dafür. 
# Er ist so aufgebaut:  gather(datensatz, 
#                              key = "Name der neuen Spalte mit den Parteinamen", 
#                              value = "Name der neuen Spalte mit den Stimmen, 
#                              Vektor mit Indizes der betreffenden Spalten)



# Wir speichern den tidy Datensatz mal in einer neuen Variable


# Nun einer kleiner Vergleich zwischen wide und long format:
# Wir möchten für jede Partei das prozentuale Ergebnis berechnen und es statt dem absoluten Wert in den Datensatz schreiben.
# Im wide data format schreiben wir dazu eine Schleife, die über jede Spalte mit den Parteien geht, die prozentualen Ergebnisse 
# berechnet und die Spalte dann überschreibt:



# Im tidyverse brauchen wir keine Schleife:



# Das alles (und noch viel mehr) können wir auch ab dem Einlesen des Datensatzes in einer Kette machen:



# Wenn wir keine Zuweisung machen, können wir nun ohne Überschreiben des Datensatzes alle möglichen Analysen
# und Berechnungen machen, die uns mehr über den Datensatz verraten. Dafür benutzen wir die dplyr-Funktionen:

# Wichtigste Funktionen von dplyr:




# Wo hatte die AfD ihr größtes Ergebnis?


# Was war das Bundesergebnis je Partei?


# In wie vielen Kreisen hatte die AfD ein Ergebnis über ihrem Gesamtergebnis?


# Was sind je Partei die drei Kreise mit dem höchsten Ergebnis?


# Welche fünf Parteien haben je Bundesland das niedrigste Ergebnis?




