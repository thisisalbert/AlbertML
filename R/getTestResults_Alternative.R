getTestResults_Alternative <- function(
    model, 
    prob_preds, 
    real_labels, 
    id_obs,
    case, 
    type_opt = "misclasserror", 
    type = "Test"
) {
  
  cm_obj = getCM(
    model = model, 
    prob_preds = prob_preds, 
    real_labels = real_labels, 
    id_obs = id_obs,
    case = case, 
    type_opt = type_opt
  )
  
  auroc_obj = PRROC::roc.curve(
    scores.class0 = prob_preds[[case]],
    weights.class0 = ifelse(real_labels == case, 1, 0),
    curve = TRUE
  )
  
  return(list(CM = cm_obj, AUROC = auroc_obj))
}
