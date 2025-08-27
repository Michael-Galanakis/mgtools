#' @export
deluxe_sub = \(text, regex, replace) sub(regex, replace, text, perl=TRUE)

#' @export
deluxe_gsub = \(text, regex, replace) gsub(regex, replace, text, perl=TRUE)

#' @export
deluxe_split = \(text, sep) strsplit(text, split=sep)[[1]]

#' @export
deluxe_substr = \(text, i_start, i_end) substr(text, i_start, i_end)[[1]]

#' Filter character vector for regex matches
#'
#' @export
deluxe_filter = \(x_character, pattern, perl=TRUE, ...) x_character[grep(pattern, x_character, perl=perl, ...)]
