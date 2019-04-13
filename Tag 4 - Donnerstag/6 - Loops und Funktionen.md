6 - Loops und Funktionen
========================================================
author: Benedict Witzenberger
date: 18. April 2019
autosize: true

Recap
========================================================

Es gibt wieder eine Übung zu allem, was wir gestern gelernt haben:

Was wir heute vorhaben
========================================================

### R

Loops in R

eigene Funktionen in R

Wo bekommen wir Hilfe?

Ausblick: Visualisierung mit Base R

---

### Projekte

Wie machen wir Datenjournalismus

Unser eigenes Projekt

Loops (Schleifen) in R
========================================================

**Warum brauchen wir Loops?**

Wir wiederholen die gleichen Arbeitsschritte immer und immer wieder...

... bis ein bestimmter Zustand eingetreten ist:

* for-Loops: "bis" ein Zustand eingetreten ist

* while-Loops: "während" ein Zustand eingetreten ist (ähnlich zum repeat-Loop)

Diese Wiederholungen werden im Entwicklerslang: "Iteration" genannt

Wie Loops aussehen
========================================================

![](functions.PNG)

For-Loop I
========================================================


```r
iterator <- c(1:10)

for (i in iterator) {
  print(i)
}
```

```
[1] 1
[1] 2
[1] 3
[1] 4
[1] 5
[1] 6
[1] 7
[1] 8
[1] 9
[1] 10
```

Was ist `i`?

For-Loop II
========================================================


```r
result <- vector()

input_vector <- c(1:10)

for(i in seq_along(input_vector)) {
  result[i] <- input_vector[i] * input_vector[i]
  print(paste("i:", i, "; Result:", result[i]))
}
```

```
[1] "i: 1 ; Result: 1"
[1] "i: 2 ; Result: 4"
[1] "i: 3 ; Result: 9"
[1] "i: 4 ; Result: 16"
[1] "i: 5 ; Result: 25"
[1] "i: 6 ; Result: 36"
[1] "i: 7 ; Result: 49"
[1] "i: 8 ; Result: 64"
[1] "i: 9 ; Result: 81"
[1] "i: 10 ; Result: 100"
```

Naming Convention in For-Loops
========================================================

Die 

```
for (i in seq-along(vector1)) {
  for (j in seq_along(vector2)) {
    for (k in seq_along(vector3)) {
      do_something()
    }
  }
}
```

Denkaufgabe: For-Loops für Matrix
========================================================

Erstellt mit einem Loop eine Matrix, in der der Inhalt jedes Feldes das Produkt seiner Indizes ist.

```
mymat <- matrix(nrow=30, ncol=30)

# For each row and for each column, assign values based on position: product of two indexes
for(i in 1:dim(mymat)[]) {
  for(j in 1:dim(mymat)[]) {
    mymat[i,j] = 
  }
}
```

Tipp: Ihr müsst in der Funktion drei Sachen eintragen

Lösung: For-Loops für Matrix
========================================================


```r
mymat <- matrix(nrow=30, ncol=30)

for(i in 1:dim(mymat)[1]) {
  for(j in 1:dim(mymat)[2]) {
    mymat[i,j] = i*j
  }
}

mymat[1:10, 1:10]
```

```
      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
 [1,]    1    2    3    4    5    6    7    8    9    10
 [2,]    2    4    6    8   10   12   14   16   18    20
 [3,]    3    6    9   12   15   18   21   24   27    30
 [4,]    4    8   12   16   20   24   28   32   36    40
 [5,]    5   10   15   20   25   30   35   40   45    50
 [6,]    6   12   18   24   30   36   42   48   54    60
 [7,]    7   14   21   28   35   42   49   56   63    70
 [8,]    8   16   24   32   40   48   56   64   72    80
 [9,]    9   18   27   36   45   54   63   72   81    90
[10,]   10   20   30   40   50   60   70   80   90   100
```

Best Practises bei For-Loops
========================================================

Füllt eine Ergebnisvariable nicht IM Loop. Sie muss dann von Loop-Durchgang zu Loop-Durchgang kopiert werden, das macht den Code langsam.

Besser: Erstellt eine Ergebnisvariable (zum Beispiel Liste, Vektor oder Dataframe) VOR dem Loop. Und befüllt mit [i] nur die entsprechenden Bereiche im Loop.

Nicht:

```
for (i in seq_along(vector)) {
  loop_-_result <- compute_something()
  result_variable <- c(result_variable, loop_result)
}
```

Besser:

```
result_variable <- vector(length = length(input_vector))

for (i in seq_along(input_vector)) {
  loop_result <- compute_something()
  result_variable[i] <- loop_result
}
```
Bei Dataframes
========================================================

```
result_list <- list()

for (i in seq_along(input_vector)) {
  loop_result_df <- compute_something()
  result_list[[i]] <- loop_result_df
}

dplyr::bind_rows(result_list)
```

dplyr lernt ihr im nächsten Blockkurs genauer kennen.




For-Loops gibt es in vielen Sprachen
========================================================

Java:

