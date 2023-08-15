makePB <- function(total_n) {
  require("progress")
  progress_bar$new(
    format = "[:bar] :percent ETA: :eta",
    total = total_n,
    width = 50,
    clear = FALSE
  )
}

# In case of using the function in a loop, make sure to use:
# pb <- makePB(total_iterations)
# (start of the loop) pb$update(i/total_iterations)
# (end of the loop) pb$terminate()
