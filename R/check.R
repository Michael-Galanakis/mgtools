#' check variables of dataset
#'
#' @param ds data.frame name (string)
#' @param v variable name (string)
#' @param f  the check to be performed (function)
#' @param x  optional second argument to `f`
#' @export
check = \(ds, v, f, x=NULL) {
  # derive conditional
  ds_tmp = get(ds) |> data.table()

  if (is.null(x))
    cond = ds_tmp[, f(get(v)) |> all()]
  else
    cond = ds_tmp[, f(get(v), x) |> all()]

  # derive test_name
  f_name = deparse(substitute(f))
  test_name = paste0(ds, '$', v, ' ', f_name, ' ', x)

  # test
  if (!cond) stop(test_name, ' FAILED')
  else message(test_name, ' PASSED')
}
