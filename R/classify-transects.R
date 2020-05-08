transclas <- function(tr = trans, rl = refl) {
  library(sf)
  point <- st_intersection(x = tr, y = rl)
  cutpol <- st_buffer(point, dist = 1e-6)
  tmultiline <- st_difference(tr, st_union(cutpol))
  tline <- st_cast(tmultiline, 'LINESTRING')
  tline$sealand <- ifelse(grepl('\\.', rownames(tline)), 'seaward', 'landward')
  rownames(tline) <- 1:nrow(tline)
  return(tline)
}