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

* Arbeiten mit Dataframes

* Daten einlesen

* Daten vorbereiten

* Packages installieren und laden

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

[1] ruft das erste Element in einem Vektor auf.

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

Jetzt funktionert auch leeres Subsetting - dann werden alle Zeilen oder Spalten zurückgegeben:

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
