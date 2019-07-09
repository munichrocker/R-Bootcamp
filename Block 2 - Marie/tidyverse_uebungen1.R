## Tidyverse Übungsblock 1
# Wenn nötig, installiere und lade die Pakete tidyverse und magrittr.


# Lies den Datensatz "bestand_kraftstoffarten.csv" aus dem Daten-Ordner ein.


# Checke (zb über Klick auf den Datensatz im Environment-Window oder auf den Pfeil daneben) ob alles richtig eingelesen ist. 
# Bessere im Zweifel nach (Seperator richtig gesetzt, Encoding richtig, sind alle zahlen auch als Zshlen erkannt worden?).

#Füge dem Datensatz eine neue Spalte hinzu mit dem Bestand an umweltfreundlicheren Autos / Autos mit alternativen Antrieben.


# Speichere eine Kopie des Datensatzes ab und bringe ihn ins Tidy Data Format. Nutze dafür die tidyr-Funktion gather.
# Welche Spalten sind hier die Schlüsselspalten, die wir in eine neue Spalte überführen wollen?


# Berechne den Anteil der jeweiligen Kraftstoffart am Gesamtbestand 
# je Zulassungsbezirk und füge sie dem Datensatz als neue Spalte hinzu.


# Erstelle eine Rangliste der am häufigsten vorkommenden Kraftstoffarten in Deutschland. Tipp: Dafür musst du
# den Datensatz erstmal auf die Bestandssumme je Kraftstoffart zusammenfassen.


# Erstelle eine Rangliste der Zulassungsbezirke mit dem größten Öko-Auto-Anteil. 
# Tipp: Das Rezept ist filtern, gruppieren, sortieren, slicen


# Erstelle eine Rangliste der Zulassungsbezirke mit dem größten Diesel-Auto-Anteil. 


# Berechne den Anteil der verschiedenen Kraftstoffarten am Gesamtbestand in Deutschland


# Wie viele Autos gibt es in Deutschalnd insgesamt?


# Erstelle je Kraftstoffart eine Liste mit den Zulassungebezirken, in denen sie den größten und niedrigsten Anteil haben.
# Tipp: Du kannst beim filtern %in% benutzen und einen Vektor mit Werten, von denen einer zutreffen soll.


# Challenge: Uns interessieren die Kraftstoffanteile je Bundesland. Dafür müssten wir irgendwie nach Bundesland gruppieren können.
# Die Nummer vor dem zulassungsbezirksnamen kann uns helfen: Die ersten beiden Zeichen geben uns die ID des Bundeslandes an.
# Thüringer Zulassungsbezirke beginnen mit einer 16, Zulassungsbezirke aus Bayern mit eine 09. 
# Sieh dir die Funktion ?substring an (oder google "r get first two characters of string") und erstelle eine neue ID-Spalte mit den 
# ersten beiden Ziffern des Zulassungsbezirks. Nach dieser kannst du dann gruppieren. 
# Bonus: Erstelle einen Lookup-Table und ersetze die ID durch den Bundesländernamen. Als Hilfe kannst dafür auch 
# nach "Bundesland ID" googlen.
# Und: weil's am Ende besser aussieht: Überführt euer Ergebnis wieder ins wide Format.




# Was möchtest du noch herausfinden? Überlege dir ein paar eigene tidyverse-Ketten.

