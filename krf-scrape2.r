#krf-scrape2: lokallag
#Vasker HTML-data og putter navn og telefonnumre i et Excel-ark

library(xlsx)
master <- read.xlsx("C:\\Users\\n633164\\OneDrive - NRK\\Saker\\krf\\krf-master241018.xlsx", sheetIndex = 1, encoding = "UTF-8", stringsAsFactors=FALSE)

##setwd("krf")

library(rvest)
library(dplyr)

fil <- as.character(readline("Filnavn: "))
fil <- paste0("fylkeslister/lokallag/raafiler/", fil, ".xlsx")

f <- as.character(readline("Fylke: "))

fylke <- read.xlsx(fil, sheetIndex = 1, encoding = "UTF-8", stringsAsFactors=FALSE, header= FALSE) 

kol1 <- seq(1, nrow(fylke), by=4)
kol2 <- seq(2, nrow(fylke), by=4)
kol3 <- seq(3, nrow(fylke), by=4)
kol4 <- seq(4, nrow(fylke), by=4)

rolle <- na.omit(fylke[kol1,1])
navn <- na.omit(fylke[kol2,1])
tlf <- na.omit(fylke[kol3,1])
epost <- na.omit(fylke[kol4,1])
kommune <- na.omit(fylke[kol1,2])

tlf <- paste0("+47", tlf)

df <- data.frame(Mobil = tlf, Navn = navn, Fylke = f, Lokallag = kommune, Rolle = rolle, Epost = epost)
df[,1] <- as.character(df[,1])
df[,2] <- as.character(df[,2])
df[,3] <- as.character(df[,3])
df[,4] <- as.character(df[,4])
df[,5] <- as.character(df[,5])
df[,6] <- as.character(df[,6])

df <- anti_join(df, master, by="Mobil")
df <- distinct(df, Mobil, .keep_all=TRUE)

utfil <- paste0("fylkeslister/lokallag/", f, ".xlsx")

write.xlsx(df, utfil, row.names=FALSE)