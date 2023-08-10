makePB <- function(total_n) {
  loadNamespace("progress")
  progress_bar$new(
    format = "[:bar] :percent ETA: :eta",
    total = total_n,
    width = 50,
    clear = FALSE
  )
}
