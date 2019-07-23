## Im Datenordner liegen zwei Datensätze zu Eheschließungen vom Amt für Statistik (https://www.regionalstatistik.de/genesis/online/data;sid=4C243C49A7EA8C1BFF323CA0CFA3E52D.reg1?operation=previous&levelindex=3&step=2&titel=Tabellenaufbau&levelid=1563785812442&levelid=1563785772127)

### A1
## Seht euch die beiden Datensätze erstmal in einem Texteditor oder in einem Programm wie Excel an, um einen Überblick
## zu bekommen, was die Statistik enthält und was ihr alles bereinigen müsstet, um mit dem Datensatz arbeiten zu können.
## Es lohnt sich auch, sich beim Durchgucken ein paar Notizen zu den Sachen zu machen, die ihr bereinigen müsst, sozusagen eine "To Do"-Liste.
## Schätzt dabei ab: Was lohnt sich, programmatisch zu bereinigen, und was ist mit der Hand in Excel vielleicht schneller erledigt?
## Diskutiert bei eurem nächsten Termin, warum ihr euch bei was wie entschieden habt :) 

## Hinweis, was ihr euch alles ansehen solltet: Doppelte / Vielfache Überschriften, Fußnoten, 
## geografische Einheiten und Summen im Datensatz (gibt es zB Zeilen mit Landessummen?), leere Zellen, Zellen mit Sonderzeichen 
## oder unnötige Leerzeichen vor und nach Strings, außerdem der Tipp: Es gibt etwa 400 deutsche Kreise und
## kreisfreie Städte samt eigener ID, die sich über die Jahre verändert haben kann. In einigen Datensätzen werden Daten vergangener Jahre
## auf diese neuen Kreis-ID's umgeschrieben. Wie ist es bei diesem Datensatz gelöst worden (siehe zB Göttingen)?
## Seht euch auch gerne meine Kommentare dazu in den Lösungen an! Dieser Datensatz ist ein gutes Beispiel, wie viele knifflige 
## Hürden eine ganz simple Statistik für uns bereit halten kann. Also Kopf hoch, wenn ihr nicht auf alles von selbst kommt!


### A2
## Ladet die für das tidyverse nötigen Zusatzpakete. Solltet ihr weiter unten in der Aufgabe noch weitere Pakete benötigen, kommt an diese
## Stelle zurück und ergänzt den Command.


### A3
## Lest die Datensätze in R ein und bereinigt sie. Natürlich könnt ihr einige Bereinigungsschritte schon vorher per Hand erledigen.
## Um Merge-Konflikte zu vermeiden, erstellt dafür eine Kopie von den Datensätzen, legt sie in euren Übungen-Ordner und bearbeitet dann
## diese Kopie händisch.
## Wenn ihr die Datensätze in R eingelesen habt, bereinigt sie zunächst so weit, dass ihr sie zu einem großen Datensatz zusammenfügen könnt.
## Fügt sie dann zu einem Datensatz zusammen (bspw. mit der Funktion merge oder left_join, wenn es sich anbietet auch rbind oder cbind)


### A4
## Hurra, der Datensatz ist bereinigt! Bitte vergleicht euren bereinigten Datensatz einmal mit meinem, bevor ihr mit den Aufgaben weiter macht.
## Ihr müst natürlich nicht alles so machen wie ich, aber vielleicht fällt euch dabei noch auf, dass ihr ein paar Bereinigungsschritte
## vergessen habt, die euch beim Bearbeiten der nächsten Aufgaben Steine in den Weg legen.
## Genug geredet, los geht's mit der dplyr-Analyse:

## 1) Wie viele Eheschließungen gab es pro Jahr?


## 2) Wie viele Eheschließungen gab es 2007 und 2017 zwischen ausländischen Frauen und deutschen Männern?


## 3) Wie viele Eheschließungen gab es seit 2007 in eurem Heimatkreis?


## 4) Wie viele Menschen haben seit 2010 geheiratet?


## 5) In welchen zehn Kreisen wurden 2017 die wenigsten Ehen geschlossen?


## 6) Wie hoch ist der Anteil deutsch-deutscher Eheschließungen an den Gesamt-Eheschließungen in Deutschland gesamt je Jahr?


## 7) Tobt euch aus: Wie viele Eheschließungen gab es je Bundesland (Bundesland identifizieren über die ersten beiden Ziffern der ID),
##    wo heiraten mehr ausländische Frauen deutsche Männer als ausländsiche Männer deutsche Frauen? Wo heiraten die meisten? Da, wo
##    viele Menschen wohnen (merged den Datensatz mit einem datensatz zur Einwohneranzahl)? In welchen Kreisen ging die Anzahl 
##    Eheschließungen in den vergangenen jahren zurück, und wo stieg sie, und um wie viel Prozent? 
