pointdist <- function(sh = shl, re = refl, tr = trans, rtr = rawtrans) {
  library(tidyverse)
  library(sf)
  ptsref <- st_intersection(rtr, re) %>%
    mutate(sealand='ref') %>%
    mutate(x=unlist(map(geometry,1)),
           y=unlist(map(geometry,2)))
  ptsshl <- st_intersection(tr, sh) %>%
    mutate(x=unlist(map(geometry,1)),
           y=unlist(map(geometry,2)))
  pts <- rbind(ptsref, ptsshl)
  trindex <- unique(tr[,'transect', drop=T])
  distances <- map(trindex,
                   function(i) {
                     refi <- ptsref %>% filter(transect==i)
                     ptsi <- pts %>% filter(transect==i)
                     ptsid <- ptsi %>%
                       mutate(
                         distance = st_distance(., refi) %>% units::drop_units(),
                         distance_sign = case_when(
                           sealand == 'landward' ~ 0-distance,
                           sealand == 'seaward' ~ distance,
                           sealand == 'ref' ~ 0))
                     return(ptsid)
                   }
  )
  return(distances)
}
