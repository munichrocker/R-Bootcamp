#### Skript aufsetzen ####
setwd("/home/kira/Nextcloud/Journocode/Workshops/ifp/Material/Block 3 - Kira/scraping")
library(rvest);library(dplyr)


#### Erste Seite testweise scrapen ####


#Source Code Abschnitte mit Projektinfos holen
tmp = read_html("https://datajournalismawards.org/projects/") %>%
  html_nodes(".col-project__content")

#Relevante Daten herausfiltern
title =   tmp %>% html_nodes("h3 > a") %>% html_text()
by =      tmp %>% html_nodes("p > span") %>% html_text() %>% gsub("Project by\n","",.) %>% trimws()
country = tmp %>% html_nodes("p > em") %>% html_text()
link =    tmp %>% html_nodes("h3 > a") %>% html_attr("href")
excerpt = tmp %>% html_nodes(".project-excerpt") %>% html_text()

#Zu Data Frame kombinieren
dja = data.frame(title, by, country, link, excerpt, stringsAsFactors = F)

#Aufräumen
rm(list = ls())


#### Alle Seiten im loop scrapen ####

# Leere Liste und Counter initialisieren
n = 142; d = vector("list", length=n)

# Liste mit zu scrapenden Links bauen
l = paste0("https://datajournalismawards.org/projects/page/",1:n)


# Durch alle 142 Seiten loopen
for( i in 1:n ) {
    #Statusanzeige in der Konsole
    cat(i, "of", n, "\n")
  
    #Source Code Abschnitte mit Projektinfos holen
    tmp = read_html(l[i]) %>% html_nodes(".col-project__content")
    
    #Relevante Daten herausfiltern
    title =   tmp %>% html_nodes("h3>a") %>% html_text()
    by =      tmp %>% html_nodes("p > span") %>% html_text() %>% gsub("Project by\n","",.) %>% trimws()
    country = tmp %>% html_nodes("p > em") %>% html_text()
    link =    tmp %>% html_nodes("h3>a") %>% html_attr("href")
    excerpt = tmp %>% html_nodes(".project-excerpt") %>% html_text()
    
    #Zu Data Frame kombinieren und in Liste abspeichern
    d[[i]] = data.frame(title, by, country, link, excerpt, stringsAsFactors = F)
}
#Aufräumen
rm(i, n, l, tmp, title, by, country, link, excerpt)

#Listenelemente zu einem großen data frame zusammenfassen
dja = bind_rows(d)

#Data cleaning: Autor und Organisation als einzelne Spalten speichern, Spaltenreihenfolge umsortieren
dja = dja %>%
    mutate(author = gsub("[\r\t\n]+.+","", by),
           organisation = gsub(".+: ","", by),
           excerpt = gsub("[\r\t\n\\]+","", excerpt)) %>% 
    select(title, author, organisation, country, link, excerpt)

#Datensatz als CSV schreiben
write.csv2(dja, "dja.csv", row.names = F, na = "")

