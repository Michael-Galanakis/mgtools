#' @export
deluxe_sub = \(text, regex, replace) sub(regex, replace, text, perl=TRUE)

#' @export
deluxe_gsub = \(text, regex, replace) gsub(regex, replace, text, perl=TRUE)

#' @export
deluxe_split = \(text, sep) strsplit(text, split=sep)[[1]]

#' @export
deluxe_substr = \(text, i_start, i_end) substr(text, i_start, i_end)[[1]]
