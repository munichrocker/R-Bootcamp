4 - Dataframes und Daten einlesen
========================================================
author: Benedict Witzenberger
date: 17. April 2019
autosize: true

Recap
========================================================

Ich habe für gestern einen kleinen Test vorbereitet.

Ihr findet ihn unter: XYZ.de

Versucht euch an den Aufgaben. Wenn es Fragen gibt, gebt Bescheid.

Was wir heute vorhaben
========================================================

* Subsetting und Arbeiten mit Dataframes

* Daten einlesen

* Daten vorbereiten

* Packages installieren und laden

* Guter Stil

* Conditional Flows

Subsetting
========================================================

Wir können Daten auf verschiedene Arten zuschneiden (= subsetting)

Das Blöde daran: R hat verschiedene Konzepte, die teilweise zusammenspielen, aber dann bei verschiedenen Datentypen verschieden reagieren.

Deswegen fangen wir langsam an:


```r
mein_vector <- c("a", "b", "c")
mein_vector[1]
```

```
[1] "a"
```

[1] ruft das erste Element in einem Vektor auf. Wir nennen die 1 "Index".

R zählt im Unterschied zu vielen anderen Programmiersprachen ab 1, nicht ab 0.


Subsetting bei einem Vektor: Positiv
========================================================

Positive Zahlen geben Elemente an den angegebenen Positionen zurück: 


```r
x <- c(2.1, 4.2, 3.3, 5.4)
x[c(1,4)]
```

```
[1] 2.1 5.4
```

```r
x[order(x)] # aufsteigend sortiert
```

```
[1] 2.1 3.3 4.2 5.4
```

```r
x[c(1, 1)] # doppelte Integers geben das Ergebnis doppelt zurück
```

```
[1] 2.1 2.1
```

```r
x[c(1.01, 1.9)] # double Zahlen werden in Integers umgewandelt
```

```
[1] 2.1 2.1
```

Subsetting bei einem Vektor: Negativ
========================================================
Negative Integers geben Elemente zurück, die nicht angegeben wurden.


```r
x[-c(3, 1)]
```

```
[1] 4.2 5.4
```

```r
x[-(1:2)]
```

```
[1] 3.3 5.4
```

Positive und negative Integers dürfen beim Subsetting nicht gemischt werden.

Subsetting bei einem Vektor: Logical
========================================================
TRUE und FALSE helfen ebenfalls beim Subsetting und geben die zutreffenden Werte zurück:


```r
x[c(TRUE, FALSE, TRUE, FALSE)]
```

```
[1] 2.1 3.3
```

Ein zu kurzer Vektor wird recyclet:


```r
x[c(TRUE, FALSE)]
```

```
[1] 2.1 3.3
```

Das ist vor allem beim Filtern hilfreich, wo TRUE und FALSE im Hintergrund arbeiten:


```r
x[x > 3]
```

```
[1] 4.2 3.3 5.4
```

Subsetting bei einem Vektor: Sonstiges
========================================================

Ein `NA` gibt immer eine `NA` zurück. `x[c(TRUE, FALSE, NA, FALSE)]`

Leeres Subsetting bei einem Vektor gibt alles zurück: `x[]`

Ein Subsetting mit [0] gibt einen leeren Vektor zurück.

Subsetting bei einem Vektor: Namen
========================================================

Ein Vektor mit Namen, kann auch über die Namen gesubsettet werden:


```r
names(x) <- c("a", "b", "c", "d")

x[c("a", "d")]
```

```
  a   d 
2.1 5.4 
```

Subsetting bei Matrizen I
========================================================
Matrizen und Arrays können reacht einfach angepsrochen werden:

`matrix[Zeilen, Spalten]`


```r
a <- matrix(1:9, nrow = 3)
colnames(a) <- c("A", "B", "C")
a[1:2, ]
```

```
     A B C
[1,] 1 4 7
[2,] 2 5 8
```

Jetzt funktionert auch leeres Subsetting - dann werden alle Zeilen oder Spalten zurückgegeben.

Subsetting bei Matrizen II
========================================================


```r
a[c(TRUE, FALSE, TRUE), c("B", "A")]
```

```
     B A
[1,] 4 1
[2,] 6 3
```

Subsetting  bei Dataframes I 
========================================================


