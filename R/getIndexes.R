getIndexes <- function(
    train_df = train_set, 
    id = "Sample_ID", 
    outcomes = "Comparison",
    n_cv = n_cv
) {
  trainIndexes <- train_df %>%
    group_by(across(all_of(outcomes))) %>%
    slice_sample(
      n = round(nrow(.) / (n_cv * length(levels(train_df[[outcomes]])))),
      replace = FALSE
    ) %>%
    ungroup() %>% 
    pull(id)
  which(train_df[[id]] %in% trainIndexes)
}
