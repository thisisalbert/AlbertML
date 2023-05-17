extendedSummary <- function(data, lev = NULL, model = NULL) {
  
  ROC = as.numeric(pROC::roc(data$obs, data[, lev[1]], direction = ">", quiet = TRUE)$auc)
  Sensitivity = caret::sensitivity(data[, "pred"], data[, "obs"])
  Specificity = caret::specificity(data[, "pred"], data[, "obs"])
  Accuracy = caret::postResample(data[, "pred"], data[, "obs"])[["Accuracy"]]
  Kappa = caret::postResample(data[, "pred"], data[, "obs"])[["Kappa"]]
  F1 = caret::F_meas(data[, "pred"], data[, "obs"])
  Balanced_Accuracy = (Sensitivity + Specificity)/2
  
  return(c(
    Accuracy = Accuracy, 
    Balanced_Accuracy = Balanced_Accuracy, 
    Kappa = Kappa,
    ROC = ROC,
    Sensitivity = Sensitivity,
    Specificity = Specificity,
    F1 = F1
  ))

}
