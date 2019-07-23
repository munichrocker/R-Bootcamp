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

# Mein Kommentar hierzu:
# Fußnoten können wir schnell händisch entfernen, alternativ könnten wir bereits beim Einlesen in R die zu ignorierenden
# Zeilen angeben. Gibt man hier jedoch versehentlich eine Zeile zu viel an, könnte der Informationsverlust, in diesem Falle vielleicht ein
# Kreis, erst spät auffallen. Da der Datensatz nicht viele Spalten hat, würde ich auch die Überschriften händisch in Excel oder einem Texteditor 
# anpassen. Natürlich können wir auch hierfür eine programmatische Lösung bauen, das würde ich allerdings nur machen, wenn ich viele Datensätze
# derselben Form einlesen müsste oder ich schon weiß, dass ich eine aktualisierte Statistik in naher Zukunft genau gleich bearbeiten möchte.
# Manuell versus programmatisch ist immer eine Kosten-Nutzen-Frage.
# Da ich euch aber schwer meine manuellen Änderungen erklären könnte, löse ich hier in den Übungslösungen mal alles von Beginn an in R.
# Hier eine Liste aller Bereinigungsschritte:
# a) Fußnoten raus
# b) Doppelte Überschriften vereinfachen
# c) Zeilensummen raus
# d) Zellen mit Sonderzeichen zu NA umwandeln
# e) Spalten mit Zahlen zu numerics umwandeln
# f) Beim Excel-File eine Spalte mit der Jahresangabe hinzufügen
# g) Beide Datensätze zusammenfügen
# h) Letzter Check, ob nun alles passt. Hier ist mir dann aufgefallen, dass ich gut 465 verschiedene Kreise im Datensatz hatte,
#    mehr als 60 zu viel. Also letzter Schritt: Überprüfen, woran es liegt und wie wir damit umgehen wollen.

### A2
## Ladet die für das tidyverse nötigen Zusatzpakete. Solltet ihr weiter unten in der Aufgabe noch weitere Pakete benötigen, kommt an diese
## Stelle zurück und ergänzt den Command.

# Alternativ: install.packages("tidyverse");library(tidyverse) ...etc.
needs(tidyverse, magrittr, readxl, zoo)
# tidyverse für die Pakete tidyr und dplyr
# magrittr für die Zuweisungs-Pipe %<>%
# readxl für read_xlsx
# zoo für na.locf, eine Funktion, die leere Zellen mit dem Inhalt der letzten nicht leeren ersetzt. Benutze ich später.

### A3
## Lest die Datensätze in R ein und bereinigt sie. Natürlich könnt ihr einige Bereinigungsschritte schon vorher per Hand erledigen.
## Um Merge-Konflikte zu vermeiden, erstellt dafür eine Kopie von den Datensätzen, legt sie in euren Übungen-Ordner und bearbeitet dann
## diese Kopie händisch.
## Wenn ihr die Datensätze in R eingelesen habt, bereinigt sie zunächst so weit, dass ihr sie zu einem großen Datensatz zusammenfügen könnt.
## Fügt sie dann zu einem Datensatz zusammen (bspw. mit der Funktion merge oder left_join, wenn es sich anbietet auch rbind oder cbind)

# Als erstes lade ich das CSV. Da ich nun die Überschriften nicht manuell angepasst habe, haben wir mehr Überschriften als Spalten.
# Das passt R nicht. Um den Datensatz ohne Fehler einlesen zu können, muss ich deshalb header=F setzen, R also zwingen, keine
# Überschriften für die Spalten aus dem Datensatz zu nehmen. Außerdem sehen wir beim Einlesen, dass alle Spalten als Faktoren gelesen werden.
# Das ist nervig, denn dann sind Veränderungen an den einzelnen Werten komplizierter. Deshalb verwende ich noch stringsAsFactors = F.
# Außerdem haben wir Sonderzeichen in den Daten, die für fehlende oder zu kleine Werte stehen (- und .). Wir können sie einzeln suchen 
# und ersetzen, oder direkt beim einlesen festlegen, dass diese Zeichen zu NA's umgewandelt werden sollen. Das geht mit na.strings = c(".", "-")
dat1 <- read.csv2("Daten/eheschliessungen_2017_2013.csv", header=F, stringsAsFactors = F, na.strings = c(".", "-"), encoding="latin1")
View(dat1) # Kurzer Check, ob alles soweit passt

