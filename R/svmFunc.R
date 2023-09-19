svmFunc <- list(
  fit = function(x, y, first, last, ...){
    loadNamespace("caret")
    loadNamespace("e1071")
    dat <- if (is.data.frame(x)) x else as.data.frame(x)
    dat$.outcome <- y
    e1071::svm(
      formula = .outcome ~ .,
      data = dat,
      scale = TRUE,
      kernel = "linear",
      probability = TRUE,
      ...
    )
  },
  pred = function(object, x){
    if (!is.data.frame(x)) x <- as.data.frame(x)
    loadNamespace("e1071")
    prob <- e1071:::predict.svm(object, x, decision.values = TRUE, probability = TRUE)
    prob <- attributes(prob)[["probabilities"]]
    raws <- as.factor(colnames(prob)[apply(prob, 1, which.max)])
    cbind(data.frame(pred = raws), prob)
  },
  rank = function(object, x, y){
    vimp <- t(object[["coefs"]]) %*% object[["SV"]]
    vimp <- apply(vimp, 2, function (x) sqrt(sum(x^2)))
    vimp <- data.frame(sort(vimp, decreasing = TRUE))
    colnames(vimp) <- "Overall"
    vimp$var <- rownames(vimp)
    rownames(vimp) <- NULL
    vimp <- vimp[, c("var", "Overall")]
    return(vimp)
  },
  selectSize = pickSizeBest,
  selectVar = pickVars,
  summary = improvedSummary
)
