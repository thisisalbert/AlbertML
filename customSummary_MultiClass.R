customSummary_MultiClass <- function(data, lev = NULL, model = NULL){

  default <- caret::defaultSummary(data, lev, model)
  ppv <- caret::posPredValue(data[, "pred"], data[, "obs"])
  names(ppv) <- "PPV"
  npv <- caret::negPredValue(data[, "pred"], data[, "obs"])
  names(npv) <- "NPV"
  f_score <- caret::F_meas(data[, "pred"], data[, "obs"])
  names(f_score) <- "F1"
  return(c(default, ppv, npv, f_score))
  
}