# Die Spaltenüberschriften kommen aus der Hölle. Die erste Datenspalte gibt uns alle Eheschließungen je Kreis.
# Die Zweite gibt uns alle Eheschließungen deutscher Frauen mit Männern insgesamt usw. Wir cutten die ersten 9 Zeilen und ersetzen die 
# Spaltennamen. Es gibt wie immer mehrere Wege, ich entscheide mich hier für einen Step-by-Step Ansatz mit Basic R Befehlen:
dat1 <- dat1[-c(1:9, 2700:2703),] # In einem Rutsch die ersten 9 Zeilen weg und die letzten mit der Fußnote
# Danach lege ich neue Spaltennamen fest:
colnames(dat1) <- c("Jahr", "ID", "Kreis", "gesamt", "frau_deutsch", "frau_ausland", "mann_deutsch", "frau_deutsch_mann_deutsch", 
                    "frau_ausland_mann_deutsch", "mann_ausland", "frau_deutsch_mann_ausland", "frau_ausland_mann_ausland")
View(dat1) # Kurzer Check, ob alles soweit passt
# Nun sieht dieser Datensatz schon sehr wunderbar aus. Als nächstes möchte ich die Spalten, mit denen ich später rechnen möchte,
# in Zahlen umwandeln. Hier gibt es wieder mehrere Möglichkeiten, ich entscheide mich für die Funktion sapply, mit der ich die 
# Funktion as.numeric auf die betreffenden Spalten anwende:
dat1[4:12] <- sapply(dat1[4:12], as.numeric)
View(dat1) # Kurzer Check, ob alles soweit passt
# So gut wie fertig: Ich möchte jetzt noch die Spalten mit Landessummen rausschmeißen. Solche Summen können wir ja ohnehon easy 
# mit dplyr berechnen, und im Datensatz stören sie uns, wenn wir Berechnungen für alle Kreise machen wollen. Ihr erinnert euch:
# Wir waren mal bei einem anderen Datensatz ein paar Möglichkeiten durchgegangen, wie wir diese Zeilen identifizieren können.
# Knifflig ist diesmal, dass wir nicht einfach alle Kreise mit der ID größer irgendwas nehmen können, weil bspw. die kreisfreie Stadt
# Hamburg auch ein Bundesland ist, hier aber nicht doppelt sondern nur einmal als Bundesland vorkommt. Deshalb ist es hier fehlerrobuster,
# die Zeilen einzeln rauszunehmen.
dat1 %<>% filter(ID %in% c("02", "11") | nchar(ID) %in% 5) 
# Sprich Filter dat1 auf alle Zeilen, die in der ID entweder 02, 01 haben ODER deren ID genau 5 Characterelemente lang ist.

# Datensatz 2 ist eine Excel-Datei. Ich nutze das Paket readxl mit der Funktion read_xlsx, um ihn zu laden. 
# Das Equivalent zu na.strings ist hier das argument na.
dat2 <- read_xlsx("Daten/ehestatistik_2007_2012.xlsx", na=c(".", "-"))
View(dat2) # Kurzer Check, ob alles soweit passt
# Das Excel-File ist fieser aufgebaut als das CSV: Die Jahresangabe ist nicht ein Merkmal, sondern eine Zwischenüberschrift.
# Es ist absolut keine Schande, dieses Problem manuell zu lösen, indem ihr in Excel eine neue Spalte hinzufügt und die Jahreszahl 
# runterkopiert. Da wir euch in diesem Bootcamp aber nicht schonen wollen, zeige ich euch einen Ansatz das ganze in R zu machen.
# Beginnen wir erstmal wieder mit den Überschriften. Hier können wir genauso vorgehen, wie beim CSV.
dat2 <- dat2[-c(1:6, 3241:3256),] # In einem Rutsch die ersten 6 Zeilen weg und die letzten mit der Fußnote
colnames(dat2) <- c("ID", "Kreis", "gesamt", "frau_deutsch", "frau_ausland", "mann_deutsch", "frau_deutsch_mann_deutsch", 
                    "frau_ausland_mann_deutsch", "mann_ausland", "frau_deutsch_mann_ausland", "frau_ausland_mann_ausland")
