# Show overview per picture

# Load data
library(readr)
library(data.table)
alpr <- read_csv("Documents/Bachelorproef-HoGent/alpr/alpr2.csv")
alpr$correct <- (!is.na(alpr$result) & alpr$license_plate == alpr$result)

# Evaluate data per exit
subalpr <- alpr[ which(alpr$location == "coupure-kruisboogstraat"), ]
kruis <- table(subalpr$correct)

subalpr <- alpr[ which(alpr$location == "coupure-coupurelinks"), ]
coup <- table(subalpr$correct)

subalpr <- alpr[ which(alpr$location == "sterre-galglaan"), ]
galg <- table(subalpr$correct)

subalpr <- alpr[ which(alpr$location == "sterre-depintelaan4"), ]
pint <- table(subalpr$correct)

# Create an overview table
tab <- rbind(kruis, coup, galg, pint)
tab <- addmargins(tab)
tab <- cbind(tab, (tab[,2]/tab[,3]))
colnames(tab) <- c("Incorrect", "Correct", "Totaal", "Ratio")
rownames(tab) <- c("Campus Coupure - Uitgang Kruisboogstraat",  
              "Campus Sterre - Uitgang Galglaan", 
              "Campus Sterre - Uitgang De Pintelaan",
              "Totaal")
tab
