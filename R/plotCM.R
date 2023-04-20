plotCM <- function(
    df, x = "Reference", y = "Prediction", label = "Freq", fill = "Status",
    title = NULL, subtitle = NULL, color = "dodgerblue", font_size = 25,
    tile_font_size = 20
) {
  df %>% 
    ggplot(aes_string(x = x, y = y, label = label, fill = fill)) +
    geom_tile(size = 1) +
    geom_text(fontface = "bold", size = tile_font_size, vjust = 0.5, hjust = 0.5) +
    scale_x_discrete(position = "top", expand = c(0,0)) +
    scale_y_discrete(limits = rev, expand = c(0,0)) +
    scale_fill_manual(values = c("Miss" = "white", "Hit" = color)) +
    coord_fixed() +
    labs(title = title, subtitle = subtitle, 
         x = DescTools::StrCap(x), y = DescTools::StrCap(y)) +
    theme(
      text = element_text(size = font_size, color = "black"),
      axis.text = element_text(size = font_size, color = "black"),
      axis.title = element_text(face = "bold", size = font_size, color = "black"),
      axis.ticks = element_blank(),
      legend.position = "none",
      panel.background = element_blank(),
      plot.title = element_text(face = "bold"),
      plot.subtitle = element_text(face = "italic"),
      panel.border = element_rect(color = color, fill = NA, size = 2)
    )
}
