rangerFuncs_withDownsampling <- list(
  fit = function(x, y, first, last, ...) {
    loadNamespace("ranger")
    if (!is.data.frame(x)) x <- as.data.frame(x)
    dat <- caret::downSample(x = x, y = y, list = FALSE, yname = ".outcome")
    model <- ranger::ranger(
      formula = .outcome ~ .,
      data = dat,
      importance = "impurity",
      probability = TRUE,
      ...
    )
    return(list(model = model, dat = dat))
  },
  pred = function(object, ...) {
    model <- object$model
    dat <- object$dat
    newdata <- dat[, !colnames(dat) == ".outcome"]
    prob <- predict(model, newdata)$predictions
    case <- str_subset(colnames(prob), "^inf_pos$|^sepsis_pos$|^od_pos$")
    control <- str_subset(colnames(prob), "^inf_pos$|^sepsis_pos$|^od_pos$", negate = TRUE)
    raws <- factor(x = colnames(prob)[apply(prob, 1, which.max)], levels = c(case, control))
    cbind(data.frame(pred = raws), as.data.frame(prob))
  },
  rank = function(object, ...) {
    vimp <- data.frame(ranger::importance(object$model))
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