dat2[3:11] <- sapply(dat2[3:11], as.numeric)
View(dat2) # Kurzer Check, ob alles soweit passt
# In der Spalte "ID" haben wir nun noch die Jahreszahl. Um diesen Datensatz mit dem anderen verschmelzen zu können und 
# der Übersichtlichkeit halber, 
# brauchen wir auch hier eine Spalte "Jahr" mit der Jahreszahl. Wenn wir dieses Problem programmatisch lösen wollen, müssen wir uns eine
# Strategie überlegen. Wir brauchen eine neue Splate, die nach einer Bedingung gehend erkennt, welche Zeilen zu welchem Jahr gehören.
# Wieder gibt es mehrere Möglichkeiten. Wir könnten zb gucken, ob die Anzahl Zeilen je Jahr immer dieselbe ist. Wenn dem so ist, könnten
# wir einen entsprechenden Vektor mit repeat bauen. Wir könnten auch sagen, dass die Jahreszahl sich immer um 1 erhöhen soll, wenn Flensburg
# sich im Datensatz wiederholt, denn es ist der erste Kreis der je Jahr genannt wird.
# Ich zeige euch jetzt eine Lösung, bei der wir eine neue Spalte anlegen mit den Jahreszahlen aus der ID-Spalte und ansonsten leeren Zellen 
# (Bedingung: Darf nur vier Zeichen lang sein), und dann alle leeren Zellen mit der vorher genannten Zahl auffüllen.
# Schritt für Schritt:
dat2$Jahr <- ifelse(nchar(dat2$ID) %in% 4, dat2$ID, NA) # Neue Spalte namens "Jahr". Die ifelse-Bedingung liest sich:
# Falls dat2$ID in einer Zelle 4 Zeichen lang ist, nimm diesen Wert. Andernfalls, nimm NA.
View(dat2) # Kurzer Check, ob alles soweit passt
# Nun nutzen wir die Funktion na.locf, um jede leere Zelle in der Spalte mit der vorherigen nicht leeren zu ersetzen. Ich benutze dafür
# die Funktion na.locf aus dem Paket zoo (das ich oben in needs hinzugefügt habe)
dat2 %<>% mutate(Jahr = na.locf(Jahr))
View(dat2) # Kurzer Check, ob alles soweit passt

# Als letztes schmeißen wir wieder alle Zeilen raus, die Zeilensummen enthalten.
dat2 %<>% filter(ID %in% c("02", "11") | nchar(ID) %in% 5)
View(dat2) # Kurzer Check, ob alles soweit passt

# Die beiden Datensätze haben nun exakt dieselben Spalten und Spaltennamen. Um sie zusammenzuführen, können wir sie mit rbind
# untereinanderhängen:
dat <- rbind(dat1, dat2)
View(dat) # Kurzer Check, ob alles soweit passt

# Einige von euch haben vielleicht bemerkt, dass wir noch eine kleine Hürde bei den Kreisnamen haben: Durch die optisch netten Einrückungen
# im Excel-File haben wir nun sogeannten "leading withespace". Das kann uns später die Gruppierung nach Namen unnötig erschweren.
# Deshalb: Weg damit! Beispielsweise mit der Funktion trimws
unique(dat$Kreis)
?trimws
dat %<>% mutate(Kreis = trimws(Kreis))
View(dat) # Kurzer Check, ob alles soweit passt

# Der Datensatz sieht super aus. Doch er hält noch etwas fieses für uns bereit: Wenn wir uns ansehen, wie viele einzelne Kreise wir
# insgesamt haben, bekommen wir 465. Das sind mehr als 60 Kreise mehr, als es in Deutschland gibt. 
length(unique(dat$Kreis))
# Bei genauerem hinsehen finden sich so Einträge wie "Chemnitz, Kreisfreie Stadt" und "Chemnitz, Stadt". Ähnliches findet sich 
# für Göttingen Der Hintergrund ist, dass sich Namen und ID's von Kreisen über die Jahre geändert haben. Auch Gebiete ändern sich
# von Zeit zu Zeit, weshalb es sich immer lohnt, sie Fußnoten und Hinweise zu Statistiken durchzulesen um in Erfahrung zu bringen, 
# wie mit solchen Reformen im Datensatz umgegangen wird. In diesem Fall verwirrt die hohe Anzahl Kreise zwar, es gibt aber eine 
# relativ leichte Erklärung: Da wir es mit einer Statistik über mehrere Jahre zu tun haben, hat das Bundesmat für Statistik alle Kreise
# mit allen ID's mit aufgenommen, die es über diesen Zeitraum gab. Seht euch beispielsweise Göttingen an (View(dat) und dann nach
# Göttingen suchen). Wir haben Göttingen doppelt je Jahr, einmal mit der ID 03152 und einmal mit der ID 03159. Die ID vom Landkreis Göttingen
# wechselte 2016 von der ersten auf die zweite, als der landkreis um Osterode am Harz erweitert wurde (das im Datensatz ab 2016 keine Werte mehr hat).
# Im Datensatz sind für Göttingen beide ID's genannt, doch das Göttingen mit der ID 03159 hat erst ab 2016 Werte.
# Soweit so gut, wir wissen nun also, dass wir zwar für jedes Jahr einen Eintrag für alle vorkommenden Kreise haben und dass wir also
# für jedes Jahr auch Kreise mit leeren Werten haben, die in diesem Jahr noch gar nicht "existierten". Da die Zellen hier leer sind,
# haben wir bei unseren Berechnungen aber keine unerwünschten Dopplungen zu befürchten. 
# Der Übersichtlichkeitshalber, und damit wir für jedes Jahr wissen, für wie viele Kreise es Werte für die Statistik gab, 
# schmeiße ich diese unnötigen leeren Kreise aus dem Datensatz raus:
dat %<>% filter(!is.na(gesamt)) # filtere alle Zeilen raus, die in der Spalte "gesamt" leer sind
dat %>% group_by(Jahr) %>% summarize(anzahl_kreise = length(unique(Kreis))) # Kurzer Check, wie viele Kreise wir nun je Jahr haben

