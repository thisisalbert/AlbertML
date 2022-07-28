makeRFEseeds <- function(sizes, repeatsCV = NULL, numCV) {
  return(
    c(
      replicate(
        expr = sample.int(n = 2^15, size = sizes, replace = FALSE),
        n = ifelse(is.null(repeatsCV), numCV, repeatsCV * numCV),
        simplify = FALSE
      ),
      sample.int(n = 2^15, size = 1, replace = FALSE)
    )
  )
}
