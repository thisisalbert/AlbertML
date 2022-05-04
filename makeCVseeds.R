makeCVseeds <- function(
    tunes = NULL, numCV = 10, repeatsCV = NULL, type = c("tuneGrid", "tuneLength")
) {
  
  if (type %in% c("tuneGrid", "tuneLength") == FALSE) {
    stop("Only 'tuneGrid' or 'tuneLength' is accepted for 'type'")
  }
  
  # When tuneLength is used
  
  if (type == "tuneLength") {
    c(
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
    c(
      replicate(
        expr = sample.int(n = 2^15, size = 1, replace = FALSE),
        n = ifelse(is.null(repeatsCV), numCV, repeatsCV * numCV),
        simplify = FALSE
      ),
      sample.int(n = 2^15, size = 1, replace = FALSE)
    )  
  }
  
}
