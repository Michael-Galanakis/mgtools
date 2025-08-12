
#' Selects first n unique values
#'
#' @param x a vector
#' @return a boolean vector
#' @export
record_select = \(x, n=1) x %in% unique(x)[seq_len(n)]
