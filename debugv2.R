library(dplyr)
library(sf)

library(svDialogs)

# FCoord varie selon qu’on soit sur les observations ou de la préparation
# de données de prédiction

train <- FALSE # Si on veut entrainer le modèle, sinon predict
if (!train) {
  date_pred <- as.character(dlgInput("Input date (YYYY-MM-dd): ")$res)
}

a  <- Sys.time()
test1 <- list()
b <- Sys.time()


OccSL <- read.csv("data/SysGrid_500m_de_cote.csv") %>%
  dplyr::select(c("X", "Y"))

c  <- Sys.time()
test2 <- list()
d <- Sys.time()

OccSL$FID <- c(1:nrow(OccSL))
OccSL <- OccSL %>%
  st_as_sf(coords = c("X", "Y"), crs = 4326, remove = FALSE)

e  <- Sys.time()
test3 <- list()
f <- Sys.time()


OccSL_L93 <- OccSL %>%
  st_transform(2154)
OccSL_L93$Nuit <- date_pred

g  <- Sys.time()
test3 <- list()
h <- Sys.time()

print("Test 1 before loading csv")
print(b - a)

print("Test 2 after loading csv")
print(d - c)

print("Test 3 after sf")
print(f - e)

print("Test 2 after st_transform")
print(h - g)

