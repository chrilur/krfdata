###Slår sammen flere lister til en

 library(xlsx)

 total <- read.xlsx("fylkeslister/lokallag/supertotal.xlsx", sheetIndex = 1, encoding = "UTF-8", stringsAsFactors=FALSE, header=TRUE)
 gml <- read.xlsx("fylkeslister/lokallag/gmltotal.xlsx", sheetIndex = 1, encoding = "UTF-8", stringsAsFactors=FALSE, header=TRUE)

gml$Epost <- "xxx"

gml <- gml %>% filter(!is.na(Nummer))
#data = data %>% select(Time, out, In, Files)
tlf <- gml$Nummer
tlf <- gsub("\\+", "", tlf)
tlf <- gsub(" ", "", tlf)
tlf <- paste0("+", tlf)
gml$Mobil <- tlf

gml <- gml %>% select(Mobil, Navn, Delegasjon, Lokallag, Landsmøtedelegat., Epost)
names(gml) <- c("Mobil", "Navn", "Fylke", "Lokallag", "Rolle", "Epost")

total <- rbind(total, gml)
total <- distinct(total, Mobil, .keep_all = TRUE)

write.xlsx(total, "fylkeslister/lokallag/NYsupertotal.xlsx", row.names = FALSE)

path <- "C:\\Users\\n633164\\OneDrive - NRK\\Saker\\krf\\"
fil <- paste0(path,"Liveloggundersøkelse2-3638558.xlsx")

svar <- read.xlsx(fil, sheetIndex = 1, encoding = "UTF-8", stringsAsFactors=FALSE, header=TRUE)

svar <- svar %>% rename(Mobil = Respondent)
svar <- svar %>% rename(hoved = X1..Hva.vil.du.helst.at.KrF.skal.gjøre.i.inneværende.stortingsperiode.)
svar <- svar %>% rename(opp_reg = X2..Hva.vil.du.velge., regjmakt = X3..Hvem.bør.KrF.søke.regjeringsmakt.med., Annet = X4..Har.du.noe.annet.du.vil.fortelle.oss.om.regjeringsspørsmålet.)
svar <- svar %>% rename(Navn = X5.0..Navn, Delegasjon = X6.0..Delegasjon.fra, sendt = X7.0..Sendt.ut)

#df <- full_join(total, svar, by = Mobil)

agder <- svar %>% filter (Delegasjon == "Agder")

fjern <- c(19, 31,33,36,54)
agder[fjern,6] <- " "