```
// Prints the numbers 0 to 99 (and not 100), each followed by a space.
for (int i=0; i<100; i++)  
{
    System.out.print(i);
    System.out.print(' ');
}
System.out.println();
```

Python:

```
for item in some_iterable_object:
    do_something()
```


Wann brauchen wir For-Loops in R?
========================================================

* Viele Daten einlesen und bearbeiten

* Viele Webseiten scrapen

Eher nicht bei:

* Mehrere Variablen eines Dataframes verändern

* Mehrere Rechnungen mit Vektoren anstellen

Vorsicht bei For-Loops I
========================================================


```r
a <- c(1:10)
b <- c(1:10)

res <- numeric(length = length(a))
for (i in seq_along(a)) {
  res[i] <- a[i] + b[i]
}
res
```

```
 [1]  2  4  6  8 10 12 14 16 18 20
```

Was macht die For-Schleife?

Vorsicht bei For-Loops II
========================================================

Für viele Vektoroperationen gibt es einfacherere - und schnellere Alternativen, als eine For-Schleife:

Hier, eine einfache Summe.


```r
res2 <- a + b

all.equal(res, res2) # testet, ob die Variablen gleich sind
```

```
[1] TRUE
```

Apply-Familie in R
========================================================

Loops, die ihr über Vektoren laufen lassen wollt, können oft mit Apply kombiniert werden.
Diese Funktionen sind deutlich schneller, als For-Loops (wird daher erst bei großen Datensätzen interessant)

* Apply: `apply(X, MARGIN, FUN, ...)`, MARGIN sind die Zeilen und Spalten einer Matrix (oder eines Dataframes). Es geht auch `MARGIN = c(1,2)`. FUN kann jede beliebige (auch selbst geschriebene Funktion sein).

* Lapply: Gibt die Ergebnisse der Apply-Berechnung als Liste zurück. Jedes Ergebnis ist ein Element der Liste.

* Sapply: Funktioniert wie Lapply, versucht aber, das Ergebnis als Vektor oder Matrix auszugeben.

* Vapply: Hier gibt der Nutzer vorher ein, welche Klasse das Ergebnis haben soll, z.B. `VUN.VALUE = character(1)`

Apply bei einer Matrix I
========================================================


```r
matrix_x <- cbind(x1 = 3, x2 = c(4:1, 2:5))

dimnames(matrix_x)[[1]] <- letters[1:8]
matrix_x
```

```
  x1 x2
a  3  4
b  3  3
c  3  2
d  3  1
e  3  2
f  3  3
g  3  4
h  3  5
```


```r
apply(matrix_x, 2, mean, trim = .2)
```

```
x1 x2 
 3  3 
```

Apply bei einer Matrix II
========================================================


```r
col.sums <- apply(matrix_x, 2, sum)
row.sums <- apply(matrix_x, 1, sum)
rbind(cbind(matrix_x, Rtot = row.sums), Ctot = c(col.sums, sum(col.sums)))
```

```
     x1 x2 Rtot
a     3  4    7
b     3  3    6
c     3  2    5
d     3  1    4
e     3  2    5
f     3  3    6
g     3  4    7
h     3  5    8
Ctot 24 24   48
```

Lapply, Sapply
========================================================


```r
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))

lapply(x, quantile)
```

```
$a
   0%   25%   50%   75%  100% 
 1.00  3.25  5.50  7.75 10.00 

$beta
         0%         25%         50%         75%        100% 
 0.04978707  0.25160736  1.00000000  5.05366896 20.08553692 

$logic
  0%  25%  50%  75% 100% 
 0.0  0.0  0.5  1.0  1.0 
```

```r
sapply(x, quantile)
```

```
         a        beta logic
0%    1.00  0.04978707   0.0
25%   3.25  0.25160736   0.0
50%   5.50  1.00000000   0.5
75%   7.75  5.05366896   1.0
100% 10.00 20.08553692   1.0
```

Vapply
========================================================


```r
vapply(x, mean, numeric(1))
```

```
       a     beta    logic 
5.500000 4.535125 0.500000 
```

Übung: Vapply
========================================================

Beim folgenden Code scheitert `sapply()`. Woran könnte das liegen?

Und: Wie könnten wir vapply benutzen, um zu merken, dass wir in einen Fehler laufen??


```r
market_crash <- list(dow_jones_drop = 777.68, 
                      date = as.POSIXct("2019-04-01"))

lapply(market_crash, class)
```

```
$dow_jones_drop
[1] "numeric"

$date
[1] "POSIXct" "POSIXt" 
```

```r
sapply(market_crash, class)
```

```
$dow_jones_drop
[1] "numeric"

$date
[1] "POSIXct" "POSIXt" 
```

Lösung: Vapply
========================================================

So geht der Test mit vapply - die Funktion wirft einen Fehler aus, weil die beiden Ergebnisse nicht ein einzelner `character` sind:

```
vapply(market_crash, class, FUN.VALUE = character(1))

> vapply(market_crash, class, FUN.VALUE = character(1))
Error in vapply(market_crash, class, FUN.VALUE = character(1)) : 
  values must be length 1,
 but FUN(X[[2]]) result is length 2
```
So würde es funktionieren, wir wandeln die `POSIXcts` in `characters´ um:


```r
vapply(market_crash, FUN = function(x) paste(class(x), collapse = "; "),
       FUN.VALUE = character(1))
