library(dplyr)
library(sf)

library(svDialogs)

# FCoord varie selon qu’on soit sur les observations ou de la préparation
# de données de prédiction

train <- FALSE # Si on veut entrainer le modèle, sinon predict
if (!train) {
  date_pred <- as.character(dlgInput("Input date (YYYY-MM-dd): ")$res)
}

 OccSL <- read.csv("data/SysGrid_500m_de_cote.csv") %>%
      dplyr::select(c("X", "Y"))

    OccSL$FID <- c(1:nrow(OccSL))
    OccSL <- OccSL %>%
      st_as_sf(coords = c("X", "Y"), crs = 4326, remove = FALSE)

    OccSL_L93 <- OccSL %>%
      st_transform(2154)
    OccSL_L93$Nuit <- date_pred

a  <- Sys.time()
test <- list()
b <- Sys.time()

print(b-a)
