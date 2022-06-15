plotPCABiplot <- function(
    df, color, fill, var_pc1, var_pc2, title = NULL, subtitle = NULL, 
    nbreaks = 20, fontsize = 16
) {
  df %>% 
    ggplot(
      aes_string(x = "PC1", y = "PC2", color = color, fill = fill), 
    ) +
    geom_point(alpha = 0.5) +
    stat_ellipse(geom = "polygon", alpha = 0.05) +
    scale_x_continuous(n.breaks = nbreaks) +
    scale_y_continuous(n.breaks = nbreaks) +
    geom_hline(yintercept = 0, lty = "dashed", color = "black", alpha = 0.2) +
    geom_vline(xintercept = 0, lty = "dashed", color = "black", alpha = 0.2) +
    labs(
      x = paste0("PC1 (", round(var_pc1, 2), "% variance explained)"),
      y = paste0("PC2 (", round(var_pc2, 2), "% variance explained)"),
    ) +
    paletteer::scale_color_paletteer_d("ggthemes::gdoc") +
    paletteer::scale_fill_paletteer_d("ggthemes::gdoc") +
    labs(title = title, subtitle = subtitle) +
    theme_bw() +
    theme(
      text = element_text(size = fontsize),
      plot.title = element_text(face = "bold"),
      legend.title = element_blank(),
      legend.position = "bottom",
      legend.direction = "horizontal"
    )    
}