```r
df <- data.frame(x = 1:4, y = 4:1, z = letters[1:4])
df
```

```
  x y z
1 1 4 a
2 2 3 b
3 3 2 c
4 4 1 d
```

Subsetting  bei Dataframes II 
========================================================


```r
df[1,1]
```

```
[1] 1
```

```r
df[c(1, 3), ]
```

```
  x y z
1 1 4 a
3 3 2 c
```

```r
df$x
```

```
[1] 1 2 3 4
```

```r
df[df$x == 2, ]
```

```
  x y z
2 2 3 b
```

Subsetting bei Dataframes III
========================================================

Subsetten wir einen Dataframe mit einem einzelnen Vector, verhält er sich wie eine Liste, bei zwei Vektoren, wie eine Matrix.


```r
df[c("x", "z")] # wie bei einer Liste
```

```
  x z
1 1 a
2 2 b
3 3 c
4 4 d
```

```r
df[, c("x", "z")] # wie bei einer Matrix
```

```
  x z
1 1 a
2 2 b
3 3 c
4 4 d
```

Subsetting bei Dataframes IV: [[]]
========================================================

Es gibt zwei weitere Subsetting-Operatoren, die bei Dataframes und Listen sehr wichtig werden:
`$` und `[[]]`

### [[]]

```r
a <- list(a = 1, b = 2)
a[1]
```

```
$a
[1] 1
```

```r
a[[1]]
```

```
[1] 1
```

> “If list x is a train carrying objects, then x[[5]] is the object in car 5; x[4:6] is a train of cars 4-6.” 
>
> (Quelle: @RLangTip auf Twitter)

Preserving vs. Simplifying
========================================================

Beim Subsetting gehen Informationen verloren. Es ist wichtig, dass wir das kontrollieren können. Vor allem beim Programmieren, wollen wir meistens, dass der Datentyp des Inputs gleich dem Output ist.

|           | Vereinfachend      | Erhaltend                              |
|-----------|--------------------|----------------------------------------|
| Vector    | x[[1]]             | x[1]                                   |
| List      | x[[1]]             | x[1]                                   |
| Factor    | x[1:4, drop = T]   | x[1:4]                                 |
| Array     | x[1, ] oder x[, 1] | x[1, , drop = F] oder x[, 1, drop = F] |
| Dataframe | x[, 1] or x[[1]]   | x[, 1, drop = F] oder x[1]             |

#### Beispiel Vektor: Namen gehen verloren

```
> x <- c(a = 1, b = 2)
> x[[1]] # vereinfachend
[1] 1
> x[1] # erhaltend
a 
1 
```

Weitere Probleme beim Subsetting
========================================================

* Liste: Gibt nur das Element zurück, nicht das Element in der Liste

* Factor: Wirft alle ungenutzen Levels weg

* Matrix: Wenn nur noch eine Deminsion übrig bleibt, geht die Matrix verloren:


```r
a <- matrix(1:4, nrow = 2)
a[1, , drop = FALSE]
```

```
     [,1] [,2]
[1,]    1    3
```

```r
a[1,]
```

```
[1] 1 3
```

* Dataframes: Wenn nur noch eine Spalte/Zeile übrig bleibt, wird die als Vektor ausgegeben

Subsetting bei Dataframes IV: $
========================================================

### $

`x$y` ist die Kurzschreibung für `x[["y", exact = FALSE]]`


```r
a <- list(a = 1, b = 2)
a$a
```

```
[1] 1
```

Besonders praktisch bei Dataframes:

```r
df <- data.frame(a = 1:4, b = 4:1, c = letters[1:4])
df$a
```

```
[1] 1 2 3 4
```

```r
df$c
```

```
[1] a b c d
Levels: a b c d
```

Beliebter Fehler
========================================================

Die $-methode funktioniert nicht, wenn der Spaltenname in einer Variable liegt:


```r
var <- "a"

df$var
```

```
NULL
```

Stattdessen geht:

```r
df[[var]]
```

```
[1] 1 2 3 4
```

### Out of Bounds

Wollen wir ein Vektor-Element aufrufen, das nicht exisitert, bekommen wir bei [] meistens NA oder 0 zurück, bei [[]] meist direkt einen Fehler.

Subsetting und Zuweisen
========================================================

