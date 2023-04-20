extendedSummary_RFE <- 
  function(data, lev = NULL, model = NULL) {
    
    ROC = try(
      pROC::roc(data$obs, data[, lev[1]], direction = '>', quiet = TRUE),
      silent = TRUE
    )
    ROC = if (inherits(ROC, 'try-error')) NA else ROC$auc
    Sensitivity = caret::sensitivity(data[, "pred"], data[, "obs"], lev[1])
    Specificity = caret::specificity(data[, "pred"], data[, "obs"], lev[2])
    Accuracy = caret::postResample(data[, 'pred'], data[, 'obs'])[['Accuracy']]
    Kappa = caret::postResample(data[, 'pred'], data[, 'obs'])[['Kappa']]
    F1 = caret::F_meas(data[, 'pred'], data[, 'obs'])
    Balanced_Accuracy = (Sensitivity + Specificity)/2
    
    prevalence = seq(0.1, 0.5, 0.1)
    
    PPVs = map_dbl(
      .x = prevalence,
      .f = ~ (Sensitivity * .x) / (Sensitivity * .x + (1 - Specificity) * (1 - .x))
    ) %>% 
      setNames(paste0('PPV_Prevalence_', prevalence))
    
    NPVs = map_dbl(
      .x = prevalence,
      .f = ~ (Specificity * (1 - .x))/(Specificity * (1 - .x) + (1 - Sensitivity) * .x)
    ) %>% 
      setNames(paste0('NPV_Prevalence_', prevalence))
    
    return(
      c(
        Accuracy = Accuracy, 
        Balanced_Accuracy = Balanced_Accuracy, 
        Kappa = Kappa,
        ROC = ROC,
        Sensitivity = Sensitivity,
        Specificity = Specificity,
        F1 = F1,
        PPVs,
        NPVs
      )
    )
    
  }
