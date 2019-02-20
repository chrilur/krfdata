#krf-scrape
#Skraper fylkesstyrelister

library(rvest)
library(tidyverse)

baseurl <- "https://krf.no/partiorganisasjonen/fylkes-og-lokallag/"
resturl <- "/fylkesledelsen/"
fylke <- readline("Fylke: ")

url3 <- paste0(baseurl, fylke, resturl)

#Funksjon som henter èn forekomst
get.stuff <- function(x) {
	div <- paste0("div.col-sm-", x)
	url3 %>%
		read_html() %>%
		html_nodes(div) %>%
		html_text()
}

#Trimme teksten
trim <- function(y) {
	data <- gsub("\\n", "", y)
	data <- trimws(data)
	data <- data[-1]
	return(data)
}

l1 <- get.stuff(3)
l2 <- get.stuff(2)
l3 <- get.stuff(4)

l1l <- length(l1)
rolle <- seq(1,l1l-1, by=2)
navn <- seq(2, l1l, by=2)
navn <- l1[navn]
rolle <- l1[rolle]

rolle <- trim(rolle)
navn <- trim(navn)
tlf <- trim(l2)
tlf <- gsub(" ", "", tlf)
ltlf <- length(tlf)
tlf <-  if(ltlf - length(navn) == 1) head(tlf, ltlf-1) else tlf

df <- data.frame(Rolle=rolle, Navn = navn, Tlf = tlf)
df <- df[-grep("Rolle", df$Rolle),]

fil <- paste0("fylkeslister/", fylke, ".csv")

write.csv(df,fil,row.names=FALSE)

#Mangler Finnmark, Troms, Trøndelag, Agder

url4 <- "https://krf.no/partiorganisasjonen/fylkes-og-lokallag/finnmark/"

url4 %>%
	read_html() %>%
	html_nodes("table") %>% html_table()