calcConfInt <- function(x, perc = 0.95) {
  x %>%
    t.test(conf.level = perc) %>%
    chuck("conf.int") %>%
    as.numeric() %>%
    formatC(digits = 3, format = "f") %>%
    paste(collapse = "-")
}
