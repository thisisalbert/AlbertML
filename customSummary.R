customSummary <- function(data, lev = NULL, model = NULL){
  
  default <- caret::defaultSummary(data, lev, model)
  twoclass <- caret::twoClassSummary(data, lev, model)
  bal_acc <- (twoclass[["Sens"]] + twoclass[["Spec"]]) / 2
  names(bal_acc) <- "Bal_Accuracy"
  ppv <- caret::posPredValue(data[, "pred"], data[, "obs"])
  names(ppv) <- "PPV"
  npv <- caret::negPredValue(data[, "pred"], data[, "obs"])
  names(npv) <- "NPV"
  f_score <- caret::F_meas(data[, "pred"], data[, "obs"])
  names(f_score) <- "F1"
  
  return(c(default, bal_acc, twoclass, ppv, npv, f_score))
  
}
