theme_albert <- theme(
  text = element_text(size = ifelse(exists("font_size"), font_size, 14), color = "black"),
  axis.text = element_text(size = ifelse(exists("font_size"), font_size, 14), color = "grey40"),
  panel.background = element_rect(fill = NA),
  panel.grid = element_line(color = "grey80"),
  panel.border = element_rect(fill = NA, size = 1.25),
  plot.title = element_text(face = "bold", size = ifelse(exists("font_size"), font_size*1.2, 14*1.2)),
  plot.subtitle = element_text(color = "grey40", size = ifelse(exists("font_size"), font_size*1.1, 14*1.1)),
  plot.caption = element_text(color = "grey40")
)