Wir können Variablenzuweisung und Subsetting kombinieren


```r
df[df$a ==2, ]$b
```

```
[1] 3
```

```r
df[df$a ==2, ]$b <- "Benedict"
df[df$a ==2, ]$b
```

```
[1] "Benedict"
```

Oder:


```r
x <- 1:5
x[c(1, 2)] <- 2:3
x
```

```
[1] 2 3 3 4 5
```

Wozu können wir das brauchen?
========================================================

Drei Anwendungsbeispiele:

### Lookup-Table

### Match und Merge

### Samplen

### Dataframes: order, character subsetting und logical subsetting

Anwendung: Lookup-Table
========================================================

Wir können mithilfe eines Vektor Werte zuordnen:


```r
x <- c("m", "f", "u", "f", "f", "m", "m")
lookup <- c(m = "Männlich", f = "Weiblich", u = NA)
```

**Frage:** Wie würdet ihr jetzt die Werte von x in lookup nachschlagen?

Anwendung: Lookup-Table Lösung
========================================================

Wir können mithilfe eines Vektor Werte zuordnen:


```r
x <- c("m", "f", "u", "f", "f", "m", "m")
lookup <- c(m = "Männlich", f = "Weiblich", u = NA)
lookup[x]
```

```
         m          f          u          f          f          m 
"Männlich" "Weiblich"         NA "Weiblich" "Weiblich" "Männlich" 
         m 
"Männlich" 
```

Anwendung: Match und Merge
========================================================


```r
noten <- c(1, 2, 2, 5, 3, 1, 4, 2, 6)

bewertung <- data.frame(
  note = 1:6,
  worte = c("Sehr gut", "gut", "befriedigend", "ausreichend", "mangelhaft", "ungenügend"),
  durchgefallen = c(F, F, F, F, T, T)
)
```

Wir wollen jetzt die Informationen aus `noten` und `bewertung` zusammenbringen (mergen). Das geht mit zwei Varianten...

Variante 1: match()
========================================================


```r
id <- match(noten, bewertung$note)
bewertung[id, ]
```

```
    note        worte durchgefallen
1      1     Sehr gut         FALSE
2      2          gut         FALSE
2.1    2          gut         FALSE
5      5   mangelhaft          TRUE
3      3 befriedigend         FALSE
1.1    1     Sehr gut         FALSE
4      4  ausreichend         FALSE
2.2    2          gut         FALSE
6      6   ungenügend          TRUE
```


Variante 2: rownames()
========================================================


```r
rownames(bewertung) <- bewertung$note
bewertung[as.character(noten), ]
```

```
    note        worte durchgefallen
1      1     Sehr gut         FALSE
2      2          gut         FALSE
2.1    2          gut         FALSE
5      5   mangelhaft          TRUE
3      3 befriedigend         FALSE
1.1    1     Sehr gut         FALSE
4      4  ausreichend         FALSE
2.2    2          gut         FALSE
6      6   ungenügend          TRUE
```

**Hinweis**

Die Funktion `merge()` kann bei einem solchen Problem auch helfen.

Anwendung: Samplen
========================================================

Wir wollen aus einem Dataframe zufällige Zeilen ziehen.


```r
df <- data.frame(x = rep(1:3, each = 2), y = 6:1, z = letters[1:6])

set.seed(10)

df[sample(nrow(df)), ]
```

```
  x y z
4 2 3 d
2 1 5 b
5 3 2 e
3 2 4 c
1 1 6 a
6 3 1 f
```

`set.seed()` sorgt dafür, dass Zufallszahlen in Skripten reproduzierbar bleiben.

Samplen I
========================================================

Wir ziehen drei zufällige Zeilen:


```r
df[sample(nrow(df), 3), ]
```

```
  x y z
2 1 5 b
6 3 1 f
3 2 4 c
```

Mit Zurücklegen:

```r
df[sample(nrow(df), 3, replace = T), ]
```

```
    x y z
3   2 4 c
4   2 3 d
4.1 2 3 d
```

Anwendung Dataframes: Order
========================================================


```r
x <- c("b", "c", "a")
order(x)
```

```
[1] 3 1 2
```

```r
x[order(x)]
```

```
[1] "a" "b" "c"
```

Um Gleichständen vorzubeugen können wir auch mehrere Variablen sortieren lassen.

