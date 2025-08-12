#' @export
add_axis_table = \(plot.main, axis.table) {
  id.variable = names(axis.table)[1]
  statistic.variables = names(axis.table)[-1]

  axis.table.long = axis.table |>
    melt(id.vars = id.variable, measure.vars = statistic.variables)

  new_level_order = axis.table.long$variable |> levels() |> rev()
  axis.table.long$variable = axis.table.long$variable |> factor(levels = new_level_order)

  plot.axis.table = axis.table.long |>
    ggplot(aes(cyl, variable, label=value)) +
    geom_text() +
    labs(y = "", x = NULL) +
    theme_minimal() +
    theme(axis.line = element_blank(), axis.ticks = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(colour = 'black'),
      panel.grid = element_blank(), strip.text = element_blank())

  plot.theme = theme_minimal() + theme(axis.title.x = element_blank())
  patchwork::wrap_plots(plot.main + plot.theme, plot.axis.table, ncol=1, heights = c(6,1))
}
