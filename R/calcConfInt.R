calcConfInt <- function(x, perc = 0.95) {
  if (var(x, na.rm = TRUE) == 0) {
    return(x)
  } else {
    x %>%
      t.test(conf.level = perc, na.action = na.omit) %>%
      chuck("conf.int") %>%
      as.numeric() %>%
      formatC(digits = 3, format = "f") %>%
      paste(collapse = "-")  
  }
}
