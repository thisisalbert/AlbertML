rangerFunc <- list(
  fit = function(x, y, first, last, ...){
    loadNamespace("ranger")
    dat <- if (is.data.frame(x)) x else as.data.frame(x)
    dat$.outcome <- y
    ranger::ranger(
      formula = .outcome ~ .,
      data = dat,
      importance = "impurity",
      probability = TRUE,
      ...
    )
  },
  pred = function(object, x){
    if (!is.data.frame(x)) x <- as.data.frame(x)
    prob <- predict(object, x)$predictions
    raws <- as.factor(colnames(prob)[apply(prob, 1, which.max)])
    cbind(data.frame(pred = raws), as.data.frame(prob))
  },
  rank = function(object, x, y){
    vimp <- data.frame(ranger::importance(object))
    colnames(vimp) <- "Overall"
    vimp$var <- rownames(vimp)
    vimp <- vimp[order(vimp$Overall, decreasing = TRUE), , drop = FALSE]
    rownames(vimp) <- NULL
    vimp <- vimp[, c("var", "Overall")]
    return(vimp)
  },
  selectSize = caret::pickSizeBest,
  selectVar = caret::pickVars,
  summary = improvedSummary
)
