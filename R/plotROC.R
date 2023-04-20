plotROC <- function(df, title) {

  df %>%
    pull(roc_curve) %>%
    chuck(1) %>%
    ggplot(aes(x = FPR, y = TPR, color = Threshold)) +
    geom_path(size = 2, linejoin = "round", lineend = "round") +
    geom_abline(slope = 1, intercept = 0, color = "darkgrey", size = 1) +
    geom_label(
    aes(x = 0.5, y = 0.5, label = paste0("AUROC = ", roc_value)),
    size = 14,
    label.size = 1,
    color = "black"
    ) +
    coord_fixed() +
    scale_color_gradientn(colors = rainbow(5), limits = c(0, 1)) +
    labs(title = title) +
    theme(
      text = element_text(size = font_size, color = "black"),
      plot.title = element_text(face = "bold", hjust = 0.5),
      panel.border = element_rect(fill = NA, size = 2, color = "black"),
      panel.background = element_rect(fill = "white"),
      panel.grid = element_blank(),
      axis.title = element_text(face = "bold"),
      legend.title = element_blank(),
      legend.position = "bottom",
      legend.direction = "horizontal",
      legend.key.width = unit(2, "cm")
    )

}
