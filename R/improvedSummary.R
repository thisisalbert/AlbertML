improvedSummary <- function(data, lev = NULL, model = NULL) {
  
  # AUROC (based on caret's twoClassSummary function)
  
  if (length(lev) > 2) {
    stop(paste("Your outcome has", length(lev), "levels. The twoClassSummary() function isn't appropriate."))
  }
  
  requireNamespaceQuietStop("pROC")
  
  if (!all(levels(data[, "pred"]) == lev)) {
    stop("levels of observed and predicted data do not match")
  }
  
  rocObject <- try(pROC::roc(data$obs, data[, lev[1]], direction = ">", quiet = TRUE), silent = TRUE)
  rocAUC <- if (inherits(rocObject, "try-error")) NA else rocObject$auc
  
  # Rest of metrics (based on caret's functionalities)
  
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
    AUROC = rocAUC,
    Sensitivity = Sensitivity,
    Specificity = Specificity,
    F1 = F1
  ))
  
}