Anwendung Dataframes: character subsetting
========================================================

### Oder: Eine Spalte entfernen

Dafür gibt es zwei Wege: Eine Spalte kann auf `NULL` gesetzt werden:

```r
df <- data.frame(x = rep(1:3, each = 2), y = 6:1, z = letters[1:6])
df$z <- NULL
```

Oder: Wir wählen nur die Spalten aus, die wir gerne hätten:


```r
df[c("x", "y")]
```

```
  x y
1 1 6
2 1 5
3 2 4
4 2 3
5 3 2
6 3 1
```


Anwendung Dataframes: logical subsetting
========================================================

### Oder: Filtern

Dafür brauchen wir zunächst einmal die Befehle für Vergleiche:

| Befehl        | Bedeutung        |
|---------------|------------------|
| !x            | Nicht x          |
| & oder &&     | UND              |
| | oder ||     | ODER             |
| x %in% vector | Vektor enthält x |
| is.na(x)      | NAs in x         |
| >             | größer als       |
| <             | kleiner als      |
| >=            | ist größer gleich|
| <=            | ist kleiner gleich|
| ==            | ist gleich       |
| !=            | ist nicht gleich |

`!(X & Y) == !X | !Y`
`!(X | Y) == !X & !Y`

**Achtung:** Die doppelten && und || funktionieren bei Vektoren anders: Da prüfen sie nur das erste Element.

Filtern
========================================================


```r
df <- data.frame(x = rep(1:3, each = 2), y = 6:1, z = letters[1:6])
df[df$x == 3, ]
```

```
  x y z
5 3 2 e
6 3 1 f
```

```r
df[df$x == 3 & df$y == 2, ]
```

```
  x y z
5 3 2 e
```

```r
df[df$x == 3 & df$z != "e", ]
```

```
  x y z
6 3 1 f
```

Subset()
========================================================

Wir können auch die Funktion `subset()` zum Subsetting verwenden:


```r
subset(df, x == 3 & z != "e")
```

```
  x y z
6 3 1 f
```


Übung: Booleans
========================================================

Was sind die Ergebnisse dieser Tests? Schreibt sie euch auf, wir vergleichen:

1. `TRUE == FALSE`

2. `TRUE != FALSE`

3. `!(TRUE | FALSE)`

4. `FALSE != !(FALSE)`

5. 
```
df <- data.frame(a = c(1, 2, 3), b = c(3, 2, 1), c = c("a", "b", "c")) 
df[df$a != 2,]$c
```

6. gleicher df:
`df[df$c != "a" & df$a != 3,]$a`

Lösung: Booleans I
========================================================


```r
TRUE == FALSE
```

```
[1] FALSE
```

```r
TRUE != FALSE
```

```
[1] TRUE
```

```r
!(TRUE | FALSE)
```

```
[1] FALSE
```

```r
FALSE != !(FALSE)
```

```
[1] TRUE
```

Lösung: Booleans II
========================================================


```r
df <- data.frame(a = c(1, 2, 3), b = c(3, 2, 1), c = c("a", "b", "c")) 
df[df$a != 2,]$c
```

```
[1] a c
Levels: a b c
```

```r
df[df$c != "a" & df$a != 3,]$a
```

```
[1] 2
```


Packages installieren
========================================================

Viele R-Beispiele kommen mit den gleichen Datensätzen.

Das Packet ggplot2 installiert sie:

`install.package(ggplot2)`

Pakete werden in R ganz zu Beginn des Skripts geladen:

```r
library(ggplot2)
```

Wo kommen R-Packages her?
========================================================

### CRAN

"Comprehensive R Archive Network" managt die offiziellen R-Versionen und die Packages

* installierbar mit `install.package()` oder `install.packages()` oder RStudio

* Packages durchlaufen Prüfung bei Upload

* über 14.000 Packages verfügbar

***

### Github

installierbar mit dem Package `devtools` und `install_github("DeveloperName/PackageName")`

* Unfertige Versionen

* Können Fehler enthalten

* Work in Progress -> schneller verfügbar, einfacher eigene Anmerkungen und Veränderungen zu machen/vorzuschlagen

* keine zentrale Übersicht, man muss die Projekte selbst finden

Packages updaten
========================================================

### CRAN