```

```
   dow_jones_drop              date 
        "numeric" "POSIXct; POSIXt" 
```

While und Repeat
========================================================

Es gibt noch zwei weitere Wege: While und Repeat

Ein Beispiel für While (muss man nacheinander ausführen):

```
readinteger <- function(){
  n <- readline(prompt="Please, enter your ANSWER: ")
}

response <- as.integer(readinteger())

while (response!=42) {   
  print("Sorry, the answer to whatever the question MUST be 42");
  response <- as.integer(readinteger());
}
```

Repeat ist eine Variante von While
========================================================

Dabei wird der `repeat`-Block wenigstens einmal ausgeführt.

```
readinteger <- function(){
  n <- readline(prompt="Please, enter your ANSWER: ") 
}

repeat {   
  response <- as.integer(readinteger());
  if (response == 42) {
    print("Well done!");
    break
  } else print("Sorry, the answer to whatever the question MUST be 42");
}
```

Break und next
========================================================

Neben For, while und repeat gibt es noch zwei Befehle, die die Schleifen steuern können:

* `break;` beendet den aktuellen Loop sofort. Zum Beispiel hilfreich, wenn ein Fehler auftritt.

* `next;` beendet den aktuellen Durchgang und beginnt den nächsten Durchgang vom Beginn des Loops (i wird also i+1)

Next-Beispiel
========================================================


```r
m=20

for (k in 1:m){
  if (!k %% 2)
    next
    print(k)
}
```

```
[1] 1
[1] 3
[1] 5
[1] 7
[1] 9
[1] 11
[1] 13
[1] 15
[1] 17
[1] 19
```

Fazit: Schleifen
========================================================

Es gibt **drei verschiedene Varianten** Schleifen zu schreiben:

* For

* While

* Repeat

Und **zwei Befehle** um die Schleifen zu steuern:

* break

* next

Eigene Funktionen schreiben
========================================================

Wir können mehrere Arbeitsschritte in R kombinieren und eigene Funktionen schreiben.

Zum Beispiel, wenn wir mehrmals dieselben Cleaning-Schritte für unsere Datensätze ausführen wollen.

Funktionen in R sind einfach aufgebaut, wir kennen das Muster schon:

```
function(ARGUMENTE) {BODY}
```

Eine Funktion, die keinem Namen zugewiesen wird, heißt "anonyme Funktion"

**Best Practise**: Benennt eure eigenen Funktionen anders, als bereits bestehende Funktionen. Das macht nur Ärger.

Formals, Body, Environment
========================================================

Beim Erstellen einer Funktion passieren drei Sachen:

* formals() (oder: Argumente) wird explizit angegeben

* body() wird explizit angegeben

* environment() wird implizit angegeben

Die Funktionselemente
========================================================


```r
f01 <- function(x, y) {
  x + y
}

formals(f01)
```

```
$x


$y
```

```r
body(f01)
```

```
{
    x + y
}
```

```r
environment(f01)
```

```
<environment: R_GlobalEnv>
```

f01
========================================================

```
> f01()
Error in f01() : argument "x" is missing, with no default
```


```r
f01(x = 1, 5) # y kann, muss aber nicht angegeben werden, weil die Position vorgegeben ist
```

```
[1] 6
```

Environment
========================================================

Globale Umgebung:

```
> ls(environment())
[1] "f01"
```

### Globale vs. lokale Umgebung:


```r
x <- 10
f02 <- function(y) {
  sum(y * x)
}
f02(4)
```

```
[1] 40
```

Warum wird die Variable x beachtet, obwohl sie nicht in der Funktion steht?

Welchen Wert nimmt y an, wenn ich sie außerhalb der Funktion ausgebe?

Globale vs. lokale Umgebung
========================================================

```
> x <- 10
> f02 <- function(y) {
+     sum(y * x)
+ }
> y
Error: object 'y' not found
```
Die Variable y ist nicht in der globalen Umgebung, nur in der lokalen Umgebung der Funktion `f02` (genannt: Scope der Funktion).

Nachteil: Wir können sie nicht einfach aufrufen.

Vorteil: Die Variable funkt uns nicht in andere Funktionen dazwischen.


```r
x <- 10
f02 <- function(y) {
  x <- 5  
  sum(y * x)
}
```

Was passiert hier?

========================================================


```r
x <- 10
f02 <- function(y) {
  x <- 5  
  sum(y * x)
}
f02(4)
```

```
[1] 20
```



Funktion exportieren
========================================================

Die einfachste Variante, eine Funktion zu exportieren, ist, sie als `*.R`-Datei zu speichern.

Im anderen Skript wird sie so aufgerufen und der dortigen globalen Umgebung hinzugefügt:

`source("FUNKTION.R")`

Hinweis: Man kann auch mehrere Funktionen in eine`*.R`-Datei schreiben.

========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
========================================================
