customTolerance <- function (x, metric, tol = 1.5, maximize)
{
  index <- 1:nrow(x)
  if (!maximize) {
    best <- min(x[, metric])
    perf <- (x[, metric] - best)/best * 100
    candidates <- index[perf < tol]
    bestIter <- min(candidates)
  }
  else {
    best <- max(x[, metric])
    perf <- (x[, metric] - best)/best * -100
    candidates <- index[perf < tol]
    bestIter <- min(candidates)
  }
  bestIter
}
