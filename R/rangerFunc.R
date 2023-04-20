# Derived from Max Kuhn's answer here: https://github.com/topepo/caret/issues/555

rangerFunc <- list(
  summary = twoClassSummary,
  fit = function(x, y, first, last, ...){
    loadNamespace('ranger')
    dat <- if (is.data.frame(x)) x else as.data.frame(x)
    dat$.outcome <- y
    ranger::ranger(
      formula = .outcome ~ .,
      data = dat,
      importance = if (first) "impurity" else "none",
      probability = is.factor(y),
      write.forest = TRUE,
      ...
    )
  },
  pred = function(object, x) {
    if (!is.data.frame(x)) {x <- as.data.frame(x)}
    out <- predict(object, x)$predictions
    if (object$treetype == "Probability estimation") {
      out <- cbind(
        pred = colnames(out)[apply(out, 1, which.max)],
        out
      )
    }
    out
  },
  rank = function(object, x, y) {
    if (length(object$variable.importance) == 0) {
      stop("No importance values available") 
    }
    imps <- ranger:::importance(object)
    vimp <- data.frame(
      Overall = as.vector(imps),
      var = names(imps)
    )
    rownames(vimp) <- names(imps)
    vimp <- vimp[order(vimp$Overall, decreasing = TRUE),, drop = FALSE]
    vimp
  },
  selectSize = function(x, metric, tol = 5, maximize) {
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
  },
  selectVar = pickVars
)
