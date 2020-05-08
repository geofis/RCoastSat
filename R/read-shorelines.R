rshl <- function(x) {
  library(sf)
  s <- st_read(x)
  return(s)
}