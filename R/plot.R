#' Adds axis table to a ggplot object
#'
#' @param plot.main Plot you'd like to add an axis table to
#' @param axis.table A table with the x-axis value and the variables that should appear in the table
#' @examples
#' p = ggplot2::qplot(iris$Species, iris$Sepal.Length) + labs(y='Sepal length')
#' iris_summary = data.table(iris)[, .(`Mean` = mean(Sepal.Length) |> round(1), `SD`=sd(Sepal.Length) |> round(2)), Species]
#' add_axis_table(p, iris_summary)
#' @export
add_axis_table = \(plot.main, axis.table) {
  require(ggplot2)
  require(data.table)
  require(patchwork)

  id.variable = names(axis.table)[1]
  statistic.variables = names(axis.table)[-1]

  axis.table.long = axis.table |>
    melt(id.vars = id.variable, measure.vars = statistic.variables)

  new_level_order = axis.table.long$variable |> levels() |> rev()
  axis.table.long$variable = axis.table.long$variable |> factor(levels = new_level_order)

  plot.axis.table = axis.table.long |>
    ggplot(aes(.data[[id.variable]], .data[['variable']], label=value)) +
    geom_text() +
    labs(y = "", x = NULL) +
    theme_minimal() +
    theme(axis.line = element_blank(), axis.ticks = element_blank(), axis.text.x = element_blank(), axis.text.y = element_text(colour = 'black'),
      panel.grid = element_blank(), strip.text = element_blank())

  patchwork::wrap_plots(plot.main, plot.axis.table, ncol=1, heights = c(6,1))
}

