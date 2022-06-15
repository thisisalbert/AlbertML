plotPCABiplot <- function(df, color, fill, var_pc1, var_pc2) {
  df %>% 
    ggplot(
      aes_string(x = "PC1", y = "PC2", color = color, fill = fill), 
    ) +
    geom_point(alpha = 0.5) +
    stat_ellipse(geom = "polygon", alpha = 0.1) +
    scale_x_continuous(n.breaks = 25) +
    scale_y_continuous(n.breaks = 25) +
    geom_hline(yintercept = 0, lty = "dashed", color = "gray60") +
    geom_vline(xintercept = 0, lty = "dashed", color = "gray60") +
    labs(
      x = paste0("PC1: ", round(var_pc1, 2), "% var. explained"),
      y = paste0("PC2: ", round(var_pc2, 2), "% var. explained"),
    ) +
    paletteer::scale_color_paletteer_d("ggthemes::gdoc") +
    paletteer::scale_fill_paletteer_d("ggthemes::gdoc") +
    theme_bw() +
    theme(
      legend.title = element_blank(),
      legend.position = "top",
      legend.direction = "horizontal"
    )    
}
