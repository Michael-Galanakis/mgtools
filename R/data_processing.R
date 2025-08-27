#' @export
dataset_filter_columns = \(dataset, regex, invert=FALSE) {
  column_selection = grep(regex, names(dataset), invert = invert)
  new_columns = names(dataset)[column_selection]
  return(dataset[, ..new_columns])
}
