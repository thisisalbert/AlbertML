getTestResults <- function(actuals, predictedScores, threshold = 0.5) {

  cm = InformationValue::confusionMatrix(
    actuals = actuals,
    predictedScores = predictedScores,
    threshold = threshold
  ) %>%
    as.data.frame() %>%
    rownames_to_column("predicted") %>%
    pivot_longer(cols = c("0", "1"), names_to = "actuals", values_to = "freq") %>%
    mutate(across(predicted:actuals, ~ case_when(
      .x == "0" ~ control,
      .x == "1" ~ case
    ))) %>%
    mutate(across(predicted:actuals, as.factor))

  auroc = PRROC::roc.curve(
    scores.class0 = predictedScores,
    weights.class0 = actuals,
    curve = TRUE
  )

  metrics = bind_cols(
    auroc %>%
      chuck("auc") %>%
      tibble(ROC = .),
    cm %>%
      filter(predicted == actuals) %>%
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
    select(Accuracy, Kappa, ROC, Sens, Spec, PPV, NPV) %>%
    mutate(Type = "Test", .before = everything())

  return(
    list(
      cm = cm,
      auroc = auroc,
      metric = metrics
    )
  )

}
