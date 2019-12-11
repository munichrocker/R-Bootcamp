# 4. Datenvisualisierung mit R

Datenvisualisierung ist ein mächtiges Werkzeug, um komplexe Datensätze greifbar zu machen. Die Art der Visualisierung hängt dabei stark davon ab, ob man selbst einen Datensatz besser verstehen oder einem Publikum ein Thema grafisch näher bringen möchte. Die statistische Programmiersprache R, mit seiner Vielzahl an Erweiterung, bietet für jeden Anwendungfall das richtige Werkzeug.

![Explorative und erklärende Datenvisualisierung](preview.png?raw=true)

## Inhalte

Diese Seminar ist Teil des [R-Bootcamps](https://journalistenschule-ifp.de/seminardetails/950) des ifp und soll Journalisten die Grundlagen der Datenvisualisierung in R vermitteln.

#### Wiederholung mit Aufwärmübungen

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

#### Kartenvisualisierungen mit Leaflet

- Geodaten verwenden
- Choroplethenkarte erstellen
- Symbolkarte erstellen
- Karten veröffentlichen

## Vorbereitung

Vor Beginn des Seminar sollte jeder Teilnehmer [RStudio](https://rstudio.com/products/rstudio/download/#download) installieren. Diese integrierte Entwicklungsumgebung für R bietet eine Autovervollständigung, Syntaxhervorhebung, Paketverwaltung und eine integrierte Hilfefunktion.

Nach der Installation von RStudio sollten noch folgende R-Pakete installiert werden:

```r
install.packages(c("tidyverse", "rmarkdown", "rvest", "lubridate", "plotly", "leaflet"))
```

**Hinweis**: ggplot2 und viele andere Pakete sind bereits im Paket tidyverse enthalten.

## Hausaufgabe: Eurovision Song Contest

Seit 1956 ist der Eurovision Song Contest der wohl gelichzeitig beliebteste und meistgehasst Musikwettbewerb Europas. Wir wollen uns anschauen: Wer dominiert den ESC? Wer sind die ewigen Zweiten und mit welche Sprache gewinnt man am ehesten? Die Hausaufgabe ist eine Wiederholung der Inhalte aus den letzten Seminarblöcken: Daten scrapen, verstehen und analysieren.

Alle Daten und Skripte finden sich im Ordner `homework`.

Ein paar Hinweise und Tipps:

- Verwendet die Funktionen von dplyr (tidyverse). Das macht die Arbeit erheblich einfacher und den Code leichter zu lesen. Druckt das [dplyr Cheat Sheet](https://github.com/rstudio/cheatsheets/blob/master/data-transformation.pdf) aus und legt es neben euch.
- Manche der Fragen lassen sich nicht mit Code beantworten. In diesem Fall kann man die Antworten einfach als Stichpunkte aufzuschreiben.
- Es is vollkommen in Ordnung Lösungen für einzelne Probleme zu ergooglen, man sollte jede Lösung aber zumindest nachvollziehen können.
- Wenn es unüberwindbare technische Probleme beim Scrapen der Website gibt, kann die Tabelle der ESC-Gewinner auch als [CSV aus unserem Github-Repo](data/esc_winners.csv) eingebunden werden.

## Übung: Rechtsextreme Aufmärsche

Aufmärsche von rechtsextremen Parteien und Organisation rücken immer mehr in den Blick der Gesellschaft, nicht zuletzt durch die jüngsten rechtsterroristischen Anschläge in [Halle](https://de.wikipedia.org/wiki/Anschlag_in_Halle_(Saale)_2019) und [Christchurch](https://de.wikipedia.org/wiki/Terroranschlag_auf_zwei_Moscheen_in_Christchurch). Doch schon 2015, als die Zahl der Asylbewerber seit langem wieder deutlich anstieg, wurde die Gesellschaft mit rechtsmotivierten Übergriffen und Ausschreitungen konfrontiert. Demonstrationen von rechtsextremen Organisationen, meist zu den Themen Asyl oder Islamisierung, tragen diese Ideologien offen in die Gesellschaft. Daher lohnt es sich auch anzuschauen, wo und wann rechtsextreme Aufmärsche stattgefunden haben und wer diese organisiert hat.

Bei dieser Übung geht es darum, verschiedene Thesen zum Thema rechtsextreme Aufmärsche mittels Datenanalyse zu überprüfen und daraus eine Art Recherche-Notizbuch zu erstellen. Dafür nutzen wir RMarkdown, ggplot und leaflet.

Alle Daten und Skripte finden sich im Ordner `challenge`.

Ein paar Hinweise und Tipps:

- Der Datensatz kommt aus mehreren [kleinen Anfragen der Bundestagsfraktion Die Linke](https://kleineanfragen.de/search?q=%22rechtsextreme+aufm%C3%A4rsche+im%22+body%3ABT&sort=published_at%3Adesc) und umfasst den Zeitraum Oktober 2013 bis September 2019.

## Links

- [R Base Graphs](http://www.sthda.com/english/wiki/r-base-graphs)
- [Tidyverse Style Guide](https://style.tidyverse.org/)
- [Google’s R Style Guide](https://google.github.io/styleguide/Rguide.html)
- [R for Data Science](https://r4ds.had.co.nz/introduction.html)
- [Modern R with tidyverse](https://b-rodrigues.github.io/modern_R/)
- [Financial Times: Visual Vocabulary](https://github.com/ft-interactive/chart-doctor/blob/master/visual-vocabulary/Visual-vocabulary.pdf)
- [Color Brewer](http://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3)
- [Color Palette Helper](https://gka.github.io/palettes)
- [Mapshaper](https://mapshaper.org/)
- [Leaflet Providers](https://leaflet-extras.github.io/leaflet-providers/preview/index.html)
- [Overpass Turbo](https://overpass-turbo.eu/)

## Cheat Sheets

Alle Cheat Sheets finden sich auch bei [RStudio auf Github](https://github.com/rstudio/cheatsheets). Hier eine Auswahl der wichtigsten:

- [dplyr](https://github.com/rstudio/cheatsheets/blob/master/data-transformation.pdf)
- [stringr](https://github.com/rstudio/cheatsheets/blob/master/strings.pdf)
- [ggplot2](https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf)
- [Leaflet](https://github.com/rstudio/cheatsheets/blob/master/leaflet.pdf)
- [R Markdown](https://github.com/rstudio/cheatsheets/blob/master/rmarkdown-2.0.pdf)
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
