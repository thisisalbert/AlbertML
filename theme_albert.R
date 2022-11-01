theme_albert <- theme(
  text = element_text(size = ifelse(exists("font_size"), font_size, 12), color = "black"),
  axis.text = element_text(size = ifelse(exists("font_size"), font_size, 12), color = "grey40"),
  panel.background = element_rect(fill = NA),
  panel.grid = element_line(color = "grey80"),
  panel.border = element_rect(fill = NA, size = 1.25),
  plot.title = element_text(face = "bold", size = ifelse(exists("font_size"), font_size*1.3, 12*1.3)),
  plot.subtitle = element_text(color = "grey40", size = ifelse(exists("font_size"), font_size*1.15, 12*1.15)),
  plot.caption = element_text(color = "grey40")
)
