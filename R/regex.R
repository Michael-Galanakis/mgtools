#' Filter away elements of vector that don't match regex expression
#'
#' @param x character vector (or factor)
#' @param expr regex expression
#' @export
regex_filter = \(x, expr, ignore.case=TRUE, ...) x[grepl(expr, x, ignore.case = ignore.case, ...)]


#' Show matches in path
#'
#' @param path directory that should be searched
#' @param regex_expression Regex expression
#' @export
grep_files = \(path, regex_expression, context=0, ...) {
  # initiate dataset
  lines_matching_expression = data.frame(
    file_name = character(),
    line_number = integer(),
    text_line = character())
  files = list.files(path, include.dirs = FALSE, ...)

  # main loop
  for (fn in files) {
    file_lines = file.path(path, fn) |> readLines(warn=FALSE)
    match_line_number = grep(regex_expression, file_lines, ignore.case=TRUE, perl = TRUE)
    # iterate matches
    for (nn in match_line_number) {
      from = max(nn-context,0)
      to = min(nn-context,length(file_lines))
      lines_with_context = from:to
      match_dataset = data.frame(
        file_name = fn,
        line_number = lines_with_context,
        text_line = file_lines[lines_with_context]
      )
      lines_matching_expression = rbind(
        lines_matching_expression,
        match_dataset
      )
    }
  }
  invisible(lines_matching_expression)
}