### A4
## Hurra, der Datensatz ist bereinigt! Bitte vergleicht euren bereinigten Datensatz einmal mit meinem, bevor ihr mit den Aufgaben weiter macht.
## Ihr müst natürlich nicht alles so machen wie ich, aber vielleicht fällt euch dabei noch auf, dass ihr ein paar Bereinigungsschritte
## vergessen habt, die euch beim Bearbeiten der nächsten Aufgaben Steine in den Weg legen.
## Genug geredet, los geht's mit der dplyr-Analyse:

## 1) Wie viele Eheschließungen gab es pro Jahr?
dat %>% 
  group_by(Jahr) %>% 
  summarize(sum(gesamt))

## 2) Wie viele Eheschließungen gab es 2007 und 2017 zwischen ausländischen Frauen und deutschen Männern?
dat %>% 
  filter(Jahr %in% c("2007", "2017")) %>% # auf die Jahre filtern
  group_by(Jahr) %>% # nach jahren gruppiert die Berechnung durchführen
  summarize(sum(frau_ausland_mann_deutsch)) # auf Summe der entsprechenden Spalte zusammenfassen

## 3) Wie viele Eheschließungen gab es seit 2007 in eurem Heimatkreis?
dat %>% 
  filter(Kreis %in% "Berlin") %>% # in meinem Fall Berlin
  summarize(sum(gesamt)) 

## 4) Wie viele Menschen haben seit 2010 geheiratet?
# Erstmal nervt es mich, die Jahre nicht als Vektopr der zahlen 2010:2017 angeben zu können, nur weil sie als
# Characters gespeuchert sind. Also wandle ich das ganze einmal fix mit mutate um:
dat %<>% mutate(Jahr = as.numeric(Jahr))

dat %>%
  filter(Jahr %in% 2010:2017) %>% # nun kann ich die Zeitreihe als Zahlenvektor angeben, geht schneller als c("2010", "2011", ...)
  summarize(sum(gesamt)*2) # Je Eheschließung haben zwei Menschen geheiratet, also die Summe der Eheschließungen mal 2
# Antwort: Seit 2010 haben 6249792 heterosexuelle Menschen geheiratet, homosexuelle scheinen leider nicht mit in die Statistik
# aufgenommen zu werden :(

## 5) In welchen zehn Kreisen wurden 2017 die wenigsten Ehen geschlossen?
dat %>% 
  filter(Jahr %in% 2017) %>%
  arrange(gesamt) %>%
  slice(1:10)

## 6) Wie hoch ist der Anteil deutsch-deutscher Eheschließungen an den Gesamt-Eheschließungen in Deutschland gesamt je Jahr?
dat %>%
  group_by(Jahr) %>%
  summarize(anteil = 100*(sum(frau_deutsch_mann_deutsch)/sum(gesamt)))

## 7) Tobt euch aus: Wie viele Eheschließungen gab es je Bundesland (Bundesland identifizieren über die ersten beiden Ziffern der ID),
##    wo heiraten mehr ausländische Frauen deutsche Männer als ausländsiche Männer deutsche Frauen? Wo heiraten die meisten? Da, wo
##    viele Menschen wohnen (merged den Datensatz mit einem datensatz zur Einwohneranzahl)? In welchen Kreisen ging die Anzahl 
##    Eheschließungen in den vergangenen jahren zurück, und wo stieg sie, und um wie viel Prozent? 
