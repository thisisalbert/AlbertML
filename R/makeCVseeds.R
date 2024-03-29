makeCVseeds <- function(
	type = c("tuneGrid", "tuneLength"), tunes = NULL, numCV = NULL, repeatsCV = NULL
) {
  
  if (type %in% c("tuneGrid", "tuneLength") == FALSE) {
    stop("Only 'tuneGrid' or 'tuneLength' is accepted for 'type'")
  }
  
  # When tuneLength is used
  
  if (type == "tuneLength") {
    seeds <- c(
      replicate(
        expr = sample.int(n = 2^15, size = tunes, replace = FALSE),
        n = ifelse(is.null(repeatsCV), numCV, repeatsCV * numCV),
        simplify = FALSE
      ),
      sample.int(n = 2^15, size = 1, replace = FALSE)
    )
  }
  
  # When tuneGrid is used
  
  if (type == "tuneGrid") {
    seeds <- c(
      replicate(
        expr = sample.int(n = 2^15, size = 1, replace = FALSE),
        n = ifelse(is.null(repeatsCV), numCV, repeatsCV * numCV),
        simplify = FALSE
      ),
      sample.int(n = 2^15, size = 1, replace = FALSE)
    )  
  }
  
  return(seeds)
  
}
