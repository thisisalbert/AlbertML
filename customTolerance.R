customTolerance <- function (x, metric, tol = 5, maximize)
{
  if (!maximize) {
    best <- min(x[, metric])
    perf <- (x[, metric] - best)/best * 100
    flag <- perf <= tol
  }
  else {
    best <- max(x[, metric])
    perf <- (best - x[, metric])/best * 100
    flag <- perf <= tol
  }
  min(x[flag, "Variables"])
}
