makeCVseeds <- function(tuneLength = NULL, numCV = 10, repeatsCV = NULL) {
  
  c(
    replicate(
      expr = sample.int(n = 2^15, size = tuneLength, replace = FALSE),
      n = ifelse(is.null(repeatsCV), numCV, repeatsCV * numCV),
      simplify = FALSE
    ),
    sample.int(n = 2^15, size = 1, replace = FALSE)
  )  
  
}
