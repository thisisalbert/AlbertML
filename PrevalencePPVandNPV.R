PrevalencePPVandNPV <- function(
    Sens = Sens, Spec = Spec, Min_Prevalence = 0.1, Max_Prevalence = 0.9
) {
  
  prevalence = seq(Min_Prevalence, Max_Prevalence, 0.1)
  
  PPV = map(
    .x = prevalence,
    .f = ~ (Sens * .x) / (Sens * .x + (1 - Spec) * (1 - .x))
  ) %>%
    setNames(paste0("PPV_Prevalence_", prevalence)) %>%
    bind_cols()
  
  NPV = map(
    .x = prevalence,
    .f = ~ (Spec * (1 - .x))/(Spec * (1 - .x) + (1 - Sens) * .x)
  ) %>%
    setNames(paste0("NPV_Prevalence_", prevalence)) %>%
    bind_cols()
  
  bind_cols(PPV, NPV)
  
}
