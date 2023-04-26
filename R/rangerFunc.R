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
    loadNamespace("tidyverse")
    object %>%
      ranger::importance() %>%
      enframe(name = "var", value = "Overall") %>%
      arrange(desc(Overall)) %>%
      as.data.frame()
  },
  selectSize = pickSizeBest,
  selectVar = pickVars,
  summary = improvedSummary
)
