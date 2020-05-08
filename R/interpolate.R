interpolate <- function(data, ...) {
  x_range <- range(data[,'date', drop=T])
  x <- seq(x_range[1], x_range[2], length.out = 10000)
  df <- as.data.frame(approx(data[,'date', drop=T], data[,'distance_sign', drop = T], x))
  df$transect <- unique(data[,'transect', drop=T])
  colnames(df) <- c('date', 'distance_sign', 'transect')
  return(df)
}