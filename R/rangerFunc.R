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
  selectSize = function (x, metric, maximize){
    best <- if (maximize) {
      which.max(x[, metric])
    } else {
      which.min(x[, metric])
    }
    min(x[best, "Variables"])
  },
  selectVar = function (y, size){
    finalImp <- ddply(y[, c("Overall", "var")], .(var), function(x) mean(x$Overall, na.rm = TRUE))
    names(finalImp)[2] <- "Overall"
    finalImp <- finalImp[order(finalImp$Overall, decreasing = TRUE),]
    as.character(finalImp$var[1:size])
  },
  summary = improvedSummary
)
