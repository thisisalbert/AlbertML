# Testing effectiveness of functions in a ML setting
# Albert Garcia Lopez
# 23-04-20

pacman::p_load(tidyverse, caret, rio, mlbench)
invisible(lapply(
  list.files("/mnt/data/albert_ml/AlbertML/R/", full.names = TRUE),
  source
))

# data(Glass)

df <-
  Glass %>%
  as_tibble() %>%
  filter(Type %in% c(1,7)) %>%
  mutate(Type = as.factor(paste0("Type_", Type))) %>%
  mutate(across(-Type, as.numeric)) %>%
  as.data.frame()

# Extended Summary

set.seed(123)
ml_extendedSummary <-
  caret::train(
    x = df %>% select(-Type),
    y = df %>% pull(Type),
    method = "svmLinear",
    preProcess = c("center", "scale"),
    metric = "ROC",
    maximize = TRUE,
    tuneLength = 10,
    trControl = trainControl(
      method = "cv",
      number = 5,
      search = "random",
      returnData = TRUE,
      classProbs = TRUE,
      returnResamp = "all",
      savePredictions = "all",
      summaryFunction = extendedSummary,
      selectionFunction = "best",
      allowParallel = TRUE,
      seeds = makeCVseeds(type = "tuneLength", tunes = 10, numCV = 5)
    )
  )

ml_extendedSummary_df <-
  ml_extendedSummary %>%
  chuck("resample") %>%
  as_tibble() %>%
  filter(C == ml_extendedSummary$bestTune$C) %>%
  summarise(across(-Resample, ~ mean(.x, na.rm = TRUE))) %>%
  select(Accuracy, Balanced_Accuracy, Kappa, ROC, Sensitivity, Specificity, F1)

# Custom Summary

set.seed(123)
ml_customSummary <-
  caret::train(
    x = df %>% select(-Type),
    y = df %>% pull(Type),
    method = "svmLinear",
    preProcess = c("center", "scale"),
    metric = "ROC",
    maximize = TRUE,
    tuneLength = 10,
    trControl = trainControl(
      method = "cv",
      number = 5,
      search = "random",
      returnData = TRUE,
      classProbs = TRUE,
      returnResamp = "all",
      savePredictions = "all",
      summaryFunction = customSummary,
      selectionFunction = "best",
      allowParallel = TRUE,
      seeds = makeCVseeds(type = "tuneLength", tunes = 10, numCV = 5)
    )
  )

ml_customSummary_df <-
  ml_customSummary %>%
  chuck("resample") %>%
  as_tibble() %>%
  filter(C == ml_customSummary$bestTune$C) %>%
  summarise(across(-Resample, ~ mean(.x, na.rm = TRUE))) %>%
  select(
    Accuracy, Balanced_Accuracy, Kappa, ROC,
    Sensitivity = Sens, Specificity = Spec, F1
  )

identical(x = ml_extendedSummary_df, y = ml_customSummary_df)
