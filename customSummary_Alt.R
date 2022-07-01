customSummary_Alt <- function(data, lev = NULL, model = NULL) {

  default = caret::defaultSummary(data, lev, model)
  twoclass = caret::twoClassSummary(data, lev, model)
  f_score = caret::F_meas(data[, "pred"], data[, "obs"]) %>% setNames("F1")
  bal_acc = (twoclass[["Sens"]] + twoclass[["Spec"]]) / 2 %>% setNames("Bal_Accuracy")
  prevalence = seq(0.1, 0.9, 0.1)
  ppv = map(
      .x = prevalence,
      .f = ~ (twoclass[["Sens"]] * .x) / (twoclass[["Sens"]] * .x + (1 - twoclass[["Spec"]]) * (1 - .x))
    ) %>%
      setNames(paste0("PPV_Prevalence_", prevalence)) %>%
      bind_cols()
  npv = map(
      .x = prevalence,
      .f = ~ (twoclass[["Spec"]] * (1 - .x))/(twoclass[["Spec"]] * (1 - .x) + (1 - twoclass[["Sens"]]) * .x)
    ) %>%
      setNames(paste0("NPV_Prevalence_", prevalence)) %>%
      bind_cols()
      
  return(c(default, twoclass, bal_acc, f_score, ppv, npv))

}
