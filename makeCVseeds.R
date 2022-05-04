makeCVseeds <- function(tuneLength = NULL, numCVs = 10, repeatsCV = NULL) {
  
  c(
    replicate(
      expr = sample.int(n = 2^15, size = tuneLength, replace = FALSE),
      n = if_else(repeatsCV == NULL, numCVs, repeatsCV * numCVs),
      simplify = FALSE
    ),
    sample.int(n = 2^15, size = 1, replace = FALSE)
  )
  
}
