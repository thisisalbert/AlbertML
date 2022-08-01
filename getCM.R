getCM <- function(
    model, 
    prob_preds, 
    real_labels, 
    id_obs, 
    case, 
    type_opt
) {
  
  if (length(model$levels) > 2) {
    
    multiclass <- TRUE
    control <- "the_rest"
    real_labels <- factor(
      x = ifelse(real_labels == case, case, control), 
      levels = c(case, control)
    )
    
  } else {
    
    multiclass <- FALSE
    control <- model$levels %>% 
      str_subset(case, negate = TRUE)
    
  }
  
  if (is.numeric(type_opt)) {
    
    custom_pred <- factor(
      x = ifelse(prob_preds[[case]] > type_opt, case, control), 
      levels = c(case, control)
    )
    
    cm <- caret::confusionMatrix(
      data = custom_pred,
      reference = real_labels,
      positive = case
    )
    
    return(c(cm, type_opt = type_opt))
    
  }
  
  if (type_opt %in% c("misclasserror", "Both", "Ones", "Zeros")) {
    
    threshold <- InformationValue::optimalCutoff(
      actuals = ifelse(model$pred$obs == case, 1, 0),
      predictedScores = model$pred[[case]],
      optimiseFor = type_opt,
      returnDiagnostics = TRUE
    )
    
    custom_pred <- factor(
      x = ifelse(prob_preds[[case]] > threshold$optimalCutoff, case, control), 
      levels = c(case, control)
    )
    
    cm <- caret::confusionMatrix(
      data = custom_pred,
      reference = real_labels,
      positive = case
    )
    
    return(c(cm, type_opt = type_opt, threshold, tibble(id_obs = id_obs)))
    
  }
  
}
