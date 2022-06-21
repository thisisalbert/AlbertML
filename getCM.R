getCM <- function(model, prob_preds, reference, case, control, type_opt = 0.5) {

library(caret)
library(InformationValue)

threshold <- InformationValue::optimalCutoff(
    actuals = ifelse(model$pred$obs == case, 1, 0),
    predictedScores = model$pred[[case]],
    optimiseFor = type_opt
  )
  
  custom_pred <- factor(
    x = ifelse(prob_preds[[case]] > threshold, case, control), 
    levels = c(case, control)
  )
  
  caret::confusionMatrix(
    data = custom_pred,
    reference = reference,
    positive = case
  )

}
