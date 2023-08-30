getMeanResML <- function(df, comparison) {
  df %>%
    filter(Comparison == comparison) %>%
    select(-Model) %>%
    mutate(across(AUROC:F1, ~ calcConfInt(.x, perc = 0.95), .names = "{.col} 95% CI")) %>%
    mutate(PrevalencePPVandNPV(
      Sens = Sensitivity, Spec = Specificity, Min_Prevalence = 0.1, Max_Prevalence = 0.5
    )) %>%
    mutate(across(c(
      AUROC, Accuracy, Balanced_Accuracy, Kappa, Sensitivity, Specificity, F1,
      matches("^PPV|^NPV")
    ), ~ mean(.x, na.rm = TRUE))) %>%
    distinct(AUROC, .keep_all = TRUE) %>%
    select(
      Comparison, matches("^AUROC"), matches("^Acc"), matches("^Bal"), matches("^Kappa"),
      matches("^Sens"), matches("^Spec"), matches("^F1"), matches("^PPV"), matches("^NPV"),
      everything()
    )
}
