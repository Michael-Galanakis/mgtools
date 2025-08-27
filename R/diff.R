#' @import diffobj
#' @import waldo
#' @import data.table

#' @title Difference between directory contents
#'
#' @param x path to folder
#' @param y path to folder
#' @export
diff_folder = \(x, y, ...) {
  x.files = list.files(path = x, ...) |> sort()
  y.files = list.files(path = y, ...) |> sort()
  diffobj::diffChr(x.files, y.files)
}

#' Difference between directory contents (hash)
#'
#' @param x path to folder
#' @param y path to folder
#' @export
diff_folder_hash = \(x, y, diff_list = FALSE, useWaldo = FALSE, ...) {
  x.ds = create_file_ds(x, hash = TRUE, modified = FALSE, ...)
  y.ds = create_file_ds(y, hash = TRUE, modified = FALSE, ...)

  if (useWaldo) {
    waldo::compare(x.ds, y.ds)
  }
  if (diff_list) {
    full.ds = merge(x.ds, y.ds, by='progname')
    result = with(full.ds, progname[file_hash.x != file_hash.y])
    return(result)
  }
  else {
    x.header = deparse(substitute(x))
    y.header = deparse(substitute(y))
    diffobj::diffPrint(x.ds, y.ds, tar.banner = x.header, cur.banner = y.header, mode = 'sidebyside', disp.width=100L)
  }
}

#' Difference between directory contents modified time
#'
#' @param x path to folder
#' @param y path to folder
#' @export
diff_folder_mtime = \(x, y, ...) {
  x.ds = create_file_ds(x, ...)
  y.ds = create_file_ds(y, ...)

  x.header = deparse(substitute(x))
  y.header = deparse(substitute(y))
  diffobj::diffPrint(x.ds, y.ds, tar.banner = x.header, cur.banner = y.header)
}

#' Difference between files in folder
#'
#' @param x path to folder
#' @param y path to folder
#' @export
diff_dir_contents = \(x, y, ...) {
  # derive files
  x.files = list.files(path = x, ...) |> sort()
  y.files = list.files(path = y, ...) |> sort()
  files = intersect(x.files, y.files)

  contents.x  = lapply(files, \(fn) file.path(x, fn) |> readLines())
  contents.y  = lapply(files, \(fn) file.path(y, fn) |> readLines())

  x.header = deparse(substitute(x))
  y.header = deparse(substitute(y))
  diffobj::diffPrint(contents.x, contents.y, banner.tar = x.header, banner.cur = y.header)
}

create_file_ds = \(path, modified = TRUE, hash=FALSE, ...) {
  all.programs = list.files(path=path, full.names = TRUE, ...) |>
    sort()
  progname = substr(all.programs, nchar(path)+1, 1e5)
  result = data.frame(progname)

  if (hash) {
    result$file_hash = sapply(all.programs, \(fn) digest::digest(file = fn), USE.NAMES = FALSE)
  }
  if (modified) {
    result$modified = file.mtime(all.programs) |> as.character()
  }
  return(result)
}