`update.packages()`

### Github

einfach nochmal `install_github("DeveloperName/PackageName")` laufen lassen

Bekannte Datensätze
========================================================

Es gibt zahlreiche Beispieldatensätze, die mit R, bzw. Packages mitgeliefert werden:

| Name in R                  | Beschreibung                                                      | Verfügbar mit |
|----------------------------|-------------------------------------------------------------------|---------------|
| AirPassengers              | Monthly Airline Passenger Numbers 1949-1960                       | R             |
| ChickWeight                | Weight versus age of chicks on different diets                    | R             |
| EuStockMarkets             | Daily Closing Prices of Major European Stock Indices, 1991-1998   | R             |
| iris / iris3               | Edgar Anderson's Iris Data                                        | R             |
| mtcars                     | Motor Trend Car Road Tests                                        | R             |
| Titanic                    | Survival of passengers on the Titanic                             | R             |
| uspop                      | Populations Recorded by the US Census                             | R             |
| diamonds                   | Prices of 50,000 round cut diamonds                               | ggplot2       |
| economics / economics_long | US economic time series                                           | ggplot2       |
| faithfuld                  | 2d density estimate of Old Faithful data (Geysir)                 | ggplot2       |
| mpg                        | Fuel economy data from 1999 and 2008 for 38 popular models of car | ggplot2       |
| nycflights13                        | Airline on-time data for all flights departing NYC in 2013 with 'metadata' on airlines, airports, weather, and planes. | eigenes Package       |

Alle Datensätze, die wir bereitstehen haben, finden wir mit `data()`

Wichtige Funktionen für Dataframes
========================================================

* head: Zeigt die ersten sechs Zeilen eines Dataframes an

* tail: Zeigt die letzten sechs Zeilen eines Dataframes an

* summary: Zeigt eine Zusammenfassung über alle Spalten hinweg an.

Übung: Bekannte Datensätze ausprobieren
========================================================

Nehmt euch etwas Zeit, ladet einen der Datensätze mit:

```
library(datasets)
data([DATENSATZ])
DATENSATZ
```

* Wie ist der Datensatz aufgebaut?

* Welche Variablen enthält er?

* Findet ihr bereits spannende Ergebnisse?

Daten einlesen
========================================================

R kann viele verschiedene Datentypen einlesen.

Die gängigsten sind:

* TXT

* TSV

* CSV

* Excel

* SPSS

* JSON

* RData

Wo sind wir?
========================================================

Immer aufpassen, wo sich R gerade in unserem Dateisystem befindet:

`getwd()`

`setwd()`

`here::here()` schafft relative Pfade im Projekt. Gut, wenn wir das Projekt mit anderen teilen wollen.

Comma separated Values
========================================================

Datenjournalistinnens Liebling

![](csv_insurance.png)

Trennung von einzelnen Daten durch `,` oder `;` (im deutschsprachigen Raum)

In R laden mit: `read.csv()` (Kommatrennung) oder `read.csv2()` (Semikolontrennung)

read.csv(): Argumente
========================================================

basiert auf `read.table()`, bei dem wir den Trenner händisch einstellen können.

`header`: TRUE oder FALSE, falls die erste Zeile die Spaltentitel enthält

`sep`: Der Trenner, hier per default ein Komma

`quote`: Die Zeichen, die dafür sorgen, dass Sätze mit Kommas nicht getrennt werden.

`dec`: Das Zeichen, das für Dezimaltrennung verwendet wird

`col.names`: eigene Titel für die Spalten als Vektor

`nrows`: maximale Anzahl der Zeilen, die eingelesen werden sollen (im Gegensatz zu `skip`, das Zeilen auslässt)

`strip.white`: Löscht Leerzeichen vor und nach Texten

`stringsAsFactors`: Wenn FALSE werden Strings nicht automatisch zu Factors umgewandelt -> empfohlen!

`fileEnconding`: Setzt manuell das Encoding (oft UTF-8). Häufiges Problem beim Wechsel zwischen Win und Mac

Nutzung von read.csv()
========================================================

```
df <- read.csv("DATEIPFAD.csv")
```

Excel
========================================================

Standardmässig kann R keine Exceldateien lesen.

Es gibt aber - wie so oft - ein Package dafür:

`install.package()`

========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================

