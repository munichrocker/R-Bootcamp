# 4. Datenvisualisierung mit R

Datenvisualisierung ist ein mächtiges Werkzeug, um komplexe Datensätze greifbar zu machen. Die Art der Visualisierung hängt dabei stark davon ab, ob man selbst einen Datensatz besser verstehen oder einem Publikum ein Thema grafisch näher bringen möchte. Die statistische Programmiersprache R, mit seiner Vielzahl an Erweiterung, bietet für jeden Anwendungfall das richtige Werkzeug.

![Explorative und erklärende Datenvisualisierung](preview.png?raw=true)

## Inhalt

Diese Seminar ist Teil des [R-Bootcamps](https://journalistenschule-ifp.de/seminardetails/950) des ifp und soll Journalisten die Grundlagen der Datenvisualisierung in R vermitteln.

#### Wiederholung

- Tabellen einlesen
- Datensatz erkunden
- Filtern und zusammenfassen

#### Visualisierung mit ggplot2 (Teil 1)

- Einführung in ggplot2
- Einfache Diagrammtypen
- Small Multiples erstellen

#### Visualisierung mit ggplot2 (Teil  2)

- Richtigen Diagrammtyp wählen
- Designvorlagen nutzen
- Diagramme exportieren und weiterverwenden
- Interaktive Grafiken erstellen (plotly)

#### Kartenvisualisierungen

- Geodaten verwenden
- Choroplethenkarte erstellen (Leaflet)
- Symbolkarte erstellen (Leaflet)
- Karten veröffentlichen

## Vorbereitung

Vor Beginn des Seminar sollte jeder Teilnehmer [R](https://cloud.r-project.org/) und [RStudio](https://rstudio.com/products/rstudio/download/#download) installieren. RStudio ist eine integrierte Entwicklungsumgebung für R und bietet viele nützliche Funktionen wie Syntaxhervorhebung, Autovervollständigung und eine Paketverwaltung.

Nach der Installation von RStudio sollten noch folgende R-Pakete installiert werden:

```r
install.packages(c("rmarkdown", "svglite", "tidyverse", "lubridate", "cowplot", "rgdal", "leaflet"))
```

**Hinweis**: ggplot2 und viele andere Pakete sind bereits im Paket tidyverse enthalten. Für die Beispiele im Ordner `example` müssen gegebenfalls zusätzliche Pakete installiert werden.

## Hausaufgabe: Eurovision Song Contest

Seit 1956 ist der Eurovision Song Contest der wohl gleichzeitig beliebteste und meistgehasst Musikwettbewerb Europas. Wir wollen wissen: Wer dominiert den ESC? Wer sind die ewigen Zweiten und mit welche Sprache gewinnt man am ehesten? Die Hausaufgabe ist eine Wiederholung der Inhalte aus den letzten Seminarblöcken: Daten scrapen, verstehen und analysieren.

Alle Daten und Skripte finden sich im Ordner `homework`.

**Hinweise und Tipps:**

- Es empfiehlt sich die Funktion des [tidyverse](https://www.tidyverse.org/) (`filter()`, `group_by()`, `summarise()`) zu verwenden. Das macht die Arbeit erheblich einfacher und den Code leichter zu lesen. Der [dplyr Cheat Sheet](https://github.com/rstudio/cheatsheets/blob/master/data-transformation.pdf) hilft dabei enorm.
- Manche der Fragen lassen sich nicht mit Code beantworten. In diesem Fall kann man die Antworten einfach als Stichpunkte aufzuschreiben.
- Es ist vollkommen in Ordnung Lösungen für einzelne Probleme zu ergooglen, man sollte aber jede Lösung zumindest nachvollziehen können.
- Wenn es unüberwindbare technische Probleme beim Scrapen der Website gibt, kann die Tabelle der ESC-Gewinner auch als [CSV aus unserem Github-Repo](data/esc_winners.csv) eingebunden werden.

## Übung: Rechtsextreme Aufmärsche

Aufmärsche von rechtsextremen Parteien und Organisation rücken immer mehr in den Blick der Gesellschaft. Anschläge von Tätern aus dem rechtsextremen Umfeld, wie zuletzt in [Halle](https://de.wikipedia.org/wiki/Anschlag_in_Halle_(Saale)_2019) und [Christchurch](https://de.wikipedia.org/wiki/Terroranschlag_auf_zwei_Moscheen_in_Christchurch), aber auch gewaltsamen Proteste wie in [Chemnitz](https://de.wikipedia.org/wiki/Ausschreitungen_in_Chemnitz_2018), zeigen, dass die rechte Szene durchaus gewaltbereit ist. Es lohnt sich daher einen Blick darauf zu werden, wo rechtsextreme Demos stattgefunden haben, wer diese organisiert und wie sich die Anzahl und Teilnehmerzahl bei diesen Veranstaltungen über die Jahre hinweg entwickelt hat.

Bei dieser Übung geht es darum, verschiedene Thesen zum Thema rechtsextreme Aufmärsche mittels Datenanalyse zu überprüfen und daraus eine Art Recherche-Notizbuch zu erstellen. Dafür nutzen wir RMarkdown, ggplot und leaflet.

Alle Daten und Skripte finden sich im Ordner `challenge`.

**Hinweise und Tipps:**

- Die Daten kommen aus mehreren [kleinen Anfragen](https://kleineanfragen.de/search?q=%22rechtsextreme+aufm%C3%A4rsche+im%22+body%3ABT&sort=published_at%3Adesc) der Bundestagsfraktion „Die Linke“ und umfassen den Zeitraum von Oktober 2013 bis September 2019.
- Die Tabellen aus den PDF-Dokumenten wurden mit [Tabula](https://tabula.technology/) extrahiert und in Google Spreadsheets bereinigt und zusammengefasst.
- Um die Orte der Aufmärsche geografisch zuordnen zu können, wurden die Daten um die Spalte `Lat` und `Long` ergänzt. Dafür kam das kostenlose Online-Tool [Geocode](https://geocode.localfocus.nl/) zum Einsatz.
- Die Veranstaltungsdaten werden von Behördenmitarbeiten gepflegt und veröffentlicht. Daher gibt es kleinere Unstimmigkeiten in der Benennung von Veranstaltern und Orten. Die Spalte `Kategorie` bietet einen bereinigte Zuordnung der Parteien und Organisationen.

## Beispiel: Twitter-API

Das Skript finden sich im Ordner `example`.

## Tastenkürzel

Wer viel in RStudio arbeitet, kann sich mit Tastenkürzeln viel Zeit sparen. Hier eine Auswahl der wichtigsten Tastenkürzel:

| Befehl                           | Mac OS X                                                    | Windows                                               |
|----------------------------------|-------------------------------------------------------------|-------------------------------------------------------|
| Arbeitsverzeichnis ändern        | <kbd>⌃ Ctrl</kbd> + <kbd>⇧ Shift</kbd> + <kbd>H</kbd>       | <kbd>Strg</kbd> + <kbd>Shift</kbd> + <kbd>H</kbd>     |
| Zuweisungspfeil `<-` einfügen    | <kbd>⌥ Alt</kbd> + <kbd>-</kbd>                             | <kbd>Alt</kbd> + <kbd>-</kbd>                         |
| Pipe-Operator `%>%` einfügen     | <kbd>⌘ Cmd</kbd> + <kbd>⇧ Shift</kbd> + <kbd>M</kbd>        | <kbd>Strg</kbd> + <kbd>Shift</kbd> + <kbd>M</kbd>     |
| Code mit `#` auskommentieren     | <kbd>⌃ Ctrl</kbd> + <kbd>⇧ Shift</kbd> + <kbd>C</kbd>       | <kbd>Strg</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd>     |
| Code-Block ausführen             | <kbd>⌘ Cmd</kbd> + <kbd>↵ Enter</kbd>                       | <kbd>Strg</kbd> + <kbd>Enter</kbd>                    |
| Ganzes Dokument ausführen        | <kbd>⌃ Ctrl</kbd> + <kbd>⇧ Shift</kbd> + <kbd>↵ Enter</kbd> | <kbd>Strg</kbd> + <kbd>Shift</kbd> + <kbd>Enter</kbd> |
| Code-Block in RMarkdown einfügen | <kbd>⌘ Cmd</kbd> + <kbd>⌥ Alt</kbd> + <kbd>I</kbd>          | <kbd>Strg</kbd> + <kbd>Alt</kbd> + <kbd>I</kbd>       |
| Ganzes Dokument knitten          | <kbd>⌃ Ctrl</kbd> + <kbd>⇧ Shift</kbd> + <kbd>K</kbd>       | <kbd>Strg</kbd> + <kbd>Shift</kbd> + <kbd>K</kbd>     |

Es gibt auch ein offizielles [Tastenkürzel Cheat Sheet](https://rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf) von RStudio.

## Fehler finden und beheben

```shell
Error: Cannot add ggproto objects together. Did you forget to add this object to a ggplot object?
```

```shell
Error: attempt to use zero-length variable name
```

## Links

- [R for Data Science](https://r4ds.had.co.nz/introduction.html): Grundlagen der Datenanalyse und -visualisierung in R
- [Modern R with tidyverse](https://b-rodrigues.github.io/modern_R/): allgemeine (und eher abstrakte) Einführung in R
- [Tidyverse Style Guide](https://style.tidyverse.org/): gute Empfehlungen wie man sauberen R-Code schreibt
- [RMarkdown – The Definitive Guide](https://bookdown.org/yihui/rmarkdown/html-document.html): alle Funktionen von RMarkdown gut und anhand von Beispielen erklärt
- [RMarkdown – Theme Gallery](https://www.datadreaming.org/post/r-markdown-theme-gallery/): Übersicht aller Designvorlagen für RMarkdown
- [R Base Graphs](http://www.sthda.com/english/wiki/r-base-graphs): einfache Diagramme mit R erstellen
- [Financial Times – Visual Vocabulary](https://github.com/ft-interactive/chart-doctor/blob/master/visual-vocabulary/Visual-vocabulary.pdf): riesiges Poster mit verschieden Visualisierungsarten bietet
- [Data Visualisation Catalogue](https://datavizcatalogue.com/methods/treemap.html): Katalog der verschieden Visualisierungen, oft mit Beispielen und Tool-Empfehlungen
- [Datawrapper Blog](https://blog.datawrapper.de/category/thoughts-how-to-s/): großartige Einführungen und Anleitungen zu verschiedene Dataviz-Themen
- [Color Brewer](http://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3): nützliche Farbpaletten und -skalen für Diagramme und Karten
- [Color Palette Helper](https://gka.github.io/palettes): Farbpaletten mit eigenen Farben zusammenstellen
- [Mapshaper](https://mapshaper.org/): Shapefiles und verwandte Geodaten vereinfachen und in andere Formate konvertieren
- [Leaflet Providers](https://leaflet-extras.github.io/leaflet-providers/preview/index.html): Liste der offenen Grundlagenkarten für Leaflet (und andere Kartenwerkzeuge)
- [Leaflet for R](https://rstudio.github.io/leaflet/markers.html): Dokumentation von R Leaflet mit vielen Beispielen
- [Overpass Turbo](https://overpass-turbo.eu/): Geodaten aus Open Street Map abfragen und exportieren
- [Localfocus Geocode](https://geocode.localfocus.nl/): Orten und Adressen in Geo-Koordinaten umwandeln

## Cheat Sheets

Alle Cheat Sheets finden sich auch bei [RStudio auf Github](https://github.com/rstudio/cheatsheets). Hier eine Auswahl der wichtigsten:

- [dplyr](https://github.com/rstudio/cheatsheets/blob/master/data-transformation.pdf)
- [stringr](https://github.com/rstudio/cheatsheets/blob/master/strings.pdf)
- [ggplot2](https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf)
- [Leaflet](https://github.com/rstudio/cheatsheets/blob/master/leaflet.pdf)
- [RMarkdown](https://github.com/rstudio/cheatsheets/blob/master/rmarkdown-2.0.pdf)
- [Regex](https://github.com/rstudio/cheatsheets/blob/master/regex.pdf)

## Weitere Workshops

- [Grundlagen der Programmierung mit HTML, CSS und JavaScript](https://github.com/stekhn/programming-workshop/)
- [Datenvisualisierung mit D3.js lernen](https://github.com/stekhn/d3-workshop)
- [Kartenvisualisierung mit Leaflet lernen](https://github.com/stekhn/leaflet-workshop)

## Über den Autor

Steffen Kühne arbeitet als Datenjournalist beim Bayerischen Rundfunk und beschäftigt sich vor allem mit Datenanalysen und Visualisierung. Nach einem Studium der Journalistik studierte er Medieninformatik, um dann ein Volontariat als Datenjournalist und digitaler Designer bei der Süddeutschen Zeitung zu beginnen. Bis 2015 arbeitete er dort in der Entwicklungsredaktion. Außerdem ist Steffen Kühne als Trainer für verschiedene Medien und Journalistenschulen tätig.

- Webseite: [stekhn.de](https://stekhn.de)
- Github: [stekhn](https://github.com/stekhn)
- Twitter: [stekhn](https://twitter.com/stekhn)
- LinkedIn: [stekhn](https://www.linkedin.com/in/stekhn/)
- Xing: [Steffen Kühne](https://www.xing.com/profile/Steffen_Kuehne11/cv)
