# In dieser Übung lesen wir eine unveränderte Datei des Statistischen Bundesamts ein.
# Es geht um einen Datensatz zu Straßenverkehrsunfällen von 2008 bis 2017.
# Die genaue Beschreibung findet ihr www-genesis.destatis.de unter der Tabelle 46241-0001

# 1. Lies die Datei Unfaelle_Destatis_46241-0001.csv als Dataframe ein. 
# Du stößt dabei auf ein Problem: 
# Das statistische Bundesamt benutzt einen Header mit vielen Zeilen. Den ignorieren wir.
# Ausserdem steht unter den Daten ein Copyright, das muss auch weg.
# In R helfen Dir beim Einlesen die Argumente header, skip und col.names

df <- read.csv2("Unfaelle_Destatis_46241-0001.csv", header = F, skip = 10, nrows = 10, 
                col.names = c(
  "Jahr", "Personen_innerorts", "Personen_ausserorts", "Personen_BAB", "Personen_Total", 
  "Sachschaden_innerorts", "Sachschaden_ausserorts", "Sachschaden_BAB", "Sachschaden_Total",
  "Berauscht_innerorts", "Berauscht_ausserorts", "Berauscht_BAB", "Berauscht_Total",
  "Uebrige_innerorts", "Uebrige_ausserorts", "Uebrige_BAB", "Uebrige_Total", 
  "Insgesamt_innerorts", "Insgesamt_ausserorts", "Insgesamt_BAB", "Insgesamt_Total"
))

# 2. Lasse Dir jetzt die Struktur der Daten anzeigen. Wurden alle im korrekten Format eingelesen?

str(df)

# 3. In welchem Jahr gab es die meisten Unfälle auf der Autobahn (BAB)?

df[df$Insgesamt_BAB == max(df$Insgesamt_BAB),]

# 4. In welchem Jahr gab es die meisten Personenschäden?

df[df$Personen_Total == max(df$Personen_Total),]

# 5. Lasse Dir alle Werte für das Jahr 2010 anzeigen.

df[df$Jahr == 2010,]

# 6. Was ist der höchste Wert aller Werte im Jahr 2010?
max(df[df$Jahr == 2010,])

# 7. Versuche einen einfachen Graphen zu zeichnen, der die Gesamtzahl der Unfälle nach Jahren abbildet.
# Nutze dafür die Funktion plot(), schreibe danach darunter die Funktion lines() und rufe diese mit plot zusammen auf.
plot(df$Jahr, df$Insgesamt_Total)
lines(df$Jahr, df$Insgesamt_Total)

# Was passiert wenn Du einen neuen plot() aufrufst, und als Argument `type = "l"` eingibst?
plot(df$Jahr, df$Insgesamt_Total, type = "l")


###
# Exkurs
###

# Der sog. multi-line header bei DESTATIS ist ein fieses Problem für deutsche Datenjournalisten.
# Als Lösung könnt ihr die Bibliothek `destatiscleaner` auf Github suchen, oder eine eigene Funktion schreiben.
# Ich habe das für euch gemacht, wenn ihr wollt, schaut, ob ihr sie verstehen könnt.

df <- read.csv2("Unfaelle_Destatis_46241-0001.csv", header = F)
skip_before <- 6
header_length <- 4 

clean_destatis_header <- function(df, skip_before, header_length = 1) {
  df <- df[(skip_before + 1):(skip_before + header_length),]
  
  colnames <- unlist(lapply(df, paste, collapse = "_"))
  colnames
}

# Das Ergebnis könnte so angewendet werden:

df <- read.csv2("Unfaelle_Destatis_46241-0001.csv", header = F)
colnames(df) <- clean_destatis_header(df, skip_before = 6, header_length = 4)
df <- df[11:20,]


   
