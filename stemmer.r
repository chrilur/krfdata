##Beregner antall stemmer bak hver delegat

avd <- c("Østfold", "Akershus", "Oslo", "Hedmark", "Oppland", "Buskerud", "Vestfold", "Telemark", "Aust-Agder", 
	"Vest-Agder", "Rogaland", "Hordaland", "Sogn og Fjordane", "Møre og Romsdal", "Sør-Trøndelag", "Nord-Trøndelag", 
	"Nordland", "Troms", "Finnmark", "Sentralstyret", "Stortingsgruppen", "KrF Kvinner", "KrFU")

medl <- c(1496, 1542, 945, 511, 607, 740, 981, 911, 1059, 1858, 4607, 3378, 1119, 2653, 1251, 704, 816, 531, 230, NA, NA, NA, NA)

valg17 <- c(6811, 7839, 7843, 2051, 2281, 3995, 5159, 4825, 6352, 12747, 21092, 16513, 2683, 9017, 4974, 2115, 3284, 2408, 808, NA, NA, NA, NA)

del <- c(8,9,7,6,6,6,7,6,8,10,16,14,7,12,7,6,6,6,4,11,4,12,12)

krf <- data.frame(Fylke = avd, Medlemmer = medl, Stemmer = valg17, Delegater = del)

krf$S/D <- krf$Stemmer / krf@Delegater

Stemmer.pr.del <- round(valg17/del, digits = 0)
Medlemmer.pr.del <- round(medl/del, digits = 0)

krf <- cbind(krf, Stemmer.pr.del, Medlemmer.pr.del)