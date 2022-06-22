PrevalencePPVandNPV <- function(
    Metric, Sens, Spec, Min_Prevalence = 0.1, Max_Prevalence = 0.5
) {

  if (!Metric %in% c("PPV", "NPV")) {
    stop("Metric can't only be either PPV or NPV!")
  }

  prevalence = seq(from = Min_Prevalence, to = Max_Prevalence, by = 0.1)

  if (Metric == "PPV") {

    PPV = map(
      .x = prevalence,
      .f = ~ (Sens * .x) / (Sens * .x + (1 - Spec) * (1 - .x))
    ) %>%
      setNames(paste0("PPV_Prevalence_", prevalence)) %>%
      bind_cols()

    return(PPV)

  }

  if (Metric == "NPV") {

    NPV = map(
      .x = prevalence,
      .f = ~ (Spec * (1 - .x))/(Spec * (1 - .x) + (1 - Sens) * .x)
    ) %>%
      setNames(paste0("NPV_Prevalence_", prevalence)) %>%
      bind_cols()

    return(NPV)

  }

}
