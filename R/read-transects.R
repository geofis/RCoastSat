rtrans <- function(x) {
  library(sf)
  t <- st_read(x)
  t <- t[,-(1:ncol(t))]
  t$transect <- factor(1:nrow(t))
  return(t)
}
