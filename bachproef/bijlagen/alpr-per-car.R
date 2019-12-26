# Show overview per picture

# Load data
library(readr)
library(data.table)
alpr <- read_csv("Documents/Bachelorproef-HoGent/alpr/alpr2.csv")
alpr$correct <- (!is.na(alpr$result) & alpr$license_plate == alpr$result)

# Evaluate data per exit
subalpr <- alpr[ which(alpr$location == "coupure-kruisboogstraat"), ]
tab <- data.frame(subalpr$license_plate, subalpr$correct)
t <- setNames(aggregate(
  tab[,2], 
  list(tab$subalpr.license_plate), 
  function(x) sum(x) > 0), c("car", "one_correct"))
kruis <- table(t[,2])

subalpr <- alpr[ which(alpr$location == "sterre-galglaan"), ]
tab <- data.frame(subalpr$license_plate, subalpr$correct)
t <- setNames(aggregate(
  tab[,2], 
  list(tab$subalpr.license_plate), 
  function(x) sum(x) > 0), c("car", "one_correct"))
galg <- table(t[,2])

subalpr <- alpr[ which(alpr$location == "sterre-depintelaan4"), ]
tab <- data.frame(subalpr$license_plate, subalpr$correct)
t <- setNames(aggregate(
  tab[,2],
  list(tab$subalpr.license_plate), 
  function(x) sum(x) > 0), c("car", "one_correct"))
pint <- table(t[,2])

# Create an overview table
tab <- rbind(kruis, galg, pint)
tab <- addmargins(tab)
tab <- cbind(tab, (tab[,2]/tab[,3]))
colnames(tab) <- c("Incorrect", "Correct", "Totaal", "Ratio")
rownames(tab) <- c("Campus Coupure - Uitgang Kruisboogstraat",  
                   "Campus Sterre - Uitgang Galglaan", 
                   "Campus Sterre - Uitgang De Pintelaan",
                   "Totaal")
tab