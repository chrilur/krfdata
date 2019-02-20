#Binde sammen KrF-lister

setwd("fylkeslister")

filer <- dir()
fylker <- c("Akershus", "Buskerud", "Hedmark", "Møre og Romsdal", "Nordland", "Oppland", "Oslo", "Østfold", "Rogaland", "Sogn og Fjordane", "Telemark", "Vestfold")

last.inn <- function (x) {
	df <- read.csv(filer[x], stringsAsFactors=FALSE)
	df$Fylke <- fylker[x]
	return(df)
}

lag.liste <- function(x) {
	df <-  last.inn(x)
	liste <<- rbind(liste,df)
}

liste <- data.frame()
sapply(1:12, function(x) lag.liste(x))

write.csv(liste, "fylkesliste.csv", row.names=FALSE)

library(xlsx)
library(dplyr)
setwd("C:\\Users\\n633164\\OneDrive - NRK\\Saker\\krf")
master <- read.xlsx("krf-master.xlsx", 1, header = TRUE, encoding="UTF-8")

liste <- liste %>% mutate(paste0("+", Tlf))
names(liste) <- c("Rolle", "Navn", "Tlf", "Mobil", "Fylke")

rest <- anti_join(liste, master, by="Mobil")