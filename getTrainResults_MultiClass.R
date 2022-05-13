getTrainResults_MultiClass <- function(
    model_train = model_train,
    case = case, 
    control = "The rest", 
    threshold = NULL, 
    threshold_type = c("Ones", "Zeros", "Both", "misclasserror"), 
    type = "Train"
) {
  
  actuals <- ifelse(model_train$pred$obs == case, 1, 0)
  predictedScores <- model_train$pred[[case]]
  
  # Set optimal threshold based on model training
  
  if (is.null(threshold)) {
    threshold <- InformationValue::optimalCutoff(
      actuals = actuals,
      predictedScores = predictedScores,
      optimiseFor = threshold_type
    )
  }
  
  # Generate confusion matrix based on optimal cutoff
  
  cm <- InformationValue::confusionMatrix(
    actuals = actuals,
    predictedScores = predictedScores,
    threshold = threshold
  ) %>%
    as.data.frame() %>%
    rownames_to_column("predicted") %>%
    pivot_longer(cols = c("0", "1"), names_to = "truth", values_to = "freq") %>%
    mutate(across(predicted:truth, ~ case_when(
      .x == "0" ~ control,
      .x == "1" ~ case
    ))) %>%
    mutate(across(predicted:truth, ~ factor(.x, levels = c(case, control))))
  
  # Generate AUROC
  
  auroc <- PRROC::roc.curve(
    scores.class0 = predictedScores,
    weights.class0 = actuals,
    curve = TRUE
  )
  
  # Generate metrics based on a specific threshold
  
  metrics <- bind_cols(
    auroc %>%
      chuck("auc") %>%
      tibble(ROC = .),
    cm %>%
      filter(predicted == truth) %>%
      pull(freq) %>%
      sum() %>%
      magrittr::divide_by(sum(cm$freq)) %>%
      tibble(Accuracy = .),
    InformationValue::kappaCohen(
      actuals = actuals,
      predictedScores = predictedScores,
      threshold = threshold
    ) %>%
      magrittr::divide_by(100) %>%
      tibble(Kappa = .),
    InformationValue::precision(
      actuals = actuals,
      predictedScores = predictedScores,
      threshold = threshold
    ) %>%
      tibble(PPV = .),
    InformationValue::npv(
      actuals = actuals,
      predictedScores = predictedScores,
      threshold = threshold
    ) %>%
      tibble(NPV = .),
    InformationValue::sensitivity(
      actuals = actuals,
      predictedScores = predictedScores,
      threshold = threshold
    ) %>%
      tibble(Sens = .),
    InformationValue::specificity(
      actuals = actuals,
      predictedScores = predictedScores,
      threshold = threshold
    ) %>%
      tibble(Spec = .)
  ) %>%
    mutate(F1 = (2 * PPV * Sens)/(PPV + Sens)) %>%
    select(Accuracy, Kappa, ROC, Sens, Spec, PPV, NPV, F1) %>%
    mutate(Bal_Accuracy = (Sens + Spec) / 2, .after = Accuracy) %>% 
    mutate(Type = type, Case = case, .before = everything())
  
  # Output
  
  return(
    list(
      case = case,
      cm = cm,
      auroc = auroc,
      metrics = metrics
    )
  )
  
}
