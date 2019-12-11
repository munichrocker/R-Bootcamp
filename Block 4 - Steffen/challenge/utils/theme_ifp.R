theme_ifp <- function () {
  theme_minimal(base_size = 12, base_family = "Helvetica") %+replace%
  theme(
    panel.background  = element_blank(),
    axis.text = element_text(
      colour = "#666666",
      size = rel(0.8)
    ),
    axis.title.x = element_text(
      face = "bold",
      color = "#666666",
      margin = margin(
        t = 12,
        b = 12/2
      )
    ),
    axis.title.y = element_text(
      face = "bold",
      color = "#666666",
      angle = 90,
      margin = margin(
        r = 12,
        l = 12/2
      )
    ),
    axis.title.y.right = element_text(
      margin = margin(
        r = 12,
        l = 12/2
      )
    ),
    panel.grid.major = element_line(
      size = 0.25,
      linetype = "solid",
      colour = "lightgrey"
    ),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_line(
      size = 0,
      linetype = "solid",
      colour = "transparent"
    ),
    panel.grid.minor.x = element_blank()
  )
}

