## Daten bereinigen
# Erstmal installieren wor die Pakete, die wir benutzen wollen.
# Immer, wenn wir an ein Problem stoßen, für das wir ein 
# weiteres Paket brauchen, gehen wir hierher zurück, fügen es hinu
# und führen diese Zeile nochmals aus
#library(needs)
needs(tidyverse, magrittr)

# Im Datenordner liegt ein Datensatz namens "ew19_untidy.csv"
ew19_untidy <- read.csv("Daten/ew19_untidy.csv", sep=";")
# Lesen wir ihn ein, sehen wir, dass wir einige Probleme haben.