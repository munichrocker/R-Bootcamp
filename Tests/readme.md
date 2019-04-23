# Hausaufgaben zu Kurs 1

## Aufgaben zu Kommandozeile und Git

### Übung Kommandozeile

1. Schreibe "Hallo Welt" in die Konsole.

2. Erstelle ein Verzeichnis höher eine leere Datei mit dem Namen `kommandozeile.txt`.

3. Schreibe "Ich kann Kommandozeile" in die Datei mit dem Namen `kommandozeile.txt`

4. Erstelle eine Kopie von dieser Datei.

5. Überprüfe, ob die Kopie erstellt wurde.

6. Lösche die Kopie über die Kommandozeile.

### Übung Git

1. Erstellt ein neues Repository (privat oder öffentlich) auf Github

2. Klont das Repository auf euren Computer

3. Erstellt eine Textdatei in das lokale Repository

4. Committet und pusht die Datei zu Github

5. Erstellt eine neue Branch und eine neue Datei

6. Pusht die Datei in die neue Branch

Bonus:

7. Versucht auf Github einen Pull-Request zu erstellen und ihn zu mergen.

## Aufgaben zu Funktionen: Normalisierung

Ein typisches Problem: Wir wollen Werte normalisiert vergleichen. Zum Beispiel Mietpreise ab einem bestimmten Zeitpunkt.

Die Formel für Normalisierung ist einfach:

$$\Huge normalisiert = \frac{x_i-x_{min}}{x_{max}-x_{min}}$$

Stellt euch vor, wir haben einen Dataframe mit vier Spalten, die wir alle normalisieren wollen.

Wie würdet ihr das Problem angehen? Schreibt eine Funktion.

### Aufgabe: Normalisierung

```{r}
dataframe_normalize <- data.frame(  
  c1 = rnorm(50, 5, 1.5), 
  c2 = rnorm(50, 5, 1.5),    
  c3 = rnorm(50, 5, 1.5),
  c4 = rnorm(50, 5, 1.5)
)

head(dataframe_normalize, n = 10)
```

### Lösung: Normalisierung I

Die Funktion für ein einzelnes Problem sieht so aus: 

`(data_frame$c1 -min(data_frame$c1))/(max(data_frame$c1)-min(data_frame$c1))`

Komplett abstrahiert:
```{r}
normalize_x <- function(x){
  nominator <- x-min(x)
  denominator <- max(x)-min(x)
  normalize <- nominator/denominator
  return(normalize)
}
```

```{r}
dataframe_normalize[] <- lapply(dataframe_normalize, normalize_x)
```

```{r}
head(dataframe_normalize, n = 10)
```

## Aufgabenblatt zum Selbstdurcharbeiten

Liegt auf dem Server:

Wie schon die beiden Aufgaben aus dem Kurs:

https://benedict-witzenberger.de/ifp-r-bootcamp19/Test1.html

https://benedict-witzenberger.de/ifp-r-bootcamp19/Test2.